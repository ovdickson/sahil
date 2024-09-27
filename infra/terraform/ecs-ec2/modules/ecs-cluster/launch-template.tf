data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-*-x86_64-ebs"]
  }

  owners = ["amazon"]
}

## Launch template for all EC2 instances that are part of the ECS cluster

resource "aws_launch_template" "ecs_launch_template" {
  name                   = "${var.cust_name}_EC2_LaunchTemplate_${var.env}"
  image_id               = data.aws_ami.amazon_linux_2.id
  instance_type          = var.instance_type
  key_name               = var.key_pair
  user_data              = base64encode(data.template_file.user_data.rendered)
  vpc_security_group_ids = [var.ecs_sub_sg]

  iam_instance_profile {
    arn = aws_iam_instance_profile.ec2_instance_role_profile.arn
  }

  monitoring {
    enabled = true
  }
}

data "template_file" "user_data" {
  template = "${file("${path.module}/user_data.sh")}"

  vars = {
    ecs_cluster_name = aws_ecs_cluster.sahil_ecs_cluster.name
  }
}