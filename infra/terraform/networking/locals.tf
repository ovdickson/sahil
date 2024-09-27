data "aws_caller_identity" "current" {}


locals {
  tags = {
    Env        = var.env
    Project    = var.project
    Owner      = var.owner
    Repository = var.repository
    Script     = "terraform"
  }

  account_id = data.aws_caller_identity.current.account_id

}