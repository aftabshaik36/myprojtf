resource "aws_instance" "vm" {
  ami             = var.ami
  instance_type   = var.instance_type
  subnet_id       = var.subnet_id
  vpc_security_group_ids = var.sg_id
  associate_public_ip_address = "true"
  user_data       = file("${path.module}/web.conf")
  key_name        = var.key_name
  tags = {
    Name = var.name
  }
}
