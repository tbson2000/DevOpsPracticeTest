resource "aws_vpc" "SonTB4_VLAN" {
  cidr_block = "192.4.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  enable_classiclink = "false"
  tags = {
      Name = "SonTB4_VPC"
  }
}

resource "aws_subnet" "SonTB4_public_subnet_01" {
  vpc_id = aws_vpc.SonTB4_VLAN.id
  cidr_block = "192.4.0.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-2a"
  tags = {
      Name = "SonTB4_public_subnet_01"
  }
}

resource "aws_subnet" "SonTB4_public_subnet_02" {
    vpc_id = aws_vpc.SonTB4_VLAN.id
    cidr_block = "192.4.1.0/24"
    map_public_ip_on_launch = "true"
    availability_zone = "us-east-2b"
    tags = {
        Name = "SonTB4_public_subnet_02"
    }
}

resource "aws_subnet" "SonTB4_private_subnet_01" {
    vpc_id = aws_vpc.SonTB4_VLAN.id
    cidr_block = "192.4.2.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-2a"
    tags = {
      Name = "SonTB4_private_subnet_01"
    }
}

resource "aws_subnet" "SonTB4_private_subnet_02" {
    vpc_id = aws_vpc.SonTB4_VLAN.id
    cidr_block = "192.4.3.0/24"
    map_public_ip_on_launch = "false"
    availability_zone = "us-east-2b"
    tags = {
      Name = "SonTB4_private_subnet_02"
    }
}

resource "aws_internet_gateway" "SonTB4_internet_gateway" {
  vpc_id = aws_vpc.SonTB4_VLAN.id
  tags = {
    Name = "SonTB4_internet_gateway"
  }
}

resource "aws_route_table" "SonTB4_route_table" {
  vpc_id = aws_vpc.SonTB4_VLAN.id
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.SonTB4_internet_gateway.id
  }
  tags = {
    Name = "SonTB4_route_table"
  }
}

resource "aws_route_table_association" "SonTB4_route_table_association_01" {
  subnet_id = aws_subnet.SonTB4_public_subnet_01.id
  route_table_id = aws_route_table.SonTB4_route_table.id
}

resource "aws_route_table_association" "SonTB4_route_table_association_02" {
  subnet_id = aws_subnet.SonTB4_private_subnet_01.id
  route_table_id = aws_route_table.SonTB4_route_table.id
}

