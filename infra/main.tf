# ECS Module
module "ecs" {
  source = "./modules/ecs"

  ecs_cluster_name                           = var.ecs_cluster_name
  ecs_task_definition_family                 = var.ecs_task_definition_family
  ecs_task_definition_requires_compatibilies = var.ecs_task_definition_requires_compatibilies
  ecs_task_definition_cpu                    = var.ecs_task_definition_cpu
  ecs_task_definition_memory                 = var.ecs_task_definition_memory
  ecs_container_definitions_name             = var.ecs_container_definitions_name
  ecs_container_definitions_image            = module.ecr.ecr_repository_url
  ecs_container_definitions_cpu              = var.ecs_container_definitions_cpu
  ecs_container_definitions_memory           = var.ecs_container_definitions_memory
  ecs_container_definitions_essential        = var.ecs_container_definitions_essential
  containerPort                              = var.containerPort
  hostPort                                   = var.hostPort
  aws_region                                 = var.aws_region
  security_group_name                        = var.security_group_name
  security_group_vpc_id                      = module.vpc.vpc_id
  ingress_from_port_ecs                      = var.ingress_from_port_ecs
  ingress_to_port_ecs                        = var.ingress_to_port_ecs
  ingress_protocol_ecs                       = var.ingress_protocol_ecs
  security_groups                            = module.alb.alb_security_group_id
  egress_from_port_ecs                       = var.egress_from_port_ecs
  egress_to_port_ecs                         = var.egress_to_port_ecs
  egress_protocol_ecs                        = var.egress_protocol_ecs
  ecs_service_name                           = var.ecs_service_name
  ecs_desired_count                          = var.ecs_desired_count
  ecs_service_launch_type                    = var.ecs_service_launch_type
  target_group_arn                           = module.alb.alb_target_group_arn
  container_name                             = var.container_name
  container_port                             = var.container_port
  assign_public_ip                           = var.assign_public_ip
  subnets                                    = module.vpc.aws_private_subnet

}

# ECR module
module "ecr" {
  source                                  = "./modules/ecr"
  aws_ecr_repository_name                 = var.aws_ecr_repository_name
  aws_ecr_repository_image_tag_mutability = var.aws_ecr_repository_image_tag_mutability
  aws_ecr_repository_scan                 = var.aws_ecr_repository_scan
  ssm_parameter_name                      = var.ssm_parameter_name

}

#VPC module
module "vpc" {
  source                   = "./modules/vpc"
  vpc_project              = var.vpc_project
  public1_cidr_block       = var.public1_cidr_block
  availability_zone_1      = var.availability_zone_1
  public2_cidr_block       = var.public2_cidr_block
  availability_zone_2      = var.availability_zone_2
  private1_cidr_block      = var.private1_cidr_block
  private2_cidr_block      = var.private2_cidr_block
  private_route_cidr_block = var.private_route_cidr_block
  public_route_cidr_block  = var.public_route_cidr_block

}

#ALB module
module "alb" {
  source = "./modules/alb"

  alb_name                    = var.alb_name
  alb_internal                = var.alb_internal
  alb_load_balancer_type      = var.alb_load_balancer_type # 
  alb_subnets                 = module.vpc.aws_public_subnet
  lb_target_group_name        = var.lb_target_group_name #
  lb_target_group_port        = var.lb_target_group_port #
  lb_target_group_protocol    = var.lb_target_group_protocol
  lb_target_group_target_type = var.lb_target_group_target_type
  lb_target_group_vpc         = module.vpc.vpc_id
  listener_port               = var.listener_port
  listener_protocol           = var.listener_protocol
  ssl_policy                  = var.ssl_policy
  certificate                 = module.acm.acm_cert
  default_action_type         = var.default_action_type
  listener_port_http          = var.listener_port_http
  listener_protocol_http      = var.listener_protocol_http
  redirect_port               = var.redirect_port
  redirect_protocol           = var.redirect_protocol
  redirect_status_code        = var.redirect_status_code
  vpc_id                      = module.vpc.vpc_id
  ingress_from_port           = var.ingress_from_port
  ingress_to_port             = var.ingress_to_port
  ingress_protocol            = var.ingress_protocol
  ingress_cidr_blocks         = var.ingress_cidr_blocks
  ingress_from_port_http      = var.ingress_from_port_http
  ingress_to_port_http        = var.ingress_to_port_http
  ingress_protocol_http       = var.ingress_protocol_http
  ingress_cidr_blocks_http    = var.ingress_cidr_blocks_http
  egress_to_port              = var.egress_to_port
  egress_from_port            = var.egress_from_port
  egress_protocol             = var.egress_protocol
  egress_cidr_blocks          = var.egress_cidr_blocks

}

#ACM module
module "acm" {
  source = "./modules/acm"

  acm_domain_name = var.acm_domain_name
  acm_validation  = var.acm_validation
  allow_overwrite = var.allow_overwrite
  hosted_zone_id  = module.route53.zone_id
  value_ttl       = var.value_ttl

}

#Route53 module
module "route53" {
  source = "./modules/route53"

  aws_route53_zone_name        = var.aws_route53_zone_name
  aws_route53_record_name      = var.aws_route53_record_name
  alias_name                   = module.alb.alb_dns_name
  alias_zone_id                = module.alb.alb_zone_id
  alias_evaluate_target_health = var.alias_evaluate_target_health



}