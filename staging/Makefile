NODE_JSONS :=

CLOUD_INITS :=

.PHONY: all
all: $(NODE_JSONS) $(CLOUD_INITS)

.PHONY: clean
clean:
	$(RM) envs/*.env nodes/*.json cloud-init/*

include $(shell git rev-parse --show-toplevel)/rules.mk
