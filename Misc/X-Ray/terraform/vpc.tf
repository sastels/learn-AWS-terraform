
# Default VPC

# first run 
# aws ec2 create-default-vpc --region=ca-central-1


# Providing a reference to our default VPC
resource "aws_default_vpc" "default_vpc" {
}

# Providing a reference to our default subnets
resource "aws_default_subnet" "default_subnet_a" {
  availability_zone = "ca-central-1a"
}

resource "aws_default_subnet" "default_subnet_b" {
  availability_zone = "ca-central-1b"
}

resource "aws_default_subnet" "default_subnet_d" {
  availability_zone = "ca-central-1d"
}

