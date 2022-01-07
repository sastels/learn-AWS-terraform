
# Web_VPC

resource "aws_vpc" "Web_VPC" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "Web_VPC"
  }
}

resource "aws_subnet" "WebPublic" {
  vpc_id                  = aws_vpc.Web_VPC.id
  cidr_block              = "192.168.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ca-central-1a"

  tags = {
    Name = "WebPublic"
  }
}
