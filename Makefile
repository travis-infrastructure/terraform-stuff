CLOUD_INITS := \
	cloud-init/travis-worker-gce-com-prod \
	cloud-init/travis-worker-gce-com-staging \
	cloud-init/travis-worker-gce-org-prod \
	cloud-init/travis-worker-gce-org-staging

SED ?= sed

.PHONY: all
all: $(CLOUD_INITS)

cloud-init/travis-worker-gce-%: travis-worker.sh.in envs/travis-worker-gce-%.env
	if [ ! -f envs/$(notdir $@).env ] ; then echo Missing envs/$(notdir $@).env file ; exit 1 ; fi ; \
	if [ ! -f gce.json ] ; then echo Missing gce.json file ; exit 1 ; fi ; \
	IFS=- read -a nameparts <<< "$(notdir $@)" ; \
	$(SED) \
		-e "/___ENV___/r envs/$(notdir $@).env" \
		-e "/___ENV___/d" \
		-e "/___GCE_JSON___/r gce.json" \
		-e "/___GCE_JSON___/d" \
		-e "s/___SITE___/$${nameparts[2]}/g" \
		-e "s/___ENVIRONMENT___/$${nameparts[3]}/g" \
		< $< > $@
