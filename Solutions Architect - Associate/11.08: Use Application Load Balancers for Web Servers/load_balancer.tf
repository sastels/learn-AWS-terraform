
# Target Group Creation

resource "aws_lb_target_group" "web" {
  name        = "TargetGroup"
  port        = 80
  target_type = "instance"
  protocol    = "HTTP"
  vpc_id      = aws_vpc.web.id
}

# Target Group Attachment with Instance

resource "aws_alb_target_group_attachment" "tgattachment" {
  count            = var.num_servers
  target_group_arn = aws_lb_target_group.web.arn
  target_id        = element(aws_instance.web_server.*.id, count.index)
}

# Application Load balancer

resource "aws_lb" "web" {
  name               = "ALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web.id]
  subnets            = [aws_subnet.web_public_1a.id, aws_subnet.web_public_1b.id]
}

output "alb" {
  value = "curl ${aws_lb.web.dns_name}\n"
}

# # Listner

resource "aws_lb_listener" "web" {
  load_balancer_arn = aws_lb.web.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }
}


# # Listener Rule

# resource "aws_lb_listener_rule" "static" {
#   listener_arn = aws_lb_listener.front_end.arn
#   priority     = 100

#   action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.tg.arn

#   }

#   condition {
#     path_pattern {
#       values = ["/var/www/html/index.html"]
#     }
#   }
# }
