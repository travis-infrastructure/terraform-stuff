TOP ?= $(shell git rev-parse --show-toplevel)
SED ?= sed
TRVS ?= trvs

ENV_GENERATE_CMD ?= cd $(TOP) ; $(TRVS) generate-config -p travis_worker -f env
ENV_EXPORT_SED ?= $(SED) 's/^/export /;s/=/="/;s/$$/"/'
RENDER_GCE_TRAVIS_WORKER_CLOUD_INIT ?= $(TOP)/bin/render-gce-travis-worker-cloud-init
RENDER_GCE_TRAVIS_WORKER_NODE_JSON ?= $(TOP)/bin/render-gce-travis-worker-node-json

cloud-init/travis-worker-gce-%: $(TOP)/travis-worker-gce.bash.in nodes/travis-worker-gce-%.json envs/travis-worker-gce-%.env
	$(RENDER_GCE_TRAVIS_WORKER_CLOUD_INIT) $< $@ > $@

nodes/travis-worker-gce-%.json: envs/travis-worker-gce-%.env
	$(RENDER_GCE_TRAVIS_WORKER_NODE_JSON) $< > $@

envs/travis-worker-gce-com-prod.env:
	$(ENV_GENERATE_CMD) --pro gce-workers production | $(ENV_EXPORT_SED) > $(shell pwd)/$@

envs/travis-worker-gce-com-prod2.env:
	$(ENV_GENERATE_CMD) --pro gce-workers production2 | $(ENV_EXPORT_SED) > $(shell pwd)/$@

envs/travis-worker-gce-com-prod3.env:
	$(ENV_GENERATE_CMD) --pro gce-workers production3 | $(ENV_EXPORT_SED) > $(shell pwd)/$@

envs/travis-worker-gce-com-staging.env:
	$(ENV_GENERATE_CMD) --pro gce-workers staging | $(ENV_EXPORT_SED) > $(shell pwd)/$@

envs/travis-worker-gce-org-prod.env:
	$(ENV_GENERATE_CMD) gce-workers production | $(ENV_EXPORT_SED) > $(shell pwd)/$@

envs/travis-worker-gce-org-prod2.env:
	$(ENV_GENERATE_CMD) gce-workers production2 | $(ENV_EXPORT_SED) > $(shell pwd)/$@

envs/travis-worker-gce-org-prod3.env:
	$(ENV_GENERATE_CMD) gce-workers production3 | $(ENV_EXPORT_SED) > $(shell pwd)/$@

envs/travis-worker-gce-org-staging.env:
	$(ENV_GENERATE_CMD) gce-workers staging | $(ENV_EXPORT_SED) > $(shell pwd)/$@
