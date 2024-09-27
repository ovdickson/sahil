output "cluster_arn" {
    value       = aws_ecs_cluster.sahil_ecs_cluster.arn
    description = "cluster arn"
}

output "cluster_name" {
    value       = aws_ecs_cluster.sahil_ecs_cluster.id
    description = "cluster name"
}

output "cluster_id" {
    value       = "${var.cust_name}-ecs-cluster-${var.env}"
    description = "cluster id"
}

output "ecs_cluster_name" {
    value       = aws_ecs_cluster.sahil_ecs_cluster.name
    description = "cluster name"
}