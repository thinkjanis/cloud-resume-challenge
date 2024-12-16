#------------------------------------------------------------------------------
# Route 53 Nameservers
#------------------------------------------------------------------------------
output "route53_name_servers" {
  value       = aws_route53_zone.main.name_servers
  description = "The nameservers for the Route 53 zone. Add these to Cloudflare."
}

#------------------------------------------------------------------------------
# CloudFront Domain
#------------------------------------------------------------------------------
output "cloudfront_domain" {
  value       = aws_cloudfront_distribution.website_cdn.domain_name
  description = "The CloudFront distribution domain name"
}