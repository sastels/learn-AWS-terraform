## Description

Two EC2 webservers connected to an RDS

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

