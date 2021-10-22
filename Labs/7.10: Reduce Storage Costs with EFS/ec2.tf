resource "aws_instance" "web_1" {
  ami                         = "ami-0a70476e631caa6d3"
  instance_type               = "t2.micro"
  security_groups             = ["${aws_security_group.web.name}"]
  associate_public_ip_address = true
  key_name                    = "ssh-key"
  user_data                   = file("bootstrap.sh")

  root_block_device {
    encrypted = true
  }

  tags = {
    Name = "Web server 1"
  }
}

resource "aws_instance" "web_2" {
  ami                         = "ami-0a70476e631caa6d3"
  instance_type               = "t2.micro"
  security_groups             = ["${aws_security_group.web.name}"]
  associate_public_ip_address = true
  key_name                    = "ssh-key"
  user_data                   = file("bootstrap.sh")

  root_block_device {
    encrypted = true
  }

  tags = {
    Name = "Web server 2"
  }
}

output "curl" {
  value = "curl ${aws_instance.web_1.public_dns}\ncurl ${aws_instance.web_2.public_dns}"
}
output "ssh" {
  value = "ssh -i ~/.ssh/id_rsa ec2-user@${aws_instance.web_1.public_dns}\nssh -i ~/.ssh/id_rsa ec2-user@${aws_instance.web_2.public_dns}"
}
