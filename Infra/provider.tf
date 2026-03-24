terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.19.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}

terraform {
  backend "s3" {
    bucket  = "ecs-project-terraform-state-0"
    key     = "ecs-project-terraform-locks"
    region  = "eu-west-2"
    encrypt = true
  }
}
