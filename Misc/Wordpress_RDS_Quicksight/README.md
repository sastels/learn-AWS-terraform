## Description

- An EC2 webserver running Wordpress, 
- connected to a mysql database in RDS,
- in a VPC with public and private subnets

## Usage

Run
```
terraform init
terraform apply
```

Then log into `/wordpress` and configure using the rds endpoint output and the database password stored in Secrets Manager.

Then go into QuickSight and add a vpc connection.
- use the quicksight securitygroup

## Links

https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/hosting-wordpress.html

https://aws.amazon.com/de/premiumsupport/knowledge-center/quicksight-redshift-private-connection/
