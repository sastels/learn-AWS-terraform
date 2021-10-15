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

resource "aws_s3_bucket" "website" {
  bucket = "website-4523432"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.website.id
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = ["${aws_s3_bucket.website.arn}/*"]
      }
    ]
  })
}

resource "aws_s3_bucket_object" "index" {
  bucket       = aws_s3_bucket.website.id
  key          = "index.html"
  source       = "index.html"
  content_type = "text"
  etag         = filemd5("index.html")
}

resource "aws_s3_bucket_object" "error" {
  bucket       = aws_s3_bucket.website.id
  key          = "error.html"
  source       = "error.html"
  content_type = "text"
  etag         = filemd5("error.html")
}

