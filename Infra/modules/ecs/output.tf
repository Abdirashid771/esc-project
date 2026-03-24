output "ecs_cluster_id" {
  value = aws_ecs_cluster.ecs_cluster.id
}

output "aws_ecs_task_definition_arn" {
  value = aws_ecs_task_definition.app.arn
}

output "aws_security_group_id" {
  value = aws_security_group.ecs_sg.id
}