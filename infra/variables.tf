# ECS
variable "ecs_cluster_name" {
  type = string

}


variable "ecs_task_definition_family" {
  type = string
}

variable "ecs_task_definition_requires_compatibilies" {
  type    = list(string)
  default = ["FARGATE"]
}


variable "ecs_task_definition_cpu" {
  type = number
}

variable "ecs_task_definition_memory" {
  type = number
}

variable "ecs_container_definitions_name" {
  type = string
}

variable "ecs_container_definitions_cpu" {
  type = number
}

variable "ecs_container_definitions_memory" {
  type = number
}

variable "ecs_container_definitions_essential" {
  type    = bool
  default = true
}

variable "containerPort" {
  type    = number
  default = 80
}

variable "hostPort" {
  type    = number
  default = 80
}

variable "aws_region" {
  type    = string
  default = "eu-west-2"
}

#ECS-SG

variable "security_group_name" {
  type = string
}


variable "ingress_from_port_ecs" {
  type = number
}

variable "ingress_to_port_ecs" {
  type = number
}

variable "ingress_protocol_ecs" {
  type = string
}

#EGRESS
variable "egress_from_port_ecs" {
  type = number
}

variable "egress_to_port_ecs" {
  type = number
}

variable "egress_protocol_ecs" {
  type = string
}

#ECS Service

variable "ecs_service_name" {
  type = string
}
variable "ecs_desired_count" {
  type = number
}

variable "ecs_service_launch_type" {
  type = string
}


#loadbalancer settings

variable "container_name" {
  type = string
}

variable "container_port" {
  type    = number
  default = 8080
}

#Network config

variable "assign_public_ip" {
  type    = bool
  default = true
}



# ECR

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

# VPC

variable "vpc_project" {
  type = string
}

variable "public1_cidr_block" {
  type = string
}

variable "availability_zone_1" {
  type    = string
  default = "eu-west-1a"
}

variable "public2_cidr_block" {
  type = string

}

variable "availability_zone_2" {
  type = string
}


variable "private1_cidr_block" {
  type = string
}


variable "private2_cidr_block" {
  type = string
}


variable "private_route_cidr_block" {
  type = string
}

variable "public_route_cidr_block" {
  type = string
}

# ALB
variable "alb_name" {
  type = string
}

variable "alb_internal" {
  type    = bool
  default = false
}

variable "alb_load_balancer_type" {
  type = string
}


variable "lb_target_group_name" {
  type = string
}

variable "lb_target_group_port" {
  type    = number
  default = 80
}

variable "lb_target_group_protocol" {
  type = string
}

variable "lb_target_group_target_type" {
  type = string
}


variable "listener_port" {
  type    = number
  default = 443
}

variable "listener_protocol" {
  type = string
}

variable "ssl_policy" {
  type = string
}


variable "default_action_type" {
  type = string
}

variable "listener_port_http" {
  type    = number
  default = 80
}

variable "listener_protocol_http" {
  type = string
}


variable "redirect_port" {
  type    = number
  default = 443
}

variable "redirect_protocol" {
  type    = string
  default = "HTTPS"
}

variable "redirect_status_code" {
  type    = string
  default = "HTTP_301"

}

#HTTPS SG

variable "ingress_from_port" {
  type    = number
  default = 443

}

variable "ingress_to_port" {
  type    = number
  default = 443

}

variable "ingress_protocol" {
  type    = string
  default = "tcp"
}


variable "ingress_cidr_blocks" {
  type    = list(string)
  default = ["0.0.0.0/0"]

}

#Ingress 80

variable "ingress_from_port_http" {
  type    = number
  default = 80

}

variable "ingress_to_port_http" {
  type    = number
  default = 80

}

variable "ingress_protocol_http" {
  type    = string
  default = "tcp"
}

variable "ingress_cidr_blocks_http" {
  type    = list(string)
  default = ["0.0.0.0/0"]

}

#Egress ALL

variable "egress_to_port" {
  type    = number
  default = 0

}

variable "egress_from_port" {
  type    = number
  default = 0

}

variable "egress_protocol" {
  type    = string
  default = -1

}

variable "egress_cidr_blocks" {
  type    = list(string)
  default = ["0.0.0.0/0"]

}

#ACM

variable "acm_domain_name" {
  type    = string
  default = "tm.esproject.xyz"
}

variable "acm_validation" {
  type    = string
  default = "DNS"
}

variable "create_before_destroy" {
  type    = bool
  default = true
}


variable "allow_overwrite" {
  type    = bool
  default = true
}


variable "value_ttl" {
  type    = number
  default = 60
}



#Route53

variable "aws_route53_zone_name" {
  type    = string
  default = "esproject.xyz"
}

variable "aws_route53_record_name" {
  type    = string
  default = "tm.esproject.xyz"
}



variable "alias_evaluate_target_health" {
  type    = bool
  default = true
}

