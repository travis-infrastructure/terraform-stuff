provider "atlas" {}

resource "atlas_artifact" "travis-worker-gce-image" {
  name = "travis-ci/worker"
  type = "google.image"
  version = "57"
}
