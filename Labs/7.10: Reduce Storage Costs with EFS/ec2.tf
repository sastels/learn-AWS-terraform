resource "aws_instance" "web_1" {
  ami                         = "ami-0a70476e631caa6d3"
  instance_type               = "t2.micro"
  security_groups             = [aws_security_group.ec2_efs.name]
  associate_public_ip_address = true
  key_name                    = "ssh-key"
  user_data                   = data.template_file.bootstrap.rendered

  root_block_device {
    encrypted = true
  }

  tags = {
    Name = "Web server 1"
  }
}

output "curl" {
  value = "curl ${aws_instance.web_1.public_dns}\n"
}
output "ssh" {
  value = "ssh -i ~/.ssh/id_rsa ec2-user@${aws_instance.web_1.public_dns}\n"
}
