output "ecs_target_group_id" {
  description = "Id of the ECS service"
  value       = aws_lb_target_group.ecs_target_group.id
}

output "ecs_target_group_name" {
  description = "Id of the ECS service"
  value       = aws_lb_target_group.ecs_target_group.name
}
output "ecs_target_group_arn" {
  description = "Id of the ECS service"
  value       = aws_lb_target_group.ecs_target_group.arn
}