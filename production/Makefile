NODE_JSONS := \
	nodes/travis-worker-gce-com-prod.json \
	nodes/travis-worker-gce-org-prod.json \
	nodes/travis-worker-gce-com-staging.json \
	nodes/travis-worker-gce-org-staging.json

CLOUD_INITS := \
	cloud-init/travis-worker-gce-com-prod \
	cloud-init/travis-worker-gce-org-prod \
	cloud-init/travis-worker-gce-com-staging \
	cloud-init/travis-worker-gce-org-staging

.PHONY: all
all: $(NODE_JSONS) $(CLOUD_INITS)

.PHONY: clean
clean:
	$(RM) envs/*.env nodes/*.json cloud-init/*

include $(shell git rev-parse --show-toplevel)/rules.mk
