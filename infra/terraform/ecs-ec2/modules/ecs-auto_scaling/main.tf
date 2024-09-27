resource "aws_appautoscaling_target" "ecs_auto_sg" {
  max_capacity       = var.max_capacity
  min_capacity       = var.min_capacity
  resource_id        = var.cluster_and_service_id
  scalable_dimension = var.scalable_dimension
  service_namespace  = var.service_namespace
}

resource "aws_appautoscaling_policy" "ecs_asg_scale_down_policy" {
  name               = "${var.ecs_family}-${var.env}-asg-policy"
  policy_type        = var.policy_type
  resource_id        = aws_appautoscaling_target.ecs_auto_sg.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_auto_sg.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_auto_sg.service_namespace

  # target_tracking_scaling_policy_configuration {
  #   predefined_metric_specification {
  #     predefined_metric_type = "ECSServiceAverageCPUUtilization"
  #   }
  #   target_value = 40
  # }

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_upper_bound = 0
      scaling_adjustment          = -1
    }
  }
}

resource "aws_appautoscaling_policy" "ecs_asg_scale_up_policy" {
  name               = "${var.ecs_family}-${var.env}-asg-scale-up-policy"
  policy_type        = var.policy_type
  resource_id        = aws_appautoscaling_target.ecs_auto_sg.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_auto_sg.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_auto_sg.service_namespace

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }
}

resource "aws_cloudwatch_metric_alarm" "sahil_high_cpu_alarm" {
alarm_name = "${var.ecs_family}-${var.env}-high-cpu"
alarm_description = "Monitors ECS Memory Utilization"

comparison_operator = "GreaterThanOrEqualToThreshold"
evaluation_periods = "1"
metric_name = "CPUUtilization"
namespace = "AWS/ECS"
period = "60"
statistic = "Average"
threshold = 70
//ARN of the policy
alarm_actions = [
  aws_appautoscaling_policy.ecs_asg_scale_up_policy.arn
  ]
dimensions = {
  "ClusterName" = var.cluster_name
  "ServiceName" = var.service_name
  }
}

resource "aws_cloudwatch_metric_alarm" "sahil_low_cpu_alarm" {
alarm_name = "${var.ecs_family}-${var.env}-low-cpu"
alarm_description = "Monitors ECS Memory Utilization"

comparison_operator = "LessThanOrEqualToThreshold"
evaluation_periods = "2"
metric_name = "CPUUtilization"
namespace = "AWS/ECS"
period = "60"
statistic = "Average"
threshold = 10
//ARN of the policy
alarm_actions = [
  aws_appautoscaling_policy.ecs_asg_scale_down_policy.arn
  ]
dimensions = {
  "ClusterName" = var.cluster_name
  "ServiceName" = var.service_name
  }
}
