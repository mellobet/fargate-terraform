# VPC
resource "aws_vpc" "tf-main-vpc" {
  cidr_block = var.vpc_cidr

  # Optionals
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "tf-main-vpc"
    Environment = var.environment_tag
  }
}


# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.tf-main-vpc.id
}


# Public Subnet
resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.tf-main-vpc.id
  cidr_block              = var.public_subnet1_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone_ps1
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.tf-main-vpc.id
  cidr_block              = var.public_subnet2_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.availability_zone_ps2
}


# Route (all through gw)
resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.tf-main-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

# Route assoc (subnet - route)
resource "aws_route_table_association" "rta_subnet_public" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.rtb_public.id
}

# Create a security group
resource "aws_security_group" "ecs_security_group" {
  name        = "${var.ecs_cluster_name}-HTTP-SG"
  description = "BASIC HTTP SG"
  vpc_id      = aws_vpc.tf-main-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = [var.internet_cidr_blocks]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.internet_cidr_blocks]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = [var.internet_cidr_blocks]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.internet_cidr_blocks]
  }
}
