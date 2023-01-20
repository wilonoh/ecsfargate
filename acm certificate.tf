# acm certificate 
resource "aws_acm_certificate" "ecs-acm-cert" {
  domain_name       = "tripinky.com"
  validation_method = "DNS"
}

data "aws_route53_zone" "ecs-acm-cert" {
  name         = "tripinky.com"
  private_zone = false
}

resource "aws_route53_record" "ecs-acm-cert" {
  for_each = {
    for dvo in aws_acm_certificate.ecs-acm-cert.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.ecs-acm-cert.zone_id
}

resource "aws_acm_certificate_validation" "ecs-acm-cert" {
  certificate_arn         = aws_acm_certificate.ecs-acm-cert.arn
  validation_record_fqdns = [for record in aws_route53_record.ecs-acm-cert : record.fqdn]
}

# route53
resource "aws_route53_record" "ecs-acm-cert1" {
  zone_id = data.aws_route53_zone.ecs-acm-cert.zone_id
  name    = "tripinky.com"
  type    = "A"

  alias {
    name                   = aws_lb.e-learning-alb.dns_name
    zone_id                = aws_lb.e-learning-alb.zone_id
    evaluate_target_health = true
  }
}

#route53 health check
resource "aws_route53_health_check" "tripinky" {
  failure_threshold = "5"
  fqdn              = "tripinky.com"
  port              = 443
  request_interval  = "30"
  resource_path     = "/"
  search_string     = "tripinky"
  type              = "HTTPS_STR_MATCH"
}