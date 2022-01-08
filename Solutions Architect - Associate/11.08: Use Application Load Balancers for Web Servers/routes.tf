resource "aws_route" "public_internet_gateway" {
  route_table_id = aws_vpc.web.main_route_table_id

  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.web.id
}
