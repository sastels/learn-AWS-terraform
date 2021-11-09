resource "aws_instance" "web_server" {
  ami                         = "ami-0bb84e7329f4fa1f7"
  instance_type               = "t2.micro"
  security_groups             = [aws_security_group.ec2.name]
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
  value = "curl ${aws_instance.web_server.public_dns}\n"
}
output "ssh" {
  value = "ssh -i ~/.ssh/id_rsa ec2-user@${aws_instance.web_server.public_dns}\n"
}
