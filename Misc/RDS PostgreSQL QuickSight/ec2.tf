resource "aws_instance" "web_server" {
  ami                         = "ami-0d8ad3ab25e7abc51" # Amazon Linux 2
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  associate_public_ip_address = true
  key_name                    = "ssh-key"
  user_data                   = data.template_file.bootstrap.rendered
  subnet_id                   = aws_subnet.public.id
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  root_block_device {
    encrypted = true
  }

  tags = {
    Name = "Web server"
  }

  depends_on = [aws_internet_gateway.gw]
}

data "template_file" "bootstrap" {
  template = file("./bootstrap.sh")
  vars = {
    db_uri = "postgresql://${aws_db_instance.test.username}:${aws_db_instance.test.password}@${aws_db_instance.test.address}"
  }
}

output "curl" {
  value = "curl ${aws_instance.web_server.public_dns}\n"
}
