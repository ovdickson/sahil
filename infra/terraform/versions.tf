provider "aws" {
  region  = "eu-west-1"
  assume_role {
    role_arn = "arn:aws:iam::${var.aws_account_id}:role/${var.iam_name}"
  }
}

terraform {
  required_version = "~> 1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.61.0"
    }
  }

  backend "s3" {
    encrypt = true

    backend_s3_bucket         = "sahil-terraform-state-bucket" 
    backend_dynamodb_table    = "sahil-terraform-table-locks"   
    backend_iam_role          = "sahil-deployment-role"  
    aws_region         = "eu-west-1"
  }
}