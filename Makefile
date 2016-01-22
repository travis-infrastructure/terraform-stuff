.PHONY: all
all:
	$(MAKE) all -C staging
	$(MAKE) all -C production

.PHONY: clean
clean:
	$(MAKE) clean -C staging
	$(MAKE) clean -C production

.PHONY: terraform-config
terraform-config:
	$(MAKE) terraform-config -C staging
	$(MAKE) terraform-config -C production
