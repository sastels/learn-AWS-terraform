
# Web_VPC

resource "aws_vpc" "web" {
  cidr_block           = "192.168.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "Web"
  }
}

resource "aws_subnet" "web_public_1a" {
  vpc_id                  = aws_vpc.web.id
  cidr_block              = "192.168.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ca-central-1a"

  tags = {
    Name = "Web public 1a"
  }
}

resource "aws_subnet" "web_public_1b" {
  vpc_id                  = aws_vpc.web.id
  cidr_block              = "192.168.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "ca-central-1b"

  tags = {
    Name = "Web public 1b"
  }
}
