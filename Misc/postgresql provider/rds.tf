resource "aws_db_instance" "rds" {
  engine                 = "postgres"
  engine_version         = "14"
  instance_class         = "db.t3.micro"
  allocated_storage      = 10
  max_allocated_storage  = 100
  name                   = "postgresExample"
  username               = "postgres"
  password               = random_password.password.result
  port                   = 5432
  identifier             = "test"
  db_subnet_group_name   = aws_db_subnet_group.database.name
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
