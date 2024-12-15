# S3 Bucket
resource "aws_s3_bucket" "crc-bucket" {
  bucket = "js-crc-3540"
}

# Source files for upload
locals {
  source_code = fileset("src/", "*")
}

# Source file objects for upload
resource "aws_s3_object" "crc-bucket-obejct" {
  for_each = { for file in local.source_code : file => file }

  key = each.key
  bucket = aws_s3_bucket.crc-bucket.id
  source = "src/${each.key}"

  # Set correct content type
  content_type = endswith(each.key, ".html") ? "text/html" : (
    endswith(each.key, ".css") ? "text/css" : (
    endswith(each.key, ".js") ? "application/javascript" : (
    endswith(each.key, ".json") ? "application/json" : (
    endswith(each.key, ".png") ? "image/png" : (
    endswith(each.key, ".jpg") ? "image/jpeg" : (
    endswith(each.key, ".svg") ? "image/svg+xml" : "binary/octet-stream"
  ))))))
}

# CloudFront Origin Access Control
resource "aws_cloudfront_origin_access_control" "crc_oac" {
  name                              = "OAC ${aws_s3_bucket.crc-bucket.bucket}"
  description                       = "Origin Access Control for Static Website"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# CloudFront Distribution
resource "aws_cloudfront_distribution" "crc_distribution" {
  enabled             = true
  default_root_object = "index.html"
  
  origin {
    domain_name              = aws_s3_bucket.crc-bucket.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.crc_oac.id
    origin_id                = "S3Origin"
  }
  
  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = "S3Origin"
    viewer_protocol_policy = "redirect-to-https"
    
    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }
  }
  
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
  
  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

# S3 bucket policy for CloudFront access
resource "aws_s3_bucket_policy" "allow_crc_cloudfront_access" {
  bucket = aws_s3_bucket.crc-bucket.id
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
        Resource = "${aws_s3_bucket.crc-bucket.arn}/*"
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.crc_distribution.arn
          }
        }
      }
    ]
  })
}

# Output the CloudFront URL
output "cloudfront_url" {
  value = aws_cloudfront_distribution.crc_distribution.domain_name
}