resource "aws_secretsmanager_secret" "wordpress_password" {
  name = "wordpress_${random_string.suffix.result}"
}

resource "aws_secretsmanager_secret_version" "wordpress_password" {
  secret_id     = aws_secretsmanager_secret.wordpress_password.id
  secret_string = aws_db_instance.rds.password
}

resource "random_string" "suffix" {
  length  = 5
  special = false
}
