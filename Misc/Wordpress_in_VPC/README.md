## Description

- An EC2 webserver running Wordpress, 
- connected to an RDS
- in a VPC with public and private subnets

## Usage

Create a `terraform.tfvars` file containing:
```
ssh_public_key = "ssh-rsa ........." # from  ~/.ssh/id_rsa.pub 
```

Run
```
terraform init
terraform apply
```

Then log into `/wordpress` and configure using the rds endpoint output.

## Links

https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/hosting-wordpress.html