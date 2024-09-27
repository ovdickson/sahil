provider "aws" {
  region  = var.region
  assume_role {
    role_arn = "arn:aws:iam::${var.account_id}:role/${var.role_name}"
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
    region         = "eu-west-1"
    key            = "sahil-ecs-infra/{{ENV}}/terraform.tfstate"
  }
}

data "terraform_remote_state" "infra" {
  backend = "s3"

  config = {
    bucket = "sahil-terraform-state-bucket"
    key    = "sahil-vpc-infra/{{ENV}}/terraform.tfstate"
    region = "eu-west-1"
  }
}