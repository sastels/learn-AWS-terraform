resource "aws_iam_role" "web_role" {
  name = "web_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_instance_profile" "web_profile" {
  name = "web_profile"
  role = aws_iam_role.web_role.name
}

resource "aws_iam_role_policy" "web_policy" {
  name = "web_policy"
  role = aws_iam_role.web_role.id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}
