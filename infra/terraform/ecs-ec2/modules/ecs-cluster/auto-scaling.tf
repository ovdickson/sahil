
resource "aws_autoscaling_group" "ecs_autoscaling_group" {
  name                  = "${var.cust_name}_ASG_${var.env}"
  max_size              = var.autoscaling_max_size
  min_size              = var.autoscaling_min_size
  vpc_zone_identifier   = var.private_subnet_ids
  health_check_type     = "EC2"
  protect_from_scale_in = true

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupPendingInstances",
    "GroupStandbyInstances",
    "GroupTerminatingInstances",
    "GroupTotalInstances"
  ]

  launch_template {
    id      = aws_launch_template.ecs_launch_template.id
    version = aws_launch_template.ecs_launch_template.latest_version
  }

  instance_refresh {
    strategy = "Rolling"
  }

  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "${var.cust_name}_ASG_${var.env}"
    propagate_at_launch = true
  }
}