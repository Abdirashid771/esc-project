resource "aws_ecr_repository" "ecs_image" {
  name                 = var.aws_ecr_repository_name
  image_tag_mutability = var.aws_ecr_repository_image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.aws_ecr_repository_scan
  }
}

resource "aws_ssm_parameter" "ecr_url" {
  name        = var.ssm_parameter_name
  description = "ECR repository URL"
  type        = "String"
  value       = aws_ecr_repository.ecs_image.repository_url
}