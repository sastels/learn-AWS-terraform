## Description

An EC2 webserver running Wordpress, connected to an RDS

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

## Links

https://techsparx.com/software-development/terraform/aws/rds/simple-deploy.html
https://dev.to/abhivaidya07/connecting-wordpress-to-amazon-rds-using-terraform-15bm
