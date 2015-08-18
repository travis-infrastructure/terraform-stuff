CLOUD_INITS := \
	cloud-init/travis-worker-gce-com-prod \
	cloud-init/travis-worker-gce-com-staging \
	cloud-init/travis-worker-gce-org-prod \
	cloud-init/travis-worker-gce-org-staging

SED ?= sed
TRVS ?= trvs
GOOGLE_ACCOUNT_FILE ?= gce.json
ENV_GENERATE_CMD ?= $(TRVS) generate-config -p travis_worker -f env
ENV_EXPORT_SED ?= $(SED) 's/^/export /;s/=/"/;s/$$/"/'

.PHONY: all
all: $(CLOUD_INITS)

.PHONY: clean
clean:
	$(RM) envs/*.env
	$(RM) $(CLOUD_INITS)

cloud-init/travis-worker-gce-%: travis-worker-gce.sh.in envs/travis-worker-gce-%.env
	bin/render-gce-travis-worker-cloud-init $< $@ > $@

envs/travis-worker-gce-com-prod.env:
	$(ENV_GENERATE_CMD) --pro gce-workers production | $(ENV_EXPORT_SED) > $@

envs/travis-worker-gce-com-staging.env:
	$(ENV_GENERATE_CMD) --pro gce-workers staging | $(ENV_EXPORT_SED) > $@

envs/travis-worker-gce-org-prod.env:
	$(ENV_GENERATE_CMD) gce-workers production | $(ENV_EXPORT_SED) > $@

envs/travis-worker-gce-org-staging.env:
	$(ENV_GENERATE_CMD) gce-workers staging | $(ENV_EXPORT_SED) > $@
