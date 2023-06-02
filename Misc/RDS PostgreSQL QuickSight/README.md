## Description

- PostgreSQL database in RDS with example database loaded.
- EC2 connected to the database. SessionManager enabled to connect to the EC2
- Quicksight running and connected to the database
- in a VPC with public and private subnets

## Usage

Run
```
terraform init
terraform apply
```

<!-- Then go into QuickSight and add a vpc connection.
- use the quicksight securitygroup -->

## Links

https://balramchavan.medium.com/connect-to-ec2-via-aws-session-manager-and-without-ssh-inbound-rule-f9f9e25c4345

https://stackoverflow.com/questions/45002292/terraform-correct-way-to-attach-aws-managed-policies-to-a-role
