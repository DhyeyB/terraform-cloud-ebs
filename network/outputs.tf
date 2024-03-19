# Output Variables for Network

output "vpc_id" {
  value       = concat(aws_vpc.app-vpc.*.id, [""])[0]
  description = "VPC id"
}

output "rds_subnet_group_id" {
  value       = aws_db_subnet_group.rds_subnet_group.id
  description = "Subnet group id for RDS"
}

output "aws_public_subnet_id" {
  value       = aws_subnet.public[0].id
  description = "Public subnet id"
}

output "aws_private_subnet_cidr_block" {
  value       = aws_subnet.private.*.cidr_block
  description = "Private subnet cidr blocks"
}
