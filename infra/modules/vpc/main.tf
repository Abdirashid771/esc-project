resource "aws_vpc" "project" {
  cidr_block = var.vpc_project
}


#IGW

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.project.id

}

#NAT

resource "aws_nat_gateway" "nat_ecs_1" {
  subnet_id     = aws_subnet.public_1.id
  allocation_id = aws_eip.nat1.id

}

resource "aws_nat_gateway" "nat_ecs_2" {
  subnet_id     = aws_subnet.public_2.id
  allocation_id = aws_eip.nat2.id

}

resource "aws_eip" "nat1" {
  domain = "vpc"
}

resource "aws_eip" "nat2" {
  domain = "vpc"
}

#Objective is route the public subnets to the Internet GW and Private to be routed to NAT

resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.project.id
  cidr_block              = var.public1_cidr_block
  availability_zone       = var.availability_zone_1
  map_public_ip_on_launch = true

}

resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.project.id
  cidr_block              = var.public2_cidr_block
  availability_zone       = var.availability_zone_2
  map_public_ip_on_launch = true

}

resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.project.id
  cidr_block        = var.private1_cidr_block
  availability_zone = var.availability_zone_1

}

resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.project.id
  cidr_block        = var.private2_cidr_block
  availability_zone = var.availability_zone_2

}


#route table

resource "aws_route_table" "private_route_1" {
  vpc_id = aws_vpc.project.id

  route {
    cidr_block     = var.private_route_cidr_block
    nat_gateway_id = aws_nat_gateway.nat_ecs_1.id

  }

}

resource "aws_route_table" "private_route_2" {
  vpc_id = aws_vpc.project.id

  route {
    cidr_block     = var.private_route_cidr_block
    nat_gateway_id = aws_nat_gateway.nat_ecs_2.id

  }

}

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.project.id

  route {
    cidr_block = var.public_route_cidr_block
    gateway_id = aws_internet_gateway.gw.id
  }

}


#Route association

resource "aws_route_table_association" "private_assoc1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private_route_1.id
}

resource "aws_route_table_association" "private_assoc2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private_route_2.id
}

resource "aws_route_table_association" "public_assoc1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "public_assoc2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public_route.id
}