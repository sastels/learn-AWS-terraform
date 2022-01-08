variable "ssh_public_key_file" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}
variable "num_servers" {
  type    = number
  default = 3
}
