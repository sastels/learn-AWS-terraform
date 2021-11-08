resource "aws_s3_bucket" "data" {
  bucket = "data-4523432"
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "data" {
  bucket                  = aws_s3_bucket.data.id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_object" "test_file" {
  bucket       = aws_s3_bucket.data.id
  key          = "test_file.txt"
  source       = "test_file.txt"
  content_type = "text"
  etag         = filemd5("test_file.txt")
}
