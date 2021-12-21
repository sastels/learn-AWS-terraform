variable "zone_id" {
  type    = string
  default = "Z03787061QOM2973GWMV4"
}

variable "notification_alb" {
  type    = string
  default = "notification-staging-alb-1878361959.ca-central-1.elb.amazonaws.com"
}

variable "api_lambda_app_gateway_api" {
  type    = string
  default = "d-cmqtfgeja3.execute-api.ca-central-1.amazonaws.com" # API Gateway domain name for api.staging.notification.cdssandbox.xyz
}

variable "api_lambda_app_gateway_api_lambda" {
  type    = string
  default = "d-087bebwcdc.execute-api.ca-central-1.amazonaws.com" # API Gateway domain name for api-lambda.staging.notification.cdssandbox.xyz
}
