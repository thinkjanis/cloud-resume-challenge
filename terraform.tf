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
  # Credentials are defined in Terraform Cloud
}