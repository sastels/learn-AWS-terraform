##### Use Session manager to connect to EC2
data "aws_iam_policy" "SessionManager" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "sm-role-policy-attach" {
  role       = aws_iam_role.ec2-role.name
  policy_arn = data.aws_iam_policy.SessionManager.arn
}

resource "aws_iam_role" "ec2-role" {
  name = "ec2-session-manager"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.ec2-role.name
}

# Might be able to user AWS role AmazonSSMRoleForInstancesQuickSetup for all this


##### Quicksight connect to RDS

resource "aws_iam_role" "quicksight" {
  name = "quicksight"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "quicksight.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_policy" "quicksight-rds" {
  name        = "rds-access"
  description = "Allow access to RDS"
  policy = jsonencode({

    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "rds-db:connect",
          "rds:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "rds-qs-attach" {
  role       = aws_iam_role.quicksight.name
  policy_arn = aws_iam_policy.quicksight-rds.arn
}
