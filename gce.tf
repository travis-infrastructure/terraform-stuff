provider "google" {}

module "gce_org_prod_workers" {
  source = "github.com/travis-infrastructure/tf_gce_travis_worker"
  instance_count = 3
  site = "org"
  environment = "prod"
  image = "${var.travis_worker_image}"
}

module "gce_org_staging_workers" {
  source = "github.com/travis-infrastructure/tf_gce_travis_worker"
  instance_count = 1
  site = "org"
  environment = "staging"
  image = "${var.travis_worker_image}"
}

module "gce_com_prod_workers" {
  source = "github.com/travis-infrastructure/tf_gce_travis_worker"
  instance_count = 3
  site = "com"
  environment = "prod"
  image = "${var.travis_worker_image}"
}

module "gce_com_staging_workers" {
  source = "github.com/travis-infrastructure/tf_gce_travis_worker"
  instance_count = 1
  site = "com"
  environment = "staging"
  image = "${var.travis_worker_image}"
}
