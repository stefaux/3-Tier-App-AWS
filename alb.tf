resource "aws_lb" "mihai-alb" {
  name               = "mihai-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_tls.id]
  subnets            = [for subnet in aws_subnet.mihai-public-subnet : subnet.id]

  enable_deletion_protection = false

  tags = {
    Environment = "test"
  }
}

//Target Group
resource "aws_lb_target_group" "mihai-alb-tg" {
  name     = "mihai-alb-tg"
  port     = 80
  protocol = "HTTP"
  target_type = "instance"
  vpc_id   = aws_vpc.mihai-vpc.id

  health_check {    
    healthy_threshold   = 3    
    unhealthy_threshold = 10    
    timeout             = 5    
    interval            = 10    
    path                = "/"    
    port                = 80  
  }
}

resource "aws_lb_target_group_attachment" "front_end" {
  target_group_arn = aws_lb_target_group.mihai-alb-tg.arn
  target_id        = aws_instance.web[count.index].id
  port             = 80
  count = 2
}

//Listener
resource "aws_lb_listener" "albl" {
  load_balancer_arn = aws_lb.mihai-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.mihai-alb-tg.arn
  }
}