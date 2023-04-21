resource "aws_db_instance" "test" {

  db_subnet_group_name   = aws_db_subnet_group.database.name
  db_name                = "test"
  identifier             = "test"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "14.1"
  vpc_security_group_ids = [aws_security_group.rds.id]
  username               = "postgres"
  password               = aws_secretsmanager_secret_version.postgres_password.secret_string
  apply_immediately      = true
  # publicly_accessible    = true
  skip_final_snapshot = true
}


output "database_host" {
  value = "${aws_db_instance.test.address}\n"
}
