#------------------------------------------------------------------------------
# Random String Generator
#------------------------------------------------------------------------------
# Generate a random suffix for globally unique S3 bucket naming
resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
  upper   = false
}

#------------------------------------------------------------------------------
# S3 Static Website Hosting
#------------------------------------------------------------------------------
# Primary S3 bucket for hosting static website content
resource "aws_s3_bucket" "website_bucket" {
  bucket = "${var.s3_prefix}-website-${random_string.bucket_suffix.result}"
  tags   = var.tags
}

#------------------------------------------------------------------------------
# Website Content
#------------------------------------------------------------------------------
# Define source files to be uploaded to S3
locals {
  source_code = fileset("src/", "*")
}

# Upload website content to S3 bucket with appropriate content types
resource "aws_s3_object" "website_content" {
  for_each = { for file in local.source_code : file => file }

  key    = each.key
  bucket = aws_s3_bucket.website_bucket.id
  source = "src/${each.key}"

  # Automatically set content-type based on file extension
  # This ensures proper serving of files by the browser
  content_type = endswith(each.key, ".html") ? "text/html" : (
    endswith(each.key, ".css") ? "text/css" : (
    endswith(each.key, ".js") ? "application/javascript" : (
    endswith(each.key, ".json") ? "application/json" : (
    endswith(each.key, ".png") ? "image/png" : (
    endswith(each.key, ".jpg") ? "image/jpeg" : (
    endswith(each.key, ".svg") ? "image/svg+xml" : "binary/octet-stream"
  ))))))
}

#------------------------------------------------------------------------------
# CloudFront Distribution Configuration
#------------------------------------------------------------------------------
# Origin Access Control for secure S3 access
resource "aws_cloudfront_origin_access_control" "website_oac" {
  name                              = "${var.project_prefix}_website_oac"
  description                       = "Origin Access Control for ${var.project_prefix} Static Website"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# CloudFront distribution for content delivery
resource "aws_cloudfront_distribution" "website_cdn" {
  enabled             = true
  default_root_object = "index.html"
  
  # Configure S3 bucket as the origin
  origin {
    domain_name              = aws_s3_bucket.website_bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.website_oac.id
    origin_id                = "${var.project_prefix}_website_origin"
  }
  
  # Default cache behavior settings
  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "${var.project_prefix}_website_origin"
    viewer_protocol_policy = "redirect-to-https"
    
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }
  
  # Geographical restrictions (none)
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  
  # SSL/TLS certificate configuration
  viewer_certificate {
    cloudfront_default_certificate = true
  }
  
  tags = var.tags
}

#------------------------------------------------------------------------------
# S3 Bucket Policy
#------------------------------------------------------------------------------
# Allow CloudFront to access the S3 bucket
resource "aws_s3_bucket_policy" "website_bucket_policy" {
  bucket = aws_s3_bucket.website_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowCloudFrontServicePrincipal"
        Effect    = "Allow"
        Principal = {
          Service = "cloudfront.amazonaws.com"
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.website_bucket.arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.website_cdn.arn
          }
        }
      }
    ]
  })
}

#------------------------------------------------------------------------------
# Outputs
#------------------------------------------------------------------------------
# CloudFront distribution domain name for website access
output "cloudfront_url" {
  value = aws_cloudfront_distribution.website_cdn.domain_name
}