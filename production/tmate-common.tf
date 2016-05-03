variable "tmate_aws_machine_type"     { default = "c4.large" }
variable "tmate_gce_machine_type"     { default = "n1-highcpu-2" }

resource "atlas_artifact" "tmate-edge-gce-image" {
  name = "travis-ci/tmate-edge"
  type = "google.image"
}

resource "atlas_artifact" "tmate-edge-aws-image" {
  name = "travis-ci/tmate-edge"
  type = "amazon.image"
}

resource "google_compute_firewall" "tmate-edge" {
  name = "tmate-edge-sshd"
  network = "default"

  allow {
    protocol = "tcp"
    ports = ["222"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags = ["tmate-edge"]
}

resource "aws_security_group" "tmate-edge" {
  vpc_id = "${var.aws_vpc_id}"
  name = "allow_all"

  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
      from_port = 222
      to_port = 222
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
  }
}
