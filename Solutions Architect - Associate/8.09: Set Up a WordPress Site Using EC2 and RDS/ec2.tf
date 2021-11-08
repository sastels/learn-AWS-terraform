resource "aws_instance" "web_server" {
  count                       = 2
  ami                         = "ami-0a70476e631caa6d3"
  instance_type               = "t2.micro"
  security_groups             = [aws_security_group.web-server.name]
  associate_public_ip_address = true
  key_name                    = "ssh-key"
  user_data                   = data.template_file.bootstrap.rendered

  root_block_device {
    encrypted = true
  }

  tags = {
    Name = "Web server"
  }
}

data "template_file" "bootstrap" {
  template = file("bootstrap.sh")
}

output "curl" {
  value = "curl ${aws_instance.web_server[0].public_dns}\ncurl ${aws_instance.web_server[1].public_dns}"
}
output "ssh" {
  value = "ssh -i ~/.ssh/id_rsa ec2-user@${aws_instance.web_server[0].public_dns}\nssh -i ~/.ssh/id_rsa ec2-user@${aws_instance.web_server[1].public_dns}"
}
