
resource "aws_default_route_table" "default_route_tab" {
  default_route_table_id = aws_vpc.main.default_route_table_id
  tags                   = merge(local.tags, tomap({ "Name" = "${var.cust_name}-default-route-table" }))
}

resource "aws_route_table" "pub_route_tab" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.tags, tomap({ "Name" = "${var.cust_name}-public-route-table" }))
}

resource "aws_route" "pub_route" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
  route_table_id         = aws_route_table.pub_route_tab.id
}

resource "aws_route_table" "priv_route_tab" {
  vpc_id = aws_vpc.main.id

  tags = merge(local.tags, tomap({ "Name" = "${var.cust_name}-priv-route-table" }))
}

# resource "aws_route" "priv-route" {
#   route_table_id         = aws_route_table.priv_route_tab.id
#   destination_cidr_block = "0.0.0.0/0"
#   nat_gateway_id         = aws_nat_gateway.nat-gw.id
# }

resource "aws_route_table_association" "pub_sub_assoc" {
  count          = 3
  route_table_id = aws_route_table.pub_route_tab.id
  subnet_id      = aws_subnet.public_subnet.*.id[count.index]
  depends_on     = [aws_route_table.pub_route_tab, aws_subnet.public_subnet]
}

# Associate Private Subnet with Private Route Table
resource "aws_route_table_association" "app_priv_sub_assoc" {
  count          = 3
  route_table_id = aws_route_table.priv_route_tab.id
  subnet_id      = aws_subnet.app_priv_subnet.*.id[count.index]
  depends_on     = [aws_route_table.priv_route_tab, aws_subnet.app_priv_subnet]
}

resource "aws_route_table_association" "db_priv_sub_assoc" {
  count          = 3
  route_table_id = aws_route_table.priv_route_tab.id
  subnet_id      = aws_subnet.db_priv_subnet.*.id[count.index]
  depends_on     = [aws_route_table.priv_route_tab, aws_subnet.db_priv_subnet]
}