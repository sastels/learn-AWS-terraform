resource "aws_secretsmanager_secret" "master_password" {
  name = "master_${random_string.suffix.result}"
}

resource "aws_secretsmanager_secret_version" "master_password" {
  secret_id     = aws_secretsmanager_secret.master_password.id
  secret_string = aws_db_instance.database.password
}


resource "aws_secretsmanager_secret" "user1_password" {
  name = "user1_${random_string.suffix.result}"
}

resource "aws_secretsmanager_secret_version" "user1_password" {
  secret_id     = aws_secretsmanager_secret.user1_password.id
  secret_string = postgresql_role.user1.password
}

resource "random_string" "suffix" {
  length  = 5
  special = false
}
