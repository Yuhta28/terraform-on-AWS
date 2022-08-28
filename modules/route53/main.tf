data "aws_route53_zone" "yuta-aws" {
  name = "yuta-aws.name"
}

resource "aws_route53_record" "terraform-yuta-alb" {
  zone_id = data.aws_route53_zone.yuta-aws.zone_id
  name    = "yuta-aws.name"
  type    = "A"
  alias {
    name                   = var.terraform_alb_name
    zone_id                = var.terraform_alb_zone_id
    evaluate_target_health = true
  }
}