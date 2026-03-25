output "vpc_id" {
  value = aws_vpc.project.id
}

output "aws_public_subnet" {
  value = [
    aws_subnet.public_2.id,
    aws_subnet.public_1.id
  ]
}

output "aws_private_subnet" {
  value = [
    aws_subnet.private_2.id,
    aws_subnet.private_1.id
  ]
}
