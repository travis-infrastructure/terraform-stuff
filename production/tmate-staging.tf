#
# DNS
#

resource "aws_route53_record" "tmate-edge-staging" {
  zone_id = "${var.external_zone_id}"
  name = "tmate-staging.travisci.net"
  type = "A"
  ttl = "300"
  records = [
    "${google_compute_address.tmate-edge-staging-ip.address}",
    "${aws_eip.tmate-staging-ip.public_ip}"
  ]
}

resource "aws_route53_record" "tmate-edge-staging-gce" {
  zone_id = "${var.external_zone_id}"
  name = "tmate-gce-staging.travisci.net"
  type = "A"
  ttl = "300"
  records = ["${google_compute_address.tmate-edge-staging-ip.address}"]
}

resource "aws_route53_record" "tmate-edge-staging-aws" {
  zone_id = "${var.external_zone_id}"
  name = "tmate-aws-staging.travisci.net"
  type = "A"
  ttl = "300"
  records = ["${aws_eip.tmate-staging-ip.public_ip}"]
}

#
# GCE
#

resource "google_compute_instance" "tmate-edge-staging" {
  count = 1
  name = "tmate-edge-staging"
  machine_type = "${var.tmate_gce_machine_type}"
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
      nat_ip = "${google_compute_address.tmate-edge-staging-ip.address}"
    }
  }

  metadata_startup_script = <<EOT
#!/usr/bin/env bash
echo 127.0.1.1 tmate-gce-staging.travisci.net tmate-gce-staging >> /etc/hosts
hostname tmate-gce-staging
${file(format("cloud-init/travis-tmate-edge-staging"))}
EOT
}

resource "google_compute_address" "tmate-edge-staging-ip" {
  name = "tmate-edge-staging-ip"
  region = "us-central1"
}

#
# AWS
#

resource "aws_instance" "tmate-edge-aws-staging" {
  ami = "${atlas_artifact.tmate-edge-aws-image.metadata_full.ami_id}"

  instance_type = "${var.tmate_aws_machine_type}"
  tags {
    Name = "tmate-edge-staging"
  }

  availability_zone = "${var.aws_public_subnet_az}"
  subnet_id = "${var.aws_public_subnet_id}"

  vpc_security_group_ids = ["${aws_security_group.tmate-edge.id}"]

  user_data = <<EOT
#!/usr/bin/env bash
echo 127.0.1.1 tmate-aws-staging.travisci.net tmate-aws-staging >> /etc/hosts
hostname tmate-aws-staging
${file(format("cloud-init/travis-tmate-edge-staging"))}
EOT
}

resource "aws_eip" "tmate-staging-ip" {
  instance = "${aws_instance.tmate-edge-aws-staging.id}"
  vpc = true
}
