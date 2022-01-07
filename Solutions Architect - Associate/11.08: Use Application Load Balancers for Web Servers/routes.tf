resource "aws_route" "public_internet_gateway" {
  route_table_id = aws_vpc.Web_VPC.main_route_table_id

  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.WebIG.id
}
