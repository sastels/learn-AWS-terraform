resource "aws_vpc_peering_connection" "DBtoWeb" {
  vpc_id = aws_vpc.DB_VPC.id
  tags = {
    Name = "DBtoWeb"
  }
  peer_vpc_id = aws_vpc.Web_VPC.id
  auto_accept = true
}

resource "aws_route" "web" {
  route_table_id            = aws_vpc.Web_VPC.main_route_table_id
  destination_cidr_block    = aws_vpc.DB_VPC.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.DBtoWeb.id
}

resource "aws_route" "db" {
  route_table_id            = aws_vpc.DB_VPC.main_route_table_id
  destination_cidr_block    = aws_vpc.Web_VPC.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.DBtoWeb.id
}
