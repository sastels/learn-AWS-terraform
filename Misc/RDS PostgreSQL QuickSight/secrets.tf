resource "aws_secretsmanager_secret" "postgres_password" {
  name = "wordpress_${random_string.suffix.result}"
}

resource "aws_secretsmanager_secret_version" "postgres_password" {
  secret_id     = aws_secretsmanager_secret.postgres_password.id
  secret_string = random_password.password.result
}

resource "random_string" "suffix" {
  length  = 5
  special = false
}

resource "random_password" "password" {
  length  = 16
  special = true
}
