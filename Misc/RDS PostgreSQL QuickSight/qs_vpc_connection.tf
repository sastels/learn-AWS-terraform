resource "aws_quicksight_vpc_connection" "rds" {
  depends_on = [ aws_iam_role.vpc_connection_role ]
  vpc_connection_id  = aws_vpc.main.id
  name               = "Quicksight RDS connection"
  role_arn           = aws_iam_role.vpc_connection_role.arn
  security_group_ids = [aws_security_group.quicksight.id]   
  subnet_ids         = [aws_subnet.private.id, aws_subnet.database.id]
}

