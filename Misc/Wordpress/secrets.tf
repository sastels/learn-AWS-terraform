resource "aws_secretsmanager_secret" "wordpress_password" {
  name = "wordpress"
}

resource "aws_secretsmanager_secret_version" "wordpress_password" {
  secret_id     = aws_secretsmanager_secret.wordpress_password.id
  secret_string = aws_db_instance.rds.password
}
