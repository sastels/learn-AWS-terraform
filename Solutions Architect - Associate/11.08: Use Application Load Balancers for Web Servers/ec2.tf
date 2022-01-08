

resource "aws_instance" "web_server" {
  count                       = var.num_servers
  ami                         = "ami-0d8ad3ab25e7abc51" # Amazon Linux 2
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.web.id]
  associate_public_ip_address = true
  key_name                    = "ssh-key"
  user_data                   = element(template_file.bootstrap.*.rendered, count.index)
  subnet_id                   = aws_subnet.web_public_1a.id

  root_block_device {
    encrypted = true
  }
  tags = {
    Name = "Web server ${count.index}"
  }
  depends_on = [aws_internet_gateway.web]
}

resource "template_file" "bootstrap" {
  count    = var.num_servers
  template = file("./bootstrap.sh")
  vars = {
    server_id = "${count.index}"
  }
}

output "curl" {
  value = "curl ${aws_instance.web_server[0].public_dns}\n"
}
output "ssh" {
  value = "ssh -i ~/.ssh/id_rsa ec2-user@${aws_instance.web_server[0].public_dns}\n"
}
