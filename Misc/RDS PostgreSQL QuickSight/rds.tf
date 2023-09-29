resource "aws_db_instance" "test" {
  db_subnet_group_name   = aws_db_subnet_group.database.name
  db_name                = "testdb"
  identifier             = "test-id"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "15.3"
  vpc_security_group_ids = [aws_security_group.rds.id]
  username               = "postgres"
  password               = aws_secretsmanager_secret_version.postgres_password.secret_string
  apply_immediately      = true
  skip_final_snapshot    = true
}

output "psql" {
  value     = <<EOT
   psql postgresql://${aws_db_instance.test.username}:${aws_db_instance.test.password}@${aws_db_instance.test.address}/dvdrental
   EOT
  sensitive = true
}

output "to-see-psql" {
  value = "terraform output -raw psql\n"
}
