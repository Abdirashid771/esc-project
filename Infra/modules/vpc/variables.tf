variable "vpc_project" {
    type = string
    default = "10.1.0.0/16"
}

variable "public1_cidr_block" {
    type = string
    default = "10.1.1.0/24"
}

variable "availability_zone_1" {
    type = string
    default = "eu-west-1a"
}

variable "public2_cidr_block" {
    type = string
    default = "10.1.2.0/24"
}

variable "availability_zone_2" {
    type = string
    default = "eu-west-1b"
}


variable "private1_cidr_block" {
    type = string
    default = "10.1.3.0/24"
}


variable "private2_cidr_block" {
    type = string
    default = "10.1.4.0/24"
}


variable "private_route_cidr_block" {
    type = string
    default = "0.0.0.0/0"
}

variable "public_route_cidr_block" {
    type = string
    default = "0.0.0.0/0"
}