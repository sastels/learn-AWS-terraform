# resource "aws_route_table" "public" {
#   vpc_id = aws_vpc.Web_VPC.id
#   tags = {
#     Name = "public"
#   }
# }

resource "aws_route" "public_internet_gateway" {
  # route_table_id         = aws_route_table.public.id
  route_table_id = aws_vpc.Web_VPC.main_route_table_id

  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.WebIG.id
}

# resource "aws_route_table_association" "public" {
#   subnet_id      = aws_subnet.WebPublic.id
#   route_table_id = aws_route_table.public.id
# }
