
resource "aws_cloudwatch_log_group" "access" {
  name              = "sja/apache/access"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "error" {
  name              = "sja/apache/error"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "agent" {
  name              = "sja/cloudwatch-agent"
  retention_in_days = 7
}
