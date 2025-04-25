resource "aws_vpc" "homol" {
  cidr_block           = "10.1.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = "true"

  tags = {
    Name = "homol-vpc"
  }
}

resource "aws_subnet" "Public-1A" {
  vpc_id            = aws_vpc.homol.id
  availability_zone = "us-east-2a"
  cidr_block        = "10.1.1.0/24"

  tags = {
    Name = "PublicSubnet-1A"
  }
}

resource "aws_subnet" "Public-1B" {
  vpc_id            = aws_vpc.homol.id
  availability_zone = "us-east-2a"
  cidr_block        = "10.1.2.0/24"

  tags = {
    Name = "PublicSubnet-1B"
  }
}

resource "aws_subnet" "Private-1A" {
  vpc_id            = aws_vpc.homol.id
  availability_zone = "us-east-2a"
  cidr_block        = "10.1.3.0/24"

  tags = {
    Name = "PrivateSubnet-1A"
  }
}

resource "aws_subnet" "Private-1B" {
  vpc_id            = aws_vpc.homol.id
  availability_zone = "us-east-2a"
  cidr_block        = "10.1.4.0/24"

  tags = {
    Name = "PrivateSubnet-1B"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.homol.id

  tags = {
    Name = "IGW-Homol"
  }
}

resource "aws_route_table" "route-tablePublic" {
  vpc_id = aws_vpc.homol.id

  route {
    cidr_block = "10.0.1.0/24"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "rt-homol"
  }
}

resource "aws_route_table" "route-tablePrivate" {
  vpc_id = aws_vpc.homol.id

  tags = {
    Name = "rt-homol"
  }
}

resource "aws_route_table_association" "RTPublic_1A" {
  subnet_id      = aws_subnet.Public-1A.id
  route_table_id = aws_route_table.route-tablePublic.id
}

resource "aws_route_table_association" "RTPublic_1B" {
  subnet_id      = aws_subnet.Public-1B.id
  route_table_id = aws_route_table.route-tablePublic.id
}

resource "aws_route_table_association" "RTPrivate_1A" {
  subnet_id      = aws_subnet.Private-1A.id
  route_table_id = aws_route_table.route-tablePrivate.id
}

resource "aws_route_table_association" "RTPrivate_1B" {
  subnet_id      = aws_subnet.Private-1B.id
  route_table_id = aws_route_table.route-tablePrivate.id
}
