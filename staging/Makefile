NODE_JSONS := \
	nodes/travis-worker-gce-org-staging.json

CLOUD_INITS := \
	cloud-init/travis-worker-gce-org-staging

.PHONY: all
all: $(NODE_JSONS) $(CLOUD_INITS)

.PHONY: clean
clean:
	$(RM) envs/*.env nodes/*.json cloud-init/*

.PHONY: terraform-config
terraform-config:
	terraform remote config -backend-config="name=travis-ci/terraform-stuff-staging"

include $(shell git rev-parse --show-toplevel)/rules.mk
