resource "aws_instance" "server" {
  ami                         = "ami-090fa75af13c156b4" # Amazon Linux 2
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  associate_public_ip_address = true
  key_name                    = "ssh-key"
  user_data                   = data.template_file.bootstrap.rendered
  subnet_id                   = aws_subnet.public.id

  root_block_device {
    encrypted = true
  }

  tags = {
    Name = "Server"
  }

  depends_on = [aws_internet_gateway.gw]
}

data "template_file" "bootstrap" {
  template = file("./bootstrap.sh")
}

output "ssh" {
  value = "ssh -i ~/.ssh/id_rsa ec2-user@${aws_instance.server.public_dns}\n"
}
