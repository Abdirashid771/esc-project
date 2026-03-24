variable "vpc_project" {
    type = string
}

variable "public1_cidr_block" {
    type = string
}

variable "availability_zone_1" {
    type = string
    default = "eu-west-1a"
}

variable "public2_cidr_block" {
    type = string
}

variable "availability_zone_2" {
    type = string
    default = "eu-west-1b"
}


variable "private1_cidr_block" {
    type = string
}


variable "private2_cidr_block" {
    type = string
}


variable "private_route_cidr_block" {
    type = string
    default = "0.0.0.0/0"
}

variable "public_route_cidr_block" {
    type = string
    default = "0.0.0.0/0"
}