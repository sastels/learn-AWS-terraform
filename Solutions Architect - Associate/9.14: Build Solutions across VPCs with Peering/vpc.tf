
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

resource "aws_vpc_peering_connection" "primary2secondary" {
  # Main VPC ID.
  vpc_id = aws_vpc.Web_VPC.id

  # AWS Account ID. This can be dynamically queried using the
  # aws_caller_identity data resource.
  # https://www.terraform.io/docs/providers/aws/d/caller_identity.html
  # peer_owner_id = data.aws_caller_identity.current.account_id

  # Secondary VPC ID.
  peer_vpc_id = aws_vpc.DB_VPC.id

  # Flags that the peering connection should be automatically confirmed. This
  # only works if both VPCs are owned by the same account.
  auto_accept = true
}


resource "aws_route" "primary2secondary" {
  # ID of VPC 1 main route table.
  route_table_id = aws_vpc.Web_VPC.main_route_table_id

  # CIDR block / IP range for VPC 2.
  destination_cidr_block = aws_vpc.DB_VPC.cidr_block

  # ID of VPC peering connection.
  vpc_peering_connection_id = aws_vpc_peering_connection.primary2secondary.id
}

resource "aws_route" "secondary2primary" {
  # ID of VPC 2 main route table.
  route_table_id = aws_vpc.DB_VPC.main_route_table_id

  # CIDR block / IP range for VPC 1.
  destination_cidr_block = aws_vpc.Web_VPC.cidr_block

  # ID of VPC peering connection.
  vpc_peering_connection_id = aws_vpc_peering_connection.primary2secondary.id
}
