variable "zone_id" {
  type    = string
  default = "Z03787061QOM2973GWMV4"
}

variable "notification_alb" {
  type    = string
  default = "notification-staging-alb-1878361959.ca-central-1.elb.amazonaws.com"
}

variable "api_lambda_app_gateway" {
  type    = string
  default = "d-4g6bkuj5mk.execute-api.ca-central-1.amazonaws.com"
}
