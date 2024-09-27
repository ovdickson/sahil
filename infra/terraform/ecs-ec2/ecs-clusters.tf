module "sahil_ecs_cluster" {
    source = "./modules/ecs-cluster"
    env = var.env
    cust_name = var.cust_name
    key_pair = "sahil-key-pair"
    instance_type = "t3.medium"
    autoscaling_min_size = 1
    autoscaling_max_size = 2
    private_subnet_ids = local.private_subnet_ids
    minimum_scaling_step_size = 1
    maximum_scaling_step_size = 2
    target_capacity = 100
    ecs_sub_sg = local.ecs_sub_sg
    log_group_name = aws_cloudwatch_log_group.sahil_cluster_log_grp.name
    tags = merge(local.tags, tomap({ "Name" = "${var.cust_name}-ecs-cluster-${var.env}" }))
}