# Listen on SSL port 443
# resource "aws_lb_listener" "sahil_app_listner_443" {
#   load_balancer_arn = aws_lb.aws-alb.arn
#   port              = "443"
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
#   certificate_arn   = data.aws_acm_certificate.auth_api_cert.arn

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.target-group.arn
#   }

#   tags = merge(local.tags, tomap({ "Name" = "${var.cust_name}-api-listner-443" }))
# }

# data "aws_acm_certificate" "auth_api_cert" {
#   domain      = var.domain_name
#   types       = ["AMAZON_ISSUED"]
#   most_recent = true
# }


resource "aws_lb_listener" "alb_listner_80" {
  load_balancer_arn = aws_lb.aws-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn =  module.sahil_graphql_api_tg.ecs_target_group_arn # aws_lb_target_group.target-group.arn
  }

  tags = merge(local.tags, tomap({ "Name" = "${var.cust_name}-api-listner-80" }))
}