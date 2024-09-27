# no local zone
data "aws_availability_zones" "available" {
  filter {
    name   = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

resource "aws_subnet" "public_subnet" {
  count                   = 3
  cidr_block              = var.public_cidrs[count.index]
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = merge(local.tags, tomap({ "Name" = "${var.cust_name}-public-subnet-${count.index + 1}" }))
}

# Private Subnet
resource "aws_subnet" "app_priv_subnet" {
  count             = 3
  cidr_block        = var.app_priv_cidrs[count.index]
  vpc_id            = aws_vpc.main.id
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = merge(local.tags, tomap({ "Name" = "${var.cust_name}-private-subnet-${count.index + 1}" }))
}

resource "aws_subnet" "db_priv_subnet" {
  count             = 3
  cidr_block        = var.db_priv_cidrs[count.index]
  vpc_id            = aws_vpc.main.id
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = merge(local.tags, tomap({ "Name" = "${var.cust_name}-db-subnet.${count.index + 1}" }))
}