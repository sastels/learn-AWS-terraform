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

## References

[How to Deploy a Dockerised Application on AWS ECS With Terraform](https://medium.com/avmconsulting-blog/how-to-deploy-a-dockerised-node-js-application-on-aws-ecs-with-terraform-3e6bceb48785)

