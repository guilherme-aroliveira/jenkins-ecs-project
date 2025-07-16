# Create Load balancer for ECS Cluster
resource "aws_lb" "public_lb" {
  name               = "public-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.public_lb_sg]
  subnets            = var.public_subnets

  tags = merge(
    local.tags,
    {
      Name = "public-lb"
    }
  )
}

### Create a target group for the application #####

resource "aws_lb_target_group" "lb_tg_jenkins" {
  name        = "jenkins-ecs-tg"
  vpc_id      = var.vpc_id
  port        = 8080
  protocol    = "HTTP"
  target_type = "ip"

  health_check {
    protocol            = "HTTP"
    path                = "/login"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = merge(
    local.tags,
    {
      Name         = "jenkins-tg"
      product-name = "jenkins"
    }
  )
}

resource "aws_lb_listener" "public_lb_http_listener" {
  load_balancer_arn = aws_lb.public_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_tg_jenkins.arn
  }
}
