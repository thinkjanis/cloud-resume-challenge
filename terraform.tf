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
  region     = "eu-west-2"
  // access_key = ""
  // secret_key = ""
}