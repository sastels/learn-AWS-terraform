
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
  #   managed_policy_arns = [aws_iam_policy.SessionManager.arn]
}

#Attach role to an instance profile
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_profile"
  role = aws_iam_role.ec2-role.name
}


# Might be able to user AWS role AmazonSSMRoleForInstancesQuickSetup for all this

