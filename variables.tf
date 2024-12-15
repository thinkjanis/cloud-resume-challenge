#------------------------------------------------------------------------------
# AWS Provider Variables
#------------------------------------------------------------------------------
# AWS region for resource deployment
variable "aws_region" {
  description = "AWS region for all resources"
  type        = string
  default     = "eu-north-1"
}

#------------------------------------------------------------------------------
# Project Configuration
#------------------------------------------------------------------------------
# Prefix used for consistent resource naming
variable "project_prefix" {
  description = "Prefix used for resource naming"
  type        = string
  default     = "js_crc"
}

# S3-specific prefix (following S3 naming rules)
variable "s3_prefix" {
  description = "Prefix for S3 buckets (must be lowercase, no underscores)"
  type        = string
  default     = "js-crc"
}

#------------------------------------------------------------------------------
# Resource Tagging
#------------------------------------------------------------------------------
# Common tags applied to all resources for organization and tracking
variable "tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default = {
    Project     = "Cloud Resume Challenge"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}