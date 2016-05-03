provider "aws" {}

variable "internal_zone_id" {}
variable "external_zone_id" {}

variable "aws_public_subnet_az" { default = "us-east-1b"}
variable "aws_public_subnet_id" { default = "subnet-a8a3dcdf"}
variable "aws_vpc_id"           { default = "vpc-f4188191"}

resource "aws_route53_record" "macstadium_worker_jupiter_brain" {
  zone_id = "${var.external_zone_id}"
  name = "worker-jupiter-brain.macstadium-us-se-1.travisci.net"
  type = "A"
  ttl = "300"
  records = ["10.182.0.241"]
}

resource "aws_route53_record" "macstadium_vpn" {
  zone_id = "${var.external_zone_id}"
  name = "vpn.macstadium-us-se-1.travisci.net"
  type = "A"
  ttl = "300"
  records = ["208.78.110.60"]
}
