resource "aws_vpc" "tf-main-vpc" {
  cidr_block = var.vpc_cidr

  # Optionals
  enable_dns_support   = true
  enable_dns_hostnames = true
  
  tags = {
    Name = "tf-main-vpc"
  }
}
