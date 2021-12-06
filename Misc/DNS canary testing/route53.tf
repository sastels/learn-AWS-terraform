# original record

# resource "aws_route53_record" "api" {
#   zone_id = var.zone_id
#   name    = "api.staging.notification.cdssandbox.xyz"
#   type    = "CNAME"
#   records = [var.notification_alb]
#   ttl     = "60"
# }


# direct k8s / lambda records
resource "aws_route53_record" "api-k8s" {
  zone_id = var.zone_id
  name    = "api-k8s.staging.notification.cdssandbox.xyz"
  type    = "CNAME"
  records = [var.notification_alb]
  ttl     = "60"
}

# Already in the account
#
# resource "aws_route53_record" "api-lambda" {
#   zone_id = var.zone_id
#   name    = "api-lambda.staging.notification.cdssandbox.xyz"
#   type    = "CNAME"
#   records = [var.api_lambda_app_gateway]
#   ttl     = "60"
# }


# Weighted records

resource "aws_route53_record" "api-k8s-weighted" {
  zone_id        = var.zone_id
  name           = "api.staging.notification.cdssandbox.xyz"
  type           = "CNAME"
  records        = [var.notification_alb]
  ttl            = "60"
  set_identifier = "loadbalancer"
  weighted_routing_policy {
    weight = 255
  }
}

resource "aws_route53_record" "api-lambda-weighted" {
  zone_id        = var.zone_id
  name           = "api.staging.notification.cdssandbox.xyz"
  type           = "CNAME"
  records        = ["api-lambda.staging.notification.cdssandbox.xyz"]
  ttl            = "60"
  set_identifier = "lambda"
  weighted_routing_policy {
    weight = 0
  }
}
