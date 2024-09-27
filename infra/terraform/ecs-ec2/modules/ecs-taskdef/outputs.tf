output "task_arn" {
  description = "task arn"
  value       = aws_ecs_task_definition.ecs_task.arn
}

output "task_revision" {
  description = "task revision"
  value       = aws_ecs_task_definition.ecs_task.revision
}

output "container_name" {
  description = "container_name"
  value       = "${var.ecs_family}-${var.env}"
}

