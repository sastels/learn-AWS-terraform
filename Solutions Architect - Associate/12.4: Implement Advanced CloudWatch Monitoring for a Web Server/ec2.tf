

resource "aws_instance" "web_server" {
  count                       = var.num_servers
  ami                         = "ami-0d8ad3ab25e7abc51" # Amazon Linux 2
  instance_type               = "t2.micro"
  iam_instance_profile        = aws_iam_instance_profile.this.name
  security_groups             = ["${aws_security_group.web.name}"]
  associate_public_ip_address = true
  key_name                    = "ssh-key"
  user_data                   = element(template_file.bootstrap.*.rendered, count.index)

  tags = {
    Name = "Web server ${count.index}"
  }
}

resource "template_file" "bootstrap" {
  count    = var.num_servers
  template = file("./bootstrap.sh")
  vars = {
    server_id             = "${count.index}"
    ssm_cloudwatch_config = aws_ssm_parameter.cw_agent.name
  }
}

resource "aws_ssm_parameter" "cw_agent" {
  description = "Cloudwatch agent config to configure custom log"
  name        = "/cloudwatch-agent/config"
  type        = "String"
  value       = file("cw_agent_config.json")
}

output "curl" {
  value = "curl ${aws_instance.web_server[0].public_dns}\n"
}
output "ssh" {
  value = "ssh -i ~/.ssh/id_rsa ec2-user@${aws_instance.web_server[0].public_dns}\n"
}
