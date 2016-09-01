NODE_JSONS := \
	nodes/travis-worker-gce-com-prod.json \
	nodes/travis-worker-gce-com-prod2.json \
	nodes/travis-worker-gce-com-prod3.json \
	nodes/travis-worker-gce-org-prod.json \
	nodes/travis-worker-gce-org-prod2.json \
	nodes/travis-worker-gce-org-prod3.json \
	nodes/travis-worker-gce-org-prod4.json \
	nodes/travis-worker-gce-org-prod5.json \
	nodes/travis-worker-gce-com-staging.json \
	nodes/travis-worker-gce-org-staging.json

CLOUD_INITS := \
	cloud-init/travis-worker-gce-com-prod \
	cloud-init/travis-worker-gce-com-prod2 \
	cloud-init/travis-worker-gce-com-prod3 \
	cloud-init/travis-worker-gce-org-prod \
	cloud-init/travis-worker-gce-org-prod2 \
	cloud-init/travis-worker-gce-org-prod3 \
	cloud-init/travis-worker-gce-org-prod4 \
	cloud-init/travis-worker-gce-org-prod5 \
	cloud-init/travis-worker-gce-com-staging \
	cloud-init/travis-worker-gce-org-staging \
	cloud-init/travis-tmate-edge-staging \
	cloud-init/travis-tmate-edge-production

.PHONY: all
all: $(NODE_JSONS) $(CLOUD_INITS)

.PHONY: clean
clean:
	$(RM) envs/*.env nodes/*.json cloud-init/*

.PHONY: terraform-config
terraform-config:
	terraform remote config -backend=s3 \
  -backend-config="bucket=travis-terraform-state" \
  -backend-config="key=terraform-stuff/production.tfstate" \
  -backend-config="region=us-east-1" \
  -backend-config="encrypt=true"

include $(shell git rev-parse --show-toplevel)/rules.mk
