terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "ca-central-1"
}

resource "aws_security_group" "web" {
  name        = "web"
  description = "Web Security Group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_server" {
  ami             = "ami-0a70476e631caa6d3"
  instance_type   = "t2.micro"
  security_groups = ["web"]
  user_data       = <<-EOF
                  #!/bin/bash
                  sudo su
                  yum -y update
                  yum -y install httpd
                  echo "<h1> My web server!! </h1>" >> /var/www/html/index.html
                  systemctl enable httpd
                  systemctl start httpd
                  EOF
  tags = {
    Name = "terraform web server"
  }
}

output "DNS" {
  value = aws_instance.web_server.public_dns
}
