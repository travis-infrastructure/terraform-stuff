provider "aws" {}

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
