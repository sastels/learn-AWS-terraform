
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

# DB_VPC

resource "aws_vpc" "DB_VPC" {
  cidr_block           = "192.160.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "DB_VPC"
  }
}
resource "aws_subnet" "DBPrivate_a" {
  vpc_id            = aws_vpc.DB_VPC.id
  cidr_block        = "192.160.1.0/24"
  availability_zone = "ca-central-1a"

  tags = {
    Name = "DBPrivate_a"
  }
}

resource "aws_subnet" "DBPrivate_b" {
  vpc_id            = aws_vpc.DB_VPC.id
  cidr_block        = "192.160.2.0/24"
  availability_zone = "ca-central-1b"

  tags = {
    Name = "DBPrivate_b"
  }
}

resource "aws_db_subnet_group" "DBPrivate" {
  name       = "database"
  subnet_ids = [aws_subnet.DBPrivate_a.id, aws_subnet.DBPrivate_b.id]

  tags = {
    Name = "DBPrivate"
  }
}

# Peering

resource "aws_vpc_peering_connection" "foo" {
  peer_vpc_id = aws_vpc.Web_VPC.id
  vpc_id      = aws_vpc.DB_VPC.id
  auto_accept = true

  tags = {
    Name = "DBtoWeb"
  }
}
