resource "aws_quicksight_account_subscription" "subscription" {
  account_name          = "quicksight-test-${random_string.suffix.result}"
  authentication_method = "IAM_ONLY"
  edition               = "ENTERPRISE"
  notification_email    = "stephen.astels@cds-snc.ca"
}

resource "aws_quicksight_data_source" "default" {
  depends_on     = [aws_iam_role_policy_attachment.rds-qs-attach]
  data_source_id = "dvdrental"
  name           = "DVD rentals demo dataset"

  credentials {
    credential_pair {
      username = aws_db_instance.test.username
      password = aws_db_instance.test.password
    }
  }
  vpc_connection_properties {
    vpc_connection_arn = aws_quicksight_vpc_connection.example.arn
  }
  parameters {
    rds {
      database    = "dvdrental"
      instance_id = "test"
    }
  }
  type = "POSTGRESQL"
}
