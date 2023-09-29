resource "aws_quicksight_data_source" "rds" {
  data_source_id = aws_db_instance.test.db_name
  name           = "DVD rentals demo dataset"

  credentials {
    credential_pair {
      username = aws_db_instance.test.username
      password = aws_db_instance.test.password
    }
  }
  vpc_connection_properties {
    vpc_connection_arn = aws_quicksight_vpc_connection.rds.arn
  }
  parameters {
    rds {
      database    = aws_db_instance.test.db_name
      instance_id = aws_db_instance.test.identifier
    }
  }
  type = "POSTGRESQL"
}
