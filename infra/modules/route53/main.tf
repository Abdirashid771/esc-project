data "aws_route53_zone" "ecs_zone" {
  name = var.aws_route53_zone_name
}

resource "aws_route53_record" "www" {
  zone_id = data.aws_route53_zone.ecs_zone.id
  name    = var.aws_route53_record_name
  type    = "A"

  alias {
    name                   = var.alias_name
    zone_id                = var.alias_zone_id
    evaluate_target_health = var.alias_evaluate_target_health
  }
}


