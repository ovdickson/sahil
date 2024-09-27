
resource "aws_security_group" "endpt-sg" {
  name        = "vpc_endpoint_service_security_group"
  description = "Security Group for VPC endpoint services"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(local.tags, tomap({ "Name" = "${var.cust_name}-endpt-sg" }))
}


# public subnet security group

resource "aws_security_group" "pub-sub-sg" {
  name        = "public_subnet_security_group"
  description = "Security Group for public subnets"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 3000
    to_port     = 3005
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = merge(local.tags, tomap({ "Name" = "${var.cust_name}-pub-sub-sg" }))
}

# private subnet security group
resource "aws_security_group" "priv-sub-sg" {
  name        = "private_subnet_security_group"
  description = "Security Group for private subnets"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
    # security_groups = [data.terraform_remote_state.app_backend.outputs.alb_sg] uncomment later
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
    # security_groups = [data.terraform_remote_state.app_backend.outputs.alb_sg] uncomment later
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = merge(local.tags, tomap({ "Name" = "${var.cust_name}-priv-sub-sg" }))
}

# ecs security group
resource "aws_security_group" "ecs-sub-sg" {
  name        = "ecs_security_group"
  description = "Security Group for ecs"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
    # security_groups = [data.terraform_remote_state.app_backend.outputs.alb_sg] uncomment later
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
    # security_groups = [data.terraform_remote_state.app_backend.outputs.alb_sg] uncomment later
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = merge(local.tags, tomap({ "Name" = "${var.cust_name}-priv-sub-sg" }))
}

# db private subnet security group 
resource "aws_security_group" "db-sub-sg" {
  name        = "database_subnet_security_group"
  description = "Security Group for database subnets"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = merge(local.tags, tomap({ "Name" = "${var.cust_name}-db-sub-sg" }))
}