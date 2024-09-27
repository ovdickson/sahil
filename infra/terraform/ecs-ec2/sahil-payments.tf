# ECS service for sahil backend
module "sahil_payments_service" {
    source = "./modules/ecs-service"
    env = var.env
    cust_name = var.cust_name
    service_name = local.sahil_payments_family
    cluster_id = module.sahil_ecs_cluster.cluster_name
    task_definition_arn = module.sahil_payments_taskdef.task_arn
    desired_counts = 1
    enable_execute_command = true
    target_group_arn = module.sahil_payments_tg.ecs_target_group_arn
    subnet_ids = local.private_subnet_ids
    security_groups = local.ecs_sub_sg # to be changed to private endpoint
    assign_public_ip = false
    container_name = module.sahil_payments_taskdef.container_name
    container_port = 3004  # request for this
    health_check_grace_period_seconds = 120
    tags = merge(local.tags, tomap({ "Name" = "${var.cust_name}-${local.sahil_payments_family}-ecs-service-${var.env}" }))
    depends_on = [module.sahil_ecs_cluster, module.sahil_payments_taskdef]
}

# sahil backend task definition
module "sahil_payments_taskdef" {
    source = "./modules/ecs-taskdef"
    env = var.env
    cust_name = var.cust_name
    ecs_family = local.sahil_payments_family
    taskcpu = 256
    taskmem = 512
    tags = merge(local.tags, tomap({ "Name" = "${local.sahil_payments_family}-${var.env}-ecs-task" }))
    role_tags = merge(local.tags, tomap({ "Name" = "${local.sahil_payments_family}-${var.env}-ecs-role" }))
    container_definitions = jsonencode([
        {
            "name" = "${local.sahil_payments_family}-${var.env}",
            "image" = "${var.account_id}.dkr.ecr.eu-west-1.amazonaws.com/sahil-ecr-registry:${local.sahil_payments_family}-${var.env}-latest",
            "essential" = true,
            "portMappings" = [
                {
                    "protocol"      = "tcp",
                    "containerPort" = 3004
                }
            ],
            "entryPoint" = [
                "sh",
                "-c"
            ],
            "command" = [
                "/bin/sh -c \"pnpm i && pnpm run payments:migration:run && pnpm run payments:start:dev\""
            ],
            "environment" = local.sahil_payments_variables,
            "secrets" = local.sahil_payments_env_vars,
            "logConfiguration" = {
                "logDriver" = "awslogs",
                "options"   = {
                    "awslogs-create-group"   = "true",
                    "awslogs-group"          = "ecs/sahil/service/${var.env}/${local.sahil_payments_family}",
                    "awslogs-region"         = "eu-west-1",
                    "awslogs-stream-prefix"  = "ecs"
                }
            }
        }
    ])

    custom_policy_document = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:PutObject"
                ],
            "Resource": "*"
        },
        {
        "Action": [
          "application-autoscaling:*",
          "cloudwatch:*",
          "ecs:*"
        ],
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
}
EOF

}

# sahil backend target group
module "sahil_payments_tg" {
    source = "./modules/ecs-target-group"
    env = var.env
    ecs_family = local.sahil_payments_family
    vpc_id = local.vpc_id
    tg_protocol = "HTTP"
    ecs_tg_port = 3004
    health_path = "/"
    ecs_service_id = module.sahil_payments_taskdef.task_arn
    tags = merge(local.tags, tomap({ "Name" = "${local.sahil_payments_family}-${var.env}-tg" }))
}


module "sahil_payments_asg" {
    source = "./modules/ecs-auto_scaling"
    env = var.env
    cluster_name = module.sahil_ecs_cluster.ecs_cluster_name
    service_name = module.sahil_payments_service.ecs_service_name
    ecs_family = local.sahil_payments_family
    max_capacity = 1
    min_capacity = 0
    cluster_and_service_id = "service/${module.sahil_ecs_cluster.ecs_cluster_name}/${module.sahil_payments_service.ecs_service_name}"
    scalable_dimension = var.scalable_dimension
    service_namespace  = var.service_namespace
    policy_type        = var.policy_type
    target_value = 50
}
