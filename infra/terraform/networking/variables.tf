variable "region" {}

variable "profile" {}

variable "account_id" {}

variable "role_name" {
  default = "sahil-deployment-role"
}

variable "devops_account_id" {
  default = "" 
}

variable "cust_name" {
  default = "sahil"
}
variable "env" {

}
variable "project" {
  default = "sahil"
}
variable "repository" {
  default = "sahil-vpc-infra"
}
variable "owner" {
  default = "sahil"
}

# variable "alb_arn" {}

variable "vpc_cidr" {}

variable "public_cidrs" {}

variable "app_priv_cidrs" {}

variable "db_priv_cidrs" {}
