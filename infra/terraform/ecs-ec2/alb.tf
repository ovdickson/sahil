resource "aws_lb" "aws-alb" {
  name     = "${var.cust_name}-alb"
  internal = false

  security_groups = [
    aws_security_group.sahil_alb_sg.id,
  ]

  subnets = local.public_subnet_ids
  idle_timeout = 120

  ip_address_type    = "ipv4"
  load_balancer_type = "application"

  enable_deletion_protection = false

  tags = merge(local.tags, tomap({ "Name" = "${var.cust_name}-alb" }))
}

