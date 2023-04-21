terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.64.0"
    }
  }
}

provider "aws" {
  region = "ca-central-1"
}

resource "aws_key_pair" "ssh-key" {
  key_name   = "ssh-key"
  public_key = file(var.ssh_public_key_file)
}
