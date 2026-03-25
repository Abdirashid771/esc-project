variable "aws_route53_zone_name" {
  type    = string
  default = "esproject.xyz"
}

variable "aws_route53_record_name" {
  type    = string
  default = "tm.esproject.xyz"
}


variable "alias_name" {
  type = string
}

variable "alias_zone_id" {
  type = string
}


variable "alias_evaluate_target_health" {
  type    = bool
  default = true
}

