resource "aws_instance" "SonTB4_Jenkins" {
  ami = "ami-06a50dba30ce486f7"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.SonTB4_public_subnet_01.id
  security_groups = [aws_security_group.private.id]
  key_name = var.key_name
  tags = {
    Name = "SonTB4_Jenkins"
  }
}

resource "aws_instance" "SonTB4_host_main" {
  ami = "ami-06a50dba30ce486f7"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.SonTB4_public_subnet_01.id
  security_groups = [aws_security_group.private.id]
  key_name = var.key_name
  tags = {
    Name = "SonTB4_host_main"
  }
}

resource "aws_instance" "SonTB4_host_dev" {
  ami = "ami-06a50dba30ce486f7"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.SonTB4_public_subnet_01.id
  security_groups = [aws_security_group.private.id]
  key_name = var.key_name
  tags = {
    Name = "SonTB4_host_dev"
  }
}

