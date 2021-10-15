resource "aws_iam_role" "web_role" {
  name = "web_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Effect = "Allow",
        Sid    = ""
      }
    ]
  })
}

resource "aws_iam_instance_profile" "web_profile" {
  name = "web_profile"
  role = aws_iam_role.web_role.name
}

resource "aws_iam_role_policy" "web_policy" {
  name = "web_policy"
  role = aws_iam_role.web_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:ListAllMyBuckets",
          "s3:GetBucketLocation"
        ],
        Effect   = "Allow",
        Resource = ["arn:aws:s3:::*"]
      },
      {
        Action = [
          "s3:Get*",
          "s3:List*"
        ],
        Effect   = "Allow",
        Resource = ["${aws_s3_bucket.data.arn}/*", aws_s3_bucket.data.arn]
      }
    ]
  })
}
