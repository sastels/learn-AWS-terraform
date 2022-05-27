## Description

- Run a few flask servers in ECS behind a load balancer
- instrument with X-Ray


## Usage

Create a default vpc
```
aws ec2 create-default-vpc --region=ca-central-1
```

Run
```
terraform init
terraform apply
```

then navigate to the load balancer's url.
