resource "aws_security_group" "ec2" {
  name        = "ec2_security_group"
  description = "EC2 security group"
  vpc_id      = aws_vpc.main.id

  ingress {
    description = "PostgreSQL"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SRE says no :/ 
  # ingress {
  #   description = "SSH"
  #   from_port   = 22
  #   to_port     = 22
  #   protocol    = "tcp"
  #   cidr_blocks = ["0.0.0.0/0"]
  # }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "rds" {
  name        = "rds_security_group"
  description = "RDS security group"
  vpc_id      = aws_vpc.main.id

  # ingress {
  #   description = "PostgreSQL"
  #   from_port   = 5432
  #   to_port     = 5432
  #   protocol    = "tcp"
  #   cidr_blocks = [aws_subnet.public.cidr_block]
  # }

  # egress {
  #   from_port   = 0
  #   to_port     = 0
  #   protocol    = "-1"
  #   cidr_blocks = [aws_subnet.public.cidr_block]
  # }
}


# Quicksight security groups
# following https://cloudcompiled.com/tutorials/amazon-quicksight-rds-vpc/

resource "aws_security_group" "quicksight" {
  name        = "quicksight"
  description = "Allow Quicksight to connect to RDS"
  vpc_id      = aws_vpc.main.id
}

resource "aws_security_group_rule" "quicksight-access-rds-eks" {
  description              = "Connect Quicksight to RDS"
  type                     = "egress"
  protocol                 = "tcp"
  from_port                = 5432
  to_port                  = 5432
  security_group_id        = aws_security_group.quicksight.id
  source_security_group_id = aws_security_group.rds.id
}

resource "aws_security_group_rule" "notification-canada-ca-alb-quicksight-ingress" {
  description              = "Access to Quicksight access through its security group"
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.quicksight.id
  security_group_id        = aws_security_group.rds.id
}
