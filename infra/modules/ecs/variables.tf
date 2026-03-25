variable "ecs_cluster_name" {
    type = string
  
}

variable "setting_name" {
    type = string
}

variable "setting_value" {
    type = string
}

variable "ecs_task_definition_family" {
    type = string
}

variable "ecs_task_definition_requires_compatibilies" {
    type = list(string)
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

variable "ecs_container_definitions_image" {
    type = string
}

variable "ecs_container_definitions_cpu" {
    type = number
}

variable "ecs_container_definitions_memory" {
    type = number
}

variable "ecs_container_definitions_essential" {
    type = bool
    default = true
}

variable "containerPort" {
    type = number
    default =80
}

variable "hostPort" {
    type = number
    default =80
}

variable "aws_region" {
  type    = string
}

#ECS-SG

variable "security_group_name" {
    type = string
}

variable "security_group_vpc_id" {
    type = string
}

variable "ingress_from_port_ecs" {
    type = number
}

variable "ingress_to_port_ecs" {
    type = number
}

variable "ingress_protocol_ecs"{
       type = string
}
variable "security_groups"{
       type = string
}


#EGRESS
variable "egress_from_port_ecs" {
    type = number
}

variable "egress_to_port_ecs" {
    type = number
}

variable "egress_protocol_ecs"{
       type = string
}

#ECS Service

variable "ecs_service_name" {
    type = string
}
variable "ecs_desired_count" {
    type = number
}

variable "ecs_service_launch_type"{
       type = string
}


#loadbalancer settings
variable "target_group_arn" {
    type = string
}

variable "container_name" {
    type = string
}

variable "container_port" {
    type = number
    default = 8080
}

#Network config

variable "assign_public_ip"{
       type = bool
       default = true
}

variable "subnets"{
       type = list(string)
}

