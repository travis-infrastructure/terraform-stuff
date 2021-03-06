provider "google" {}

variable "gce_image_project" {
  type = "string"
  description = "The project that contains the GCE worker images"
}

variable "gce_worker_image_id" {}

module "gce_org_staging_workers" {
  source = "github.com/travis-infrastructure/tf_gce_travis_worker"
  instance_count = 2
  site = "org"
  environment = "staging"
  machine_type = "g1-small"
  zone = "us-central1-b"
  image = "${var.gce_image_project}/${var.gce_worker_image_id}"
}

module "gce_com_staging_workers" {
  source = "github.com/travis-infrastructure/tf_gce_travis_worker"
  instance_count = 1
  site = "com"
  environment = "staging"
  machine_type = "g1-small"
  zone = "us-central1-b"
  image = "${var.gce_image_project}/${var.gce_worker_image_id}"
}
