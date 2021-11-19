resource "aws_db_instance" "rds" {
  identifier             = "wordpress"
  db_subnet_group_name   = aws_db_subnet_group.DBPrivate.name
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t3.micro"
  name                   = "wordpress"
  username               = "wordpress"
  password               = random_password.password.result
  parameter_group_name   = "default.mysql5.7"
  skip_final_snapshot    = true
  apply_immediately      = true
  vpc_security_group_ids = [aws_security_group.rds.id]
}

output "database_host" {
  value = "${aws_db_instance.rds.address}\n"
}

resource "random_password" "password" {
  length  = 16
  special = true
}
