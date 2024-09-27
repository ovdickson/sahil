provider "aws" {
  region  = "{{REGION}}"
  assume_role {
    role_arn = "arn:aws:iam::{{ACCOUNT_ID}}:role/${var.role_name}"
  }
}

terraform {
  required_providers {
    aws = ">= 4.47"
  }

  backend "s3" {
    encrypt = true

    bucket         = "sahil-terraform-state-bucket"
    dynamodb_table = "sahil-terraform-table-locks"        
    region         = "{{REGION}}"
    key            = "sahil-ecs-infra/{{ENV}}/terraform.tfstate"
  }
}

data "terraform_remote_state" "infra" {
  backend = "s3"

  config = {
    bucket = "sahil-terraform-state-bucket"
    key    = "sahil-vpc-infra/{{ENV}}/terraform.tfstate"
    region = "{{REGION}}"
  }
}