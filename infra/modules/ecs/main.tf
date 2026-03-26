resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name

  setting {
    name  = var.setting_name
    value = var.setting_value
  }
}


resource "aws_ecs_task_definition" "app" {
  family                   = var.ecs_task_definition_family
  requires_compatibilities = var.ecs_task_definition_requires_compatibilies
  network_mode             = "awsvpc"
  cpu                      = var.ecs_task_definition_cpu
  memory                   = var.ecs_task_definition_memory
  execution_role_arn       = aws_iam_role.ecs_role.arn



  container_definitions = jsonencode([
    {
      name                   = var.ecs_container_definitions_name
      image                  = var.ecs_container_definitions_image
      cpu                    = var.ecs_container_definitions_cpu
      memory                 = var.ecs_container_definitions_memory
      essential              = var.ecs_container_definitions_essential
      user                   = "appuser"
      readonlyRootFilesystem = true

      portMappings = [
        {
          containerPort = var.containerPort
          hostPort      = var.hostPort
        }

      ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.ecs_logs.name
          awslogs-region        = var.aws_region
          awslogs-stream-prefix = "ecs"
        }
      }


    }

  ])
}

#Cloudwatch
resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "/ecs/${var.ecs_cluster_name}"
  retention_in_days = 365
}

#ECS-SG
resource "aws_security_group" "ecs_sg" {
  name   = var.security_group_name
  vpc_id = var.security_group_vpc_id

  tags = {
    Name = "allow_traffic_alb"
  }


  ingress { #8080
    from_port       = var.ingress_from_port_ecs
    to_port         = var.ingress_to_port_ecs
    protocol        = var.ingress_protocol_ecs
    security_groups = [var.security_groups]
  }


  egress {
    from_port   = var.egress_from_port_ecs
    to_port     = var.egress_to_port_ecs
    protocol    = var.egress_protocol_ecs
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_ecs_service" "ecs_project" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.ecs_desired_count
  launch_type     = var.ecs_service_launch_type




  load_balancer {
    target_group_arn = var.target_group_arn
    container_name   = var.container_name
    container_port   = var.container_port
  }

  network_configuration {
    assign_public_ip = var.assign_public_ip
    security_groups  = [aws_security_group.ecs_sg.id]
    subnets          = var.subnets

  }

}

resource "aws_iam_role" "ecs_role" {
  name = "ecs_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      },
    ]
  })
}


resource "aws_iam_role_policy_attachment" "ecs_execution_role_attachment" {
  role       = aws_iam_role.ecs_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}