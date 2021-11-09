resource "aws_db_instance" "rds" {
  identifier             = "wordpress"
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t3.micro"
  name                   = "wordpress"
  username               = "wordpress"
  password               = "wordpress"
  parameter_group_name   = "default.mysql5.7"
  skip_final_snapshot    = true
  apply_immediately      = true
  vpc_security_group_ids = [aws_security_group.rds.id]
}

output "rds" {
  value = "mysql -u foo -p -h ${aws_db_instance.rds.address}\n"
}
