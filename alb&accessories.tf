# alb
resource "aws_lb" "e-learning-alb" {
  name               = "e-learning-alb"
  internal           = false
  load_balancer_type = var.load_balancer_type
  enable_deletion_protection = var.alb_enable_deletion_protection
  security_groups    = [aws_security_group.e-learning-alb-sg.id]
  subnets            = [aws_subnet.e-learning-pub-sub1.id,aws_subnet.e-learning-pub-sub2.id]

/*   access_logs {
    bucket  = aws_s3_bucket.lb_logs.bucket
    prefix  = "test-lb"
    enabled = true
  } */

  tags = {
    Environment = "production"
  }
}

# alb security group
resource "aws_security_group" "e-learning-alb-sg" {
  name        = "allow_tls_http"
  description = "Allow HTTP inbound traffic"
  vpc_id      = aws_vpc.e-learning.id

  ingress {
    description      = "http from anywhere"
    from_port        = var.alb_http_ingress_from_port
    to_port          = var.alb_http_ingress_to_port
    protocol         = var.alb_http_ingress_protocol
    cidr_blocks      = var.alb_http_ingress_cidr_block
   /*  ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block] */
  }
    ingress {
    description      = "https from anywhere"
    from_port        = var.alb_https_ingress_from_port
    to_port          = var.alb_https_ingress_to_port
    protocol         = var.alb_https_ingress_protocol
    cidr_blocks      = var.alb_https_ingress_cidr_block
    # ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }

  egress {
    from_port        = var.alb_egress_from_port
    to_port          = var.alb_egress_to_port
    protocol         = var.alb_egress_protocol
    cidr_blocks      = var.alb_egress_cidr_block
   /*  ipv6_cidr_blocks = ["::/0"] */
  }

  tags = {
    Name = "allow_tls_http-${terraform.workspace}"
  }
}

resource "aws_lb_listener" "e-learning-alb-http-listener" {
  load_balancer_arn = aws_lb.e-learning-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

# alb listener
resource "aws_lb_listener" "e-learning-alb-https-listener" {
  load_balancer_arn = aws_lb.e-learning-alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.ecs-acm-cert.arn
  depends_on        = [aws_lb_target_group.e-learning-alb-tg]

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.e-learning-alb-tg.arn
  }
}

# alb target group
resource "aws_lb_target_group" "e-learning-alb-tg" {
  health_check {
        enabled             = true
        interval            = 30
        path                = "/"
        protocol            = "HTTP"
        #protocol            = "TCP"
        port                = 80
        timeout             = 6
        healthy_threshold   = 5
        unhealthy_threshold = 2
        matcher             = "200"
        
    }
  name        = "e-learning-alb-tg"
  target_type = "ip"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = "${aws_vpc.e-learning.id}"
  }
