URL := https://pagure.io/releases/pungi/pungi-$(shell cat version).tar.bz2
SRC_FILE := $(notdir $(URL))

SHELL = bash

.PHONY: get-sources
get-sources: $(SRC_FILE)

UNTRUSTED_SUFF := .UNTRUSTED

$(SRC_FILE): sources
	@wget -q -N -O $@$(UNTRUSTED_SUFF) $(URL)
	@sha256sum --status -c <(cat $< | sed -e 's:$(SRC_FILE):\0$(UNTRUSTED_SUFF):') || \
		{ echo "Wrong SHA256 checksum on $@$(UNTRUSTED_SUFF)!"; exit 1; }
	@mv $@$(UNTRUSTED_SUFF) $@

.PHONY: verify-sources
verify-sources:
