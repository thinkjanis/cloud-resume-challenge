#------------------------------------------------------------------------------
# Outputs
#------------------------------------------------------------------------------
# CloudFront distribution domain name for website access
output "cloudfront_url" {
  value = aws_cloudfront_distribution.website_cdn.domain_name
}