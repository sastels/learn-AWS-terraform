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

To connect to the EC2:
- in AWS console, go to [AWS Systems Manager](https://ca-central-1.console.aws.amazon.com/systems-manager/home?region=ca-central-1#)
- go to [Session Manager](https://ca-central-1.console.aws.amazon.com/systems-manager/session-manager?region=ca-central-1)
- click [Start Session](https://ca-central-1.console.aws.amazon.com/systems-manager/session-manager/start-session?region=ca-central-1)
- choose the web server and click "Start session"
- after the `terraform apply` finishes you can run `terraform output -raw psql`. This will give you a `psql` command that contains a connection string.
- run this line in your session
- look at the database, for example with `\d`


To destroy, run
```
aws quicksight update-account-settings --no-termination-protection-enabled --aws-account-id $SCRATCH_ID --default-namespace default --region=ca-central-1

terraform destroy
```

## Links

https://balramchavan.medium.com/connect-to-ec2-via-aws-session-manager-and-without-ssh-inbound-rule-f9f9e25c4345

https://stackoverflow.com/questions/45002292/terraform-correct-way-to-attach-aws-managed-policies-to-a-role
