#
# DNS
#

resource "aws_route53_record" "tmate-edge-production" {
  zone_id = "${var.external_zone_id}"
  name = "tmate-production.travisci.net"
  type = "A"
  ttl = "300"
  records = [
    "${google_compute_address.tmate-edge-production-org-ip.address}",
    "${aws_eip.tmate-production-ip.public_ip}"
  ]
}

resource "aws_route53_record" "tmate-edge-production-gce" {
  zone_id = "${var.external_zone_id}"
  name = "tmate-gce-production.travisci.net"
  type = "A"
  ttl = "300"
  records = ["${google_compute_address.tmate-edge-production-org-ip.address}"]
}

resource "aws_route53_record" "tmate-edge-production-aws" {
  zone_id = "${var.external_zone_id}"
  name = "tmate-aws-production.travisci.net"
  type = "A"
  ttl = "300"
  records = ["${aws_eip.tmate-production-ip.public_ip}"]
}

#
# GCE
#

resource "google_compute_instance" "tmate-edge-production-org" {
  count = 1
  name = "tmate-edge-production"
  machine_type = "n1-highcpu-2"
  zone = "us-central1-b"
  tags = ["tmate-edge"]

  disk {
    auto_delete = true
    image = "${atlas_artifact.tmate-edge-gce-image.metadata_full.project_id}/${atlas_artifact.tmate-edge-gce-image.metadata_full.name}"
    type = "pd-standard"
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = "${google_compute_address.tmate-edge-production-org-ip.address}"
    }
  }

  metadata_startup_script = <<EOT
#!/usr/bin/env bash
echo 127.0.1.1 tmate-gce-production.travisci.net tmate-gce-production >> /etc/hosts
hostname tmate-gce-production
${file(format("cloud-init/travis-tmate-edge-org-production"))}
EOT
}

resource "google_compute_address" "tmate-edge-production-org-ip" {
  name = "tmate-edge-production-org-ip"
  region = "us-central1"
}

#
# AWS
#

resource "aws_instance" "tmate-edge-aws-production" {
  ami = "${atlas_artifact.tmate-edge-aws-image.metadata_full.ami_id}"

  instance_type = "c4.large"
  tags {
    Name = "tmate-edge-production"
  }

  availability_zone = "us-east-1b"
  subnet_id = "subnet-a8a3dcdf"

  vpc_security_group_ids = ["${aws_security_group.tmate-edge.id}"]

  user_data = <<EOT
#!/usr/bin/env bash
echo 127.0.1.1 tmate-aws-production.travisci.net tmate-aws-production >> /etc/hosts
hostname tmate-aws-production
${file(format("cloud-init/travis-tmate-edge-org-production"))}
EOT
}

resource "aws_eip" "tmate-production-ip" {
  instance = "${aws_instance.tmate-edge-aws-production.id}"
  vpc = true
}
