## Creates IAM Role which is assumed by the Container Instances (aka EC2 Instances)

resource "aws_iam_role" "ec2_instance_role" {
  name               = "${var.cust_name}_EC2_InstanceRole_${var.env}"
  assume_role_policy = data.aws_iam_policy_document.ec2_instance_role_policy.json
}

resource "aws_iam_role_policy_attachment" "ec2_instance_role_policy" {
  role       = aws_iam_role.ec2_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "ec2_instance_role_policy_ssm" {
  role       = aws_iam_role.ec2_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

resource "aws_iam_instance_profile" "ec2_instance_role_profile" {
  name  = "${var.cust_name}_EC2_InstanceRoleProfile"
  role  = aws_iam_role.ec2_instance_role.id
}

data "aws_iam_policy_document" "ec2_instance_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = [
        "ec2.amazonaws.com",
        "ecs.amazonaws.com"
      ]
    }
  }
}