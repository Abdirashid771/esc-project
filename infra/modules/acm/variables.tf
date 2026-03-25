variable "acm_domain_name" {
  type = string
}

variable "acm_validation" {
  type    = string
  default = "DNS"
}

variable "allow_overwrite" {
  type = bool
}

variable "hosted_zone_id" {
  type = string
}


variable "value_ttl" {
  type    = number
  default = 60
}



