resource "aws_efs_file_system" "efs" {

  tags = {
    Name = "EFS shared storage"
  }
}

resource "aws_efs_mount_target" "efs" {
  file_system_id = aws_efs_file_system.efs.id
  subnet_id      = aws_default_subnet.default_az1.id
}



output "efs_id" {
  value = aws_efs_file_system.efs.id
}
