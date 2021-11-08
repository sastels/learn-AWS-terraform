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
  region  = "us-west-2"
}

## Private bucket

resource "aws_s3_bucket" "private" {
  bucket = "private-4523432"
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "s3Private" {
  bucket                  = aws_s3_bucket.private.id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

## Public bucket

resource "aws_s3_bucket" "public" {
  bucket = "public-4523432"
  acl    = "public-read"
  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_policy" "public" {
  bucket = aws_s3_bucket.public.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource = [
          "arn:aws:s3:::public-4523432/*"
        ]
      }
    ]
  })
}

resource "aws_s3_bucket_object" "images" {
  bucket = aws_s3_bucket.public.id
  acl    = "public-read"
  key    = "images/"
  source = "/dev/null"
}
