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

resource "aws_key_pair" "ssh-key" {
  key_name   = "ssh-key"
  public_key = var.ssh_public_key
}

resource "aws_default_vpc" "default" {
  tags = {
    Name : "Default VPC"
  }
}
