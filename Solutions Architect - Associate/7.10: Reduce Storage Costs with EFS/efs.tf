resource "aws_efs_file_system" "efs" {
  tags = {
    Name = "EFS shared storage"
  }
}

resource "aws_efs_mount_target" "efs" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = aws_instance.web_server[0].subnet_id
  security_groups = [aws_security_group.ec2_efs.id]
}

data "template_file" "bootstrap" {
  template = file("bootstrap.sh")
  vars = {
    efs_id = "${aws_efs_file_system.efs.id}"
  }
}

output "efs_id" {
  value = aws_efs_file_system.efs.id
}
