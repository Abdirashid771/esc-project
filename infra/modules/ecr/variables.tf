variable "aws_ecr_repository_name" {
  type = string
}

variable "aws_ecr_repository_image_tag_mutability" {
  type    = string
  default = "IMMUTABLE"
}

variable "aws_ecr_repository_scan" {
  type    = bool
  default = true
}

variable "ssm_parameter_name" {
  type = string
}