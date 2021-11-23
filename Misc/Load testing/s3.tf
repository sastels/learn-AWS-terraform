
resource "aws_s3_bucket" "perf" {
  bucket = "perf-4523432"
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "perf" {
  bucket                  = aws_s3_bucket.perf.id
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}
