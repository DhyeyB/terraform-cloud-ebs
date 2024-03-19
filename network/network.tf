# Network and VPC Setup

# Fetch AZs in the current region
data "aws_availability_zones" "available" {
}

/*====
The VPC
======*/

resource "aws_vpc" "app-vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.app_name}-${var.environment}-vpc"
    Environment = "${var.environment}"
  }
}

/*====
Subnets
======*/
/* Internet gateway for the public subnet */
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.app-vpc.id

  tags = {
    Name        = "${var.app_name}-${var.environment}-igw"
    Environment = "${var.environment}"
  }
}

/* Elastic IP for NAT */
resource "aws_eip" "gw" {
  count      = var.az_count //length of private subnets
  domain   = "vpc"
  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name        = "${var.app_name}-${var.environment}-gw"
    Environment = "${var.environment}"
  }
}

/* NAT */
resource "aws_nat_gateway" "ngw" {
  count         = var.az_count //length of private subnets
  allocation_id = element(aws_eip.gw.*.id, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  depends_on    = [aws_internet_gateway.igw]

  tags = {
    Name        = "${var.app_name}-${var.environment}-ngw"
    Environment = "${var.environment}"
  }
}

/* Public subnet */
resource "aws_subnet" "public" {
  count                   = var.az_count
  cidr_block              = cidrsubnet(aws_vpc.app-vpc.cidr_block, 8, var.az_count + count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  vpc_id                  = aws_vpc.app-vpc.id
  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.app_name}-${var.environment}-public-sub"
    Environment = "${var.environment}"
  }
}

/* Private subnet */
resource "aws_subnet" "private" {
  count                   = var.az_count
  cidr_block              = cidrsubnet(aws_vpc.app-vpc.cidr_block, 8, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  vpc_id                  = aws_vpc.app-vpc.id
  map_public_ip_on_launch = false

  tags = {
    Name        = "${var.app_name}-${var.environment}-private-sub"
    Environment = "${var.environment}"
  }
}

/* Routing table for public subnet */
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.app-vpc.id

  tags = {
    Name        = "${var.app_name}-${var.environment}-rt-public"
    Environment = "${var.environment}"
  }
}

resource "aws_route" "public" {
  count                  = var.az_count #Length of public subnet
  route_table_id         = element(aws_route_table.public.*.id, count.index)
  destination_cidr_block = var.public_route_destination_cidr_block
  gateway_id             = element(aws_internet_gateway.igw.*.id, count.index)
}

resource "aws_route_table_association" "public" {
  count          = var.az_count //length of public subnets
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = element(aws_route_table.public.*.id, count.index)
}

resource "aws_route_table" "private" {
  count  = var.az_count #Length of private subnet
  vpc_id = aws_vpc.app-vpc.id

  tags = {
    Name        = "${var.app_name}-${var.environment}-rt-pivate"
    Environment = "${var.environment}"
  }
}

resource "aws_route" "private" {
  count                  = var.az_count #Length of private subnet
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = var.private_route_destination_cidr_block
  nat_gateway_id         = element(aws_nat_gateway.ngw.*.id, count.index)
}

resource "aws_route_table_association" "private" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}

/* subnet used by rds */
resource "aws_db_subnet_group" "rds_subnet_group" {
  name        = "${var.app_name}-${var.environment}-rds-sb-group"
  description = "${var.app_name} ${var.environment} RDS subnet group"
  subnet_ids  = flatten([aws_subnet.private.*.id])

  tags = {
    Name        = "${var.app_name}-${var.environment}-rds-sb-group"
    Environment = "${var.environment}"
  }
}
