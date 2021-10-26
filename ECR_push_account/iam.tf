

resource "aws_iam_user" "ecr-push" {
  name = "ecr-push-user"
}

resource "aws_iam_group_membership" "ecr" {
  name = "ecr-push-group-membership"
  users = [
    aws_iam_user.ecr-push.name
  ]
  group = aws_iam_group.push-and-pull.name
}

resource "aws_iam_group" "push-and-pull" {
  name = "ecr-push-group"
}

resource "aws_iam_group_policy_attachment" "test-attach" {
  group      = aws_iam_group.push-and-pull.name
  policy_arn = aws_iam_policy.ecr-push.arn
}

resource "aws_iam_policy" "ecr-push" {
  name        = "ecr-push-policy"
  description = "Allow push to only demo ECR"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowPushPull",
        "Effect" : "Allow",

        "Action" : [
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
        Resource = "*"
      }
    ]
  })
}

