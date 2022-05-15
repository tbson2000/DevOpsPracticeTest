data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Canonical Ubuntu AWS account id
}

resource "aws_instance" "SonTB4_Jenkins" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.SonTB4_public_subnet_01.id
  security_groups = [aws_security_group.private.id]
  key_name = var.key_name
  tags = {
    Name = "SonTB4_Jenkins"
  }
}

resource "aws_instance" "SonTB4_host_main" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.SonTB4_public_subnet_01.id
  security_groups = [aws_security_group.private.id]
  key_name = var.key_name
  tags = {
    Name = "SonTB4_host_main"
  }
}

resource "aws_instance" "SonTB4_host_dev" {
  ami = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  subnet_id = aws_subnet.SonTB4_public_subnet_01.id
  security_groups = [aws_security_group.private.id]
  key_name = var.key_name
  tags = {
    Name = "SonTB4_host_dev"
  }
}

