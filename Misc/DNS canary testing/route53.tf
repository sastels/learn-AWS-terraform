resource "aws_route53_record" "api" {
  zone_id = var.zone_id
  name    = var.name
  type    = "CNAME"
  records = [var.notification_alb]
  ttl     = "60"
}

# resource "aws_route53_record" "api-k8s" {
#   zone_id = var.zone_id
#   name    = var.name
#   type    = "CNAME"
#   records = [var.notification_alb]
#   ttl     = "60"
#   weighted_routing_policy {
#     weight = 255
#   }
# }

# resource "aws_route53_record" "api-lambda" {
#   zone_id = var.zone_id
#   name    = var.name
#   type    = "CNAME"
#   records = [var.api_lambda_app_gateway]
#   ttl     = "60"
#   weighted_routing_policy {
#     weight = 0
#   }
# }
