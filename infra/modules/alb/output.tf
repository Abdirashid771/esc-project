output "alb_dns_name" {
  value = aws_lb.alb_lb.dns_name
}

output "alb_zone_id" {
  value = aws_lb.alb_lb.zone_id
}

output "alb_target_group_arn" {
  value = aws_lb_target_group.alb_target.arn
}

output "alb_security_group_id" {
  value = aws_security_group.alb_sg.id
}

