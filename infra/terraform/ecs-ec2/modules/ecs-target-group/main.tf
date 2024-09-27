resource "aws_lb_target_group" "ecs_target_group" {
  name        = "${var.ecs_family}-${var.env}-tg"
  port        = var.ecs_tg_port
  protocol    = var.tg_protocol
  vpc_id      = var.vpc_id
  health_check {
    path                = var.health_path
    # port                = var.ecs_tg_port
    protocol            = var.tg_protocol
    healthy_threshold   = 2
    unhealthy_threshold = 10
    interval            = 30
    timeout             = 29
    matcher             = "200"
  }
  tags = var.tags
}

# Listen on SSL port 443
#
# resource "aws_lb_listener" "sahil_app_listner_443" {
#   load_balancer_arn = aws_lb.aws-alb.arn
#   port              = "443"
#   protocol          = "TCPS"
#   ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
#   certificate_arn   = data.aws_acm_certificate.this.arn

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.target-group.arn
#   }

#   tags = merge(local.tags, tomap({ "Name" = "${var.cust_name}-app-listner-443" }))
# }

# data "aws_acm_certificate" "this" {
#   domain      = var.app_custom_domain_name
#   types       = ["AMAZON_ISSUED"]
#   most_recent = true
# }

