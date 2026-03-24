variable "alb_name" {
    type = string
}

variable "alb_internal" {
    type = bool
    default = false
}

variable "alb_load_balancer_type" {
    type = string
}

variable "alb_subnets" {
    type = list(string)
}

variable "lb_target_group_name" {
    type = string
}

variable "lb_target_group_port" {
    type = number
    default = 80
}

variable "lb_target_group_protocol" {
    type = string
}

variable "lb_target_group_target_type" {
    type = string
}

variable "lb_target_group_vpc" {
    type = string
}



variable "listener_port" {
    type = number
    default = 443
}

variable "listener_protocol" {
    type = string
}

variable "ssl_policy" {
    type = string
}

variable "certificate" {
    type = string
}

variable "default_action_type" {
    type = string
}

variable "listener_port_http" {
    type = number
    default = 80
}

variable "listener_protocol_http" {
    type = string
}


variable "redirect_port" {
    type = number
    default = 443
}

variable "redirect_protocol" {
    type = string
    default = "https"
}

variable "redirect_status_code" {
    type = string
    default = "HTTP_301"
  
}

#HTTPS SG

variable "vpc_id" {
    type = string
  
}
variable "ingress_from_port" {
    type = number
    default = 443
  
}

variable "ingress_to_port" {
    type = number
    default = 443
  
}

variable "ingress_protocol" {
    type = string
    default = "tcp"
}


variable "ingress_cidr_blocks" {
    type = list(string)
    default = ["0.0.0.0/0"]
  
}

#Ingress 80

variable "ingress_from_port_http" {
    type = number
    default = 80
  
}

variable "ingress_to_port_http" {
    type = number
    default = 80
  
}

variable "ingress_protocol_http" {
    type = string
    default = "tcp"
}

variable "ingress_cidr_blocks_http" {
    type = list(string)
    default = ["0.0.0.0/0"]
  
}

#Egress ALL

variable "egress_to_port" {
    type = number
    default = 0
  
}

variable "egress_from_port" {
    type = number
    default = 0
  
}

variable "egress_protocol" {
    type = string
    default = -1
  
}

variable "egress_cidr_blocks" {
    type = list(string)
    default = ["0.0.0.0/0"]
  
}

