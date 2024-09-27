
resource "aws_lb_listener_rule" "sahil_admin_rule" {
  listener_arn = aws_lb_listener.alb_listner_80.arn
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = module.sahil_admin_tg.ecs_target_group_arn
  }

  condition {
    path_pattern {
      values = ["/admin/*"]
    }
  }
  # lifecycle {
  # ignore_changes = [action] # Allow external changes to happen without Terraform conflicts, particularly around target group.
  # }

  tags = merge(local.tags, tomap({ "Name" = "${var.cust_name}-admin-rule" }))
}


resource "aws_lb_listener_rule" "sahil_client_rule" {
  listener_arn = aws_lb_listener.alb_listner_80.arn
  priority     = 2

  action {
    type             = "forward"
    target_group_arn = module.sahil_client_tg.ecs_target_group_arn
  }

  condition {
    path_pattern {
      values = ["/client/*"]
    }
  }
  # lifecycle {
  # ignore_changes = [action] # Allow external changes to happen without Terraform conflicts, particularly around target group.
  # }

  tags = merge(local.tags, tomap({ "Name" = "${var.cust_name}-client-rule" }))
}


resource "aws_lb_listener_rule" "sahil_agent_rule" {
  listener_arn = aws_lb_listener.alb_listner_80.arn
  priority     = 3

  action {
    type             = "forward"
    target_group_arn = module.sahil_agent_tg.ecs_target_group_arn
  }

  condition {
    path_pattern {
      values = ["/agent/*"]
    }
  }
  # lifecycle {
  # ignore_changes = [action] # Allow external changes to happen without Terraform conflicts, particularly around target group.
  # }

  tags = merge(local.tags, tomap({ "Name" = "${var.cust_name}-agent-rule" }))
}


resource "aws_lb_listener_rule" "sahil_api_rule" {
  listener_arn = aws_lb_listener.alb_listner_80.arn
  priority     = 4

  action {
    type             = "forward"
    target_group_arn = module.sahil_api_tg.ecs_target_group_arn
  }

  condition {
    path_pattern {
      values = ["/api/*"]
    }
  }
  # lifecycle {
  # ignore_changes = [action] # Allow external changes to happen without Terraform conflicts, particularly around target group.
  # }

  tags = merge(local.tags, tomap({ "Name" = "${var.cust_name}-api-rule" }))
}


resource "aws_lb_listener_rule" "sahil_graphql_api_rule" {
  listener_arn = aws_lb_listener.alb_listner_80.arn
  priority     = 5

  action {
    type             = "forward"
    target_group_arn = module.sahil_graphql_api_tg.ecs_target_group_arn
  }

  condition {
    path_pattern {
      values = ["/graphql/*"]
    }
  }
  # lifecycle {
  # ignore_changes = [action] # Allow external changes to happen without Terraform conflicts, particularly around target group.
  # }

  tags = merge(local.tags, tomap({ "Name" = "${var.cust_name}-graphql-rule" }))
}


resource "aws_lb_listener_rule" "sahil_payments_rule" {
  listener_arn = aws_lb_listener.alb_listner_80.arn
  priority     = 6

  action {
    type             = "forward"
    target_group_arn = module.sahil_payments_tg.ecs_target_group_arn
  }

  condition {
    path_pattern {
      values = ["/payments/*"]
    }
  }
  # lifecycle {
  # ignore_changes = [action] # Allow external changes to happen without Terraform conflicts, particularly around target group.
  # }

  tags = merge(local.tags, tomap({ "Name" = "${var.cust_name}-payments-rule" }))
}

resource "aws_lb_listener_rule" "sahil_maps_rule" {
  listener_arn = aws_lb_listener.alb_listner_80.arn
  priority     = 7

  action {
    type             = "forward"
    target_group_arn = module.sahil_maps_tg.ecs_target_group_arn
  }

  condition {
    path_pattern {
      values = ["/maps/*"]
    }
  }
  # lifecycle {
  # ignore_changes = [action] # Allow external changes to happen without Terraform conflicts, particularly around target group.
  # }

  tags = merge(local.tags, tomap({ "Name" = "${var.cust_name}-maps-rule" }))
}

resource "aws_lb_listener_rule" "sahil_website_rule" {
  listener_arn = aws_lb_listener.alb_listner_80.arn
  priority     = 8

  action {
    type             = "forward"
    target_group_arn = module.sahil_website_tg.ecs_target_group_arn
  }

  condition {
    path_pattern {
      values = ["/website/*"]
    }
  }
  # lifecycle {
  # ignore_changes = [action] # Allow external changes to happen without Terraform conflicts, particularly around target group.
  # }

  tags = merge(local.tags, tomap({ "Name" = "${var.cust_name}-website-rule" }))
}