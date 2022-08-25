terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

locals {
  region = "eu-west-1"
  ami    = "ami-09e2d756e7d78558d" # Amazon Linux 2
  # region = "us-east-1"
  # ami    = "ami-090fa75af13c156b4" # Amazon Linux 2
}

provider "aws" {
  profile = "default"
  region  = local.region

}

resource "aws_key_pair" "ssh-key" {
  key_name   = "ssh-key"
  public_key = file(var.ssh_public_key_file)
}
