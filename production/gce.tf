provider "google" {}

module "gce_org_prod_workers" {
  source = "github.com/travis-infrastructure/tf_gce_travis_worker"
  instance_count = 11
  site = "org"
  environment = "prod"
  machine_type = "g1-small"
  zone = "us-central1-b"
  image = "${atlas_artifact.travis-worker-gce-image.id}"
}

module "gce_org_prod2_workers" {
  source = "github.com/travis-infrastructure/tf_gce_travis_worker"
  instance_count = 6
  site = "org"
  environment = "prod2"
  machine_type = "g1-small"
  zone = "us-central1-b"
  image = "${atlas_artifact.travis-worker-gce-image.id}"
}

module "gce_org_prod3_workers" {
  source = "github.com/travis-infrastructure/tf_gce_travis_worker"
  instance_count = 6
  site = "org"
  environment = "prod3"
  machine_type = "g1-small"
  zone = "us-central1-b"
  image = "${atlas_artifact.travis-worker-gce-image.id}"
}

module "gce_org_prod4_workers" {
  source = "github.com/travis-infrastructure/tf_gce_travis_worker"
  instance_count = 12
  site = "org"
  environment = "prod4"
  machine_type = "g1-small"
  zone = "us-central1-b"
  image = "${atlas_artifact.travis-worker-gce-image.id}"
}

module "gce_org_prod5_workers" {
  source = "github.com/travis-infrastructure/tf_gce_travis_worker"
  instance_count = 12
  site = "org"
  environment = "prod5"
  machine_type = "g1-small"
  zone = "us-central1-b"
  image = "${atlas_artifact.travis-worker-gce-image.id}"
}

module "gce_com_prod_workers" {
  source = "github.com/travis-infrastructure/tf_gce_travis_worker"
  instance_count = 10
  site = "com"
  environment = "prod"
  machine_type = "g1-small"
  zone = "us-central1-b"
  image = "${atlas_artifact.travis-worker-gce-image.id}"
}

module "gce_com_prod2_workers" {
	source = "github.com/travis-infrastructure/tf_gce_travis_worker"
	instance_count = 6
	site = "com"
	environment = "prod2"
	machine_type = "g1-small"
	zone = "us-central1-b"
	image = "${atlas_artifact.travis-worker-gce-image.id}"
}

module "gce_com_prod3_workers" {
	source = "github.com/travis-infrastructure/tf_gce_travis_worker"
	instance_count = 6
	site = "com"
	environment = "prod3"
	machine_type = "g1-small"
	zone = "us-central1-b"
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
