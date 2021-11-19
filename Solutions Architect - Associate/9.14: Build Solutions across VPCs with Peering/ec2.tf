resource "aws_instance" "web_server" {
  # ami                         = "ami-0d8ad3ab25e7abc51" # Amazon Linux 2
  ami                         = "ami-0bb84e7329f4fa1f7" # Ubuntu Server 20.04 LTS 
  instance_type               = "t2.micro"
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  associate_public_ip_address = true
  key_name                    = "ssh-key"
  user_data                   = data.template_file.bootstrap.rendered
  subnet_id                   = aws_subnet.WebPublic.id

  root_block_device {
    encrypted = true
  }

  tags = {
    Name = "Web server"
  }

  depends_on = [aws_internet_gateway.WebIG]
}

data "template_file" "bootstrap" {
  template = file("./bootstrap.sh")
}

output "curl" {
  value = "curl ${aws_instance.web_server.public_dns}\n"
}
output "ssh" {
  value = "ssh -i ~/.ssh/id_rsa ubuntu@${aws_instance.web_server.public_dns}\n"
}
