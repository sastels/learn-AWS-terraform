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
  region  = var.region
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

resource "aws_key_pair" "ssh-key" {
  key_name   = "ssh-key"
  public_key = var.ssh_public_key
}

resource "aws_instance" "web_server" {
  ami                         = "ami-0a70476e631caa6d3"
  instance_type               = "t2.micro"
  security_groups             = ["${aws_security_group.web.name}"]
  associate_public_ip_address = true
  key_name                    = "ssh-key"
  user_data                   = file("bootstrap.sh")
  tags = {
    Name = "terraform web server"
  }
}

output "curl" {
  value = "curl ${aws_instance.web_server.public_dns}"
}
output "ssh" {
  value = "ssh -i ~/.ssh/id_rsa ec2-user@${aws_instance.web_server.public_dns}"
}
