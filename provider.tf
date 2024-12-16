#------------------------------------------------------------------------------
# Terraform Cloud Configuration
#------------------------------------------------------------------------------
# Define Terraform Cloud workspace settings
terraform { 
  cloud { 
    organization = "thinkjanis" 
    workspaces { 
      name = "cloud-resume-challenge" 
    } 
  } 
}

#------------------------------------------------------------------------------
# Required Providers
#------------------------------------------------------------------------------
# Specify required provider versions and configurations
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

#------------------------------------------------------------------------------
# AWS Provider Configuration
#------------------------------------------------------------------------------
# Configure AWS provider (credentials managed in Terraform Cloud)
provider "aws" {
  region = "eu-west-2"  # London region
}

# US East 1 provider for CloudFront certificate
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}