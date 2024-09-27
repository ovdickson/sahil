variable "region" {}

variable "account_id" {}

variable "role_name" {
  
}

# variable "devops_account_id" {
#   default = "" 
# }

variable "cust_name" {
  default = "sahil"
}
variable "env" {

}
variable "project" {
  default = "sahil"
}
variable "repository" {
  default = "sahil-ECS-infrastructure"
}
variable "owner" {
  default = "sahil"
}

variable "registry_name" {
  default = "sahil-ecr-registry"
}

variable "domain_name" {
  default = ""
}

variable "version_name" {}

variable "policy_type" {
  default = "StepScaling"
}
variable "scalable_dimension" {
  default = "ecs:service:DesiredCount"
}
variable "service_namespace" {
  default = "ecs"
}
# variable "alb_arn" {}

# variable "vpc_cidr" {}

# variable "public_cidrs" {}

# variable "app_priv_cidrs" {}

# variable "db_priv_cidrs" {}
