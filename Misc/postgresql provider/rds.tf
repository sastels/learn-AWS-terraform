resource "aws_db_instance" "database" {
  engine                 = "postgres"
  engine_version         = "14"
  instance_class         = "db.t3.micro"
  allocated_storage      = 10
  max_allocated_storage  = 100
  name                   = "test"
  username               = "postgres"
  password               = random_password.password.result
  port                   = 5432
  identifier             = "test"
  db_subnet_group_name   = aws_db_subnet_group.database.name
  skip_final_snapshot    = true
  apply_immediately      = true
  vpc_security_group_ids = [aws_security_group.rds.id]
}

provider "postgresql" {
  host             = aws_db_instance.database.address
  port             = aws_db_instance.database.port
  username         = aws_db_instance.database.username
  password         = aws_db_instance.database.password
  sslmode          = "require"
  connect_timeout  = 60
  superuser        = false
  expected_version = aws_db_instance.database.engine_version
}

resource "postgresql_role" "user1" {
  name     = "user1"
  login    = true
  password = random_password.password.result
}

resource "random_password" "password" {
  length  = 16
  special = true
}

output "database_host" {
  value = "${aws_db_instance.database.address}\n"
}
