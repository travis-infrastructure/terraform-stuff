CLOUD_INITS := \
	cloud-init/travis-worker-com-prod \
	cloud-init/travis-worker-com-staging \
	cloud-init/travis-worker-org-prod \
	cloud-init/travis-worker-org-staging

GENERATE_CLOUD_INIT ?= bin/generate-cloud-init
SED ?= sed

.PHONY: all
all: $(CLOUD_INITS)

cloud-init/travis-worker-%: cloud-init/travis-worker.sh.in
	if [ ! -f $@.env ] ; then echo Missing $@.env file ; exit 1 ; fi ; \
	if [ ! -f gce.json ] ; then echo Missing gce.json file ; exit 1 ; fi ; \
	IFS=- read -a nameparts <<< "$(notdir $@)" ; \
	$(SED) \
		-e "/___ENV___/r $@.env" \
		-e "/___ENV___/d" \
		-e "/___GCE_JSON___/r gce.json" \
		-e "/___GCE_JSON___/d" \
		-e "s/___SITE___/$${nameparts[2]}/g" \
		-e "s/___ENVIRONMENT___/$${nameparts[3]}/g" \
		< $^ > $@
