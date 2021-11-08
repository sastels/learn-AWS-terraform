resource "aws_instance" "web_server" {
  ami                         = "ami-0a70476e631caa6d3"
  instance_type               = "t2.micro"
  security_groups             = ["${aws_security_group.web-server.name}"]
  associate_public_ip_address = true
  key_name                    = aws_key_pair.ssh-key.key_name
  user_data                   = file("bootstrap.sh")
  iam_instance_profile        = aws_iam_instance_profile.web_profile.name
  tags = {
    Name = "terraform web server"
  }
}

output "curl" {
  value = "curl ${aws_instance.web_server.public_dns}"
}
output "ssh" {
  value = "ssh -i ~/.ssh/id_rsa ec2-user@${aws_instance.web_server.public_dns}"
}
