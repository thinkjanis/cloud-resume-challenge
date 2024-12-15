terraform { 
  cloud { 
    organization = "thinkjanis" 
    workspaces { 
      name = "cloud-resume-challenge" 
    } 
  } 
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  # Credentials are defined in Terraform Cloud
}