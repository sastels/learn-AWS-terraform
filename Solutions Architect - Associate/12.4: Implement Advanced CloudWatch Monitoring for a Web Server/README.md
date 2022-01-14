## Description

CloudWatch Logs centralizes the logs from all of your systems, applications, and AWS services that you use, in a single, highly scalable service. In this lab, you will configure an EC2 instance to stream its Apache web server error logs to CloudWatch Logs. You will configure the agent and then log in to the CloudWatch Logs console to make sure the logs are streamed correctly. By the end of this lab, you will understand how to install the CloudWatch Logs agent and configure it to stream a log to the service.

Note: using the default VPC here, which you might need to create via
```
aws ec2 create-default-vpc
```
There doesn't seem to be a way to create it via terraform :/

## Usage

Run
```
terraform init
terraform apply
```

## References

[CloudWatch Agent on EC2 with Terraform](https://jazz-twk.medium.com/cloudwatch-agent-on-ec2-with-terraform-8cf58e8736de)
https://docs.aws.amazon.com/AmazonCloudWatch/latest/monitoring/CloudWatch-Agent-Configuration-File-Details.html
https://aws.amazon.com/blogs/mt/simplifying-apache-server-logs-with-amazon-cloudwatch-logs-insights/