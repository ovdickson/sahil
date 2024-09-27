resource "aws_ecs_service" "ecs_service" {
  name            = "${var.service_name}-ecs-service-${var.env}"
  cluster         = var.cluster_id
  task_definition = var.task_definition_arn
  desired_count   = var.desired_counts
  enable_execute_command = var.enable_execute_command
  health_check_grace_period_seconds = var.health_check_grace_period_seconds
  lifecycle {
  ignore_changes = [desired_count, capacity_provider_strategy, task_definition, load_balancer]
  }

  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

## Spread tasks evenly accross all Availability Zones for High Availability
  ordered_placement_strategy {
    type  = "spread"
    field = "attribute:ecs.availability-zone"
  }
  
  ## Make use of all available space on the Container Instances
  ordered_placement_strategy {
    type  = "binpack"
    field = "memory"
  }

   deployment_controller {
     type = "ECS"
    }

  # network_configuration {
  #   subnets          = var.subnet_ids
  #   security_groups  = [var.security_groups]
  #   assign_public_ip = var.assign_public_ip
  # }
  tags = var.tags
}
