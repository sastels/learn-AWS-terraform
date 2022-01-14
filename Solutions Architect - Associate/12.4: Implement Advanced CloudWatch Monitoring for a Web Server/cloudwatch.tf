
resource "aws_cloudwatch_log_group" "access" {
  name = "apache/access"
}

resource "aws_cloudwatch_log_group" "error" {
  name = "apache/error"
}
