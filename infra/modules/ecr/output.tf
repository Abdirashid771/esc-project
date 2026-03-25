output "ecr_repository_url" {
  value = aws_ecr_repository.ecs_image.repository_url
}