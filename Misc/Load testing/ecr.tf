resource "aws_ecr_repository" "example" {
  name = "example"
  image_scanning_configuration {
    scan_on_push = true
  }
}
