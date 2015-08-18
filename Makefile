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

cloud-init/travis-worker-gce-%: travis-worker.sh.in envs/travis-worker-gce-%.env
	if [ ! -f envs/$(notdir $@).env ] ; then echo Missing envs/$(notdir $@).env file ; exit 1 ; fi ; \
	if [ "x$(GOOGLE_ACCOUNT_FILE)" = "x" ] || [ ! -f $(GOOGLE_ACCOUNT_FILE) ] ; \
		then echo Missing $$GOOGLE_ACCOUNT_FILE file ; \
		exit 1 ; \
	fi ; \
	IFS=- read -a nameparts <<< "$(notdir $@)" ; \
	$(SED) \
		-e "/___ENV___/r envs/$(notdir $@).env" \
		-e "/___ENV___/d" \
		-e "/___GCE_JSON___/r $(GOOGLE_ACCOUNT_FILE)" \
		-e "/___GCE_JSON___/d" \
		-e "s/___SITE___/$${nameparts[2]}/g" \
		-e "s/___ENVIRONMENT___/$${nameparts[3]}/g" \
		< $< > $@

envs/travis-worker-gce-com-prod.env:
	$(ENV_GENERATE_CMD) --pro gce-workers production | $(ENV_EXPORT_SED) > $@

envs/travis-worker-gce-com-staging.env:
	$(ENV_GENERATE_CMD) --pro gce-workers staging | $(ENV_EXPORT_SED) > $@

envs/travis-worker-gce-org-prod.env:
	$(ENV_GENERATE_CMD) gce-workers production | $(ENV_EXPORT_SED) > $@

envs/travis-worker-gce-org-staging.env:
	$(ENV_GENERATE_CMD) gce-workers staging | $(ENV_EXPORT_SED) > $@
