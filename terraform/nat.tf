resource "aws_eip" "SonTB4_nat" {
  vpc = true
}

resource "aws_nat_gateway" "SonTB4_nat_gateway" {
  allocation_id = aws_eip.SonTB4_nat.id
  subnet_id = aws_subnet.SonTB4_public_subnet_01.id
  depends_on = [aws_internet_gateway.SonTB4_internet_gateway]
}

resource "aws_route_table" "SonTB4_nat" {
  vpc_id = aws_vpc.SonTB4_VLAN.id
  route {
      cidr_block = "0.0.0.0/0"
      nat_gateway_id = aws_nat_gateway.SonTB4_nat_gateway.id
  }
  tags = {
      Name = "SonTB4_nat_private"
  }
}

# resource "aws_route_table_association" "SonTB4_aws_route_table_association_03" {
#   subnet_id = aws_subnet.SonTB4_private_subnet_01.id
#   route_table_id = aws_route_table.SonTB4_nat.id
# }

# resource "aws_route_table_association" "SonTB4_aws_route_table_association_04" {
#   subnet_id = aws_subnet.SonTB4_private_subnet_02.id
#   route_table_id = aws_route_table.SonTB4_nat.id
# }