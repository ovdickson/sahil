
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.tags, tomap({ "Name" = "${var.cust_name}-igw" }))
}
