
resource "aws_internet_gateway" "WebIG" {
  vpc_id = aws_vpc.Web_VPC.id

  tags = {
    Name = "WebIG"
  }
}
