provider "google" {}

module "gce_org_prod_workers" {
  source = "github.com/travis-infrastructure/tf_gce_travis_worker"
  instance_count = 6
  site = "org"
  environment = "prod"
  image = "${atlas_artifact.travis-worker-gce-image.id}"
}

module "gce_org_staging_workers" {
  source = "github.com/travis-infrastructure/tf_gce_travis_worker"
  instance_count = 1
  site = "org"
  environment = "staging"
  image = "${atlas_artifact.travis-worker-gce-image.id}"
}

module "gce_com_prod_workers" {
  source = "github.com/travis-infrastructure/tf_gce_travis_worker"
  instance_count = 3
  site = "com"
  environment = "prod"
  image = "${atlas_artifact.travis-worker-gce-image.id}"
}

module "gce_com_staging_workers" {
  source = "github.com/travis-infrastructure/tf_gce_travis_worker"
  instance_count = 1
  site = "com"
  environment = "staging"
  image = "${atlas_artifact.travis-worker-gce-image.id}"
}

resource "google_compute_instance" "ubuntu_trusty_micro_playground" {
  count = 1
  name = "ubuntu-trusty-micro-playground"
  machine_type = "f1-micro"
  zone = "us-central1-f"
  tags = ["playground"]

  can_ip_forward = false

  disk {
    auto_delete = true
    image = "ubuntu-1404-trusty-v20150909a"
    type = "pd-standard"
  }

  network_interface {
    network = "default"
    access_config {
      # Ephemeral IP
    }
  }
}
