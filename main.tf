provider "aws" {
  region = var.region
}

variable "production" {
  default = "green"
}

module "base" {
  source     = "terraform-in-action/aws/bluegreen//modules/base"
  production = var.production
}

module "green" {
  source      = "terraform-in-action/aws/bluegreen//modules/autoscaling"
  app_version = "v1.0"
  label       = "green"
  base        = module.base
}

output "lb_dns_name" {
  value = module.base.lb_dns_name
}
