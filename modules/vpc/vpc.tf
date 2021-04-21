# VPC
resource "aws_vpc" "demo-vpc" {
  cidr_block       = var.vpc-cidr
  instance_tenancy = "default"

  tags = {
    Name = var.vpc-name
  }
}

#subnet
resource "aws_subnet" "psub" {
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = var.pub-cidr
  availability_zone = var.az
  tags = {
    Name = var.pub-subnet
  }
}

resource "aws_subnet" "psub1" {
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = var.pub1-cidr
  availability_zone = var.az1

  tags = {
    Name = var.pub1-subnet
  }
}

#Internet gateway
resource "aws_internet_gateway" "test-gw" {
  vpc_id = aws_vpc.demo-vpc.id

  tags = {
    Name = var.internet-gateway
  }
}

#route_table
resource "aws_route_table" "mypubroute" {
  vpc_id = aws_vpc.demo-vpc.id

  route {
    cidr_block = var.igw-cidr
    gateway_id = aws_internet_gateway.test-gw.id
  }

  tags = {
    Name = var.pubroute
  }
}

resource "aws_route_table" "mypub1route" {
  vpc_id = aws_vpc.demo-vpc.id

  route {
    cidr_block = var.igw-cidr
    gateway_id = aws_internet_gateway.test-gw.id
  }

  tags = {
    Name = var.pub1route
  }
}

#Routetable association
resource "aws_route_table_association" "pubrt" {
  subnet_id      = aws_subnet.psub.id
  route_table_id = aws_route_table.mypubroute.id
}

resource "aws_route_table_association" "pubrt1" {
  subnet_id      = aws_subnet.psub1.id
  route_table_id = aws_route_table.mypub1route.id
}

#security_group
resource "aws_security_group" "sg" {
  name        = var.sg
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.demo-vpc.id

  ingress {
    description = "TLS from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.inbound-cidr
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = var.inbound-cidr
  }

  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.inbound1-cidr
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.outbound-cidr
  }
}
