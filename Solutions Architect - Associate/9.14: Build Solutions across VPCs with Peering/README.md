## Description

A VPC peering connection is a networking connection between two VPCs that enables you to route traffic between them using private IPv4 addresses or IPv6 addresses. In this lab, we create a new VPC for our WordPress blog to run from. We then create a VPC peering connection between the new VPC and an existing database VPC. By the end of this lab, the user will understand how to create a new VPC from scratch, attach internet gateways, edit routing tables, and peer multiple VPCs together.

Idea: Wordpress EC2 is in one VPC, RDS is in a different one, and they're paired.
## Usage

Run
```
terraform init
terraform apply
```

Then log into `/wordpress` and configure using the rds endpoint output and the database password stored in Secrets Manager.

## Links
https://www.nicksantamaria.net/post/how-to-peer-vpcs-with-terraform/
https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/hosting-wordpress.html

https://learn.acloud.guru/handson/b9756e9f-5140-4ec7-b9b7-0ffaed561910/course/certified-solutions-architect-associate
