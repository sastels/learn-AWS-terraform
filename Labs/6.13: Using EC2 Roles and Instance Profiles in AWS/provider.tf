# https://devopslearning.medium.com/aws-iam-ec2-instance-role-using-terraform-fa2b21488536

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
