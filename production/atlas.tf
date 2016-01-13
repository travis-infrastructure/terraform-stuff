provider "atlas" {}

resource "atlas_artifact" "travis-worker-aws-image" {
  name = "travis-ci/worker"
  type = "amazon.image"
  version = "latest"
}

resource "atlas_artifact" "travis-worker-gce-image" {
  name = "travis-ci/worker"
  type = "google.image"
  version = "37"
}
