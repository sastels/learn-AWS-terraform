resource "aws_ecr_repository" "repo" {
  name                 = "x-ray-example"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
