variable "acm_domain_name" {
    type = string
    default = "tm.esproject.xyz"
}

variable "acm_validation" {
    type = string
    default = "DNS"
}

variable "allow_overwrite" {
    type = bool
    default = true
}

variable "hosted_zone_id" {
    type = string
}


variable "value_ttl" {
    type = number
    default = 60
}



