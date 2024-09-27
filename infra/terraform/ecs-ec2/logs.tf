# resource "aws_cloudwatch_log_group" "sahil_log_grp" {
#   name = "${var.cust_name}-cluster-log"
# }

resource "aws_cloudwatch_log_group" "sahil_cluster_log_grp" {
  name = "${var.cust_name}-cluster-log-${var.env}"
}
