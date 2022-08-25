## Description

- An EC2 server in us-east-1 or eu-west-1 to use to test geoblocking 

## Usage

Choose the region and ami in `main.tf`.

Run
```
terraform init
terraform apply
```

SSH into the server using the output of terraform apply.
