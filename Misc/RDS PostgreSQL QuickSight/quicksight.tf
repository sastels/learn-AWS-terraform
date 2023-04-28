resource "aws_quicksight_account_subscription" "subscription" {
  account_name          = "quicksight-test-${random_string.suffix.result}"
  authentication_method = "IAM_ONLY"
  edition               = "ENTERPRISE"
  notification_email    = "stephen.astels@cds-snc.ca"
}

resource "aws_quicksight_data_source" "default" {
  data_source_id = "dvdrental"
  name           = "DVD rentals demo dataset"
  #   permission {
  #     actions = ["quicksight:DescribeDataSource", "quicksight:DescribeDataSourcePermissions", "quicksight:PassDataSource"]
  #     principal = 
  #   }
  vpc_connection_properties {
    vpc_connection_arn = aws_vpc.main.arn
  }
  parameters {
    rds {
      database    = "dvdrental"
      instance_id = aws_db_instance.test.id
    }
  }
  type = "POSTGRESQL"
}
