resource "aws_lb" "alb_lb" {
  name               = var.alb_name
  internal           = var.alb_internal
  load_balancer_type = var.alb_load_balancer_type
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.alb_subnets

  enable_deletion_protection = true
  drop_invalid_header_fields = true


}

resource "aws_lb_target_group" "alb_target" {
  name        = var.lb_target_group_name
  port        = var.lb_target_group_port
  protocol    = var.lb_target_group_protocol
  target_type = var.lb_target_group_target_type #ip
  vpc_id      = var.lb_target_group_vpc
}


#HTTPS 443
resource "aws_lb_listener" "https_listener" {
  load_balancer_arn = aws_lb.alb_lb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol
  ssl_policy        = var.ssl_policy
  certificate_arn   = var.certificate

  default_action {
    type             = var.default_action_type
    target_group_arn = aws_lb_target_group.alb_target.arn
  }
}

#HTTP 80
resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.alb_lb.arn
  port              = var.listener_port_http
  protocol          = var.listener_protocol_http

  default_action {
    type = "redirect"

    redirect {
      port        = var.redirect_port
      protocol    = var.redirect_protocol
      status_code = var.redirect_status_code
    }
  }
}

#ALB-SG
resource "aws_security_group" "alb_sg" {
  vpc_id = var.vpc_id

tags = {
    Name = "allow_traffic"
  }


  ingress { #443
    from_port   = var.ingress_from_port
    to_port     = var.ingress_to_port
    protocol    = var.ingress_protocol
    cidr_blocks = var.ingress_cidr_blocks
  }

  ingress { #80
    from_port   = var.ingress_from_port_http
    to_port     = var.ingress_to_port_http
    protocol    = var.ingress_protocol_http
    cidr_blocks = var.ingress_cidr_blocks_http
  }

  egress {
    from_port   = var.egress_from_port
    to_port     = var.egress_to_port
    protocol    = var.egress_protocol
    cidr_blocks = var.egress_cidr_blocks
  }
}