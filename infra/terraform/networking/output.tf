output "vpc_id" {
  value = aws_vpc.main.id
}

output "pub_sub_1" {
  value = element(aws_subnet.public_subnet.*.id, 1)
}

output "pub_sub_2" {
  value = element(aws_subnet.public_subnet.*.id, 2)
}

output "pub_sub_3" {
  value = element(aws_subnet.public_subnet.*.id, 3)
}

output "app_priv_sub_1" {
  value = element(aws_subnet.app_priv_subnet.*.id, 1)
}

output "app_priv_sub_2" {
  value = element(aws_subnet.app_priv_subnet.*.id, 2)
}

output "app_priv_sub_3" {
  value = element(aws_subnet.app_priv_subnet.*.id, 3)
}

output "db_priv_sub_1" {
  value = element(aws_subnet.db_priv_subnet.*.id, 1)
}

output "db_priv_sub_2" {
  value = element(aws_subnet.db_priv_subnet.*.id, 2)
}

output "db_priv_sub_3" {
  value = element(aws_subnet.db_priv_subnet.*.id, 3)
}

output "pub_sub_sg" {
  value = aws_security_group.pub-sub-sg.id
}

output "priv_sub_sg" {
  value = aws_security_group.priv-sub-sg.id
}

output "db_sub_sg" {
  value = aws_security_group.db-sub-sg.id
}

output "endpt-sg" {
  value = aws_security_group.endpt-sg.id
}

output "ecs_sub_sg" {
  value = aws_security_group.ecs-sub-sg.id
}
