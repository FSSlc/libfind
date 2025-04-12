#
# Simple Makefile
#

all:

DEST := /usr/local
INSTALL := install

install:
	@echo "Installing cmake modules ..."
	@mkdir -p $(DEST)/share/cmake/Modules/scns
	@for f in cmake-modules/*.cmake; do \
		echo "-- Installing $$f to $(DEST)/share/cmake/Modules/scns"; \
		$(INSTALL) -m 0644 -D -t $(DEST)/share/cmake/Modules/scns "$$f"; \
		sed -i "s:@INSTALL_PREFIX@:$(DEST):g" \
		"$(DEST)/share/cmake/Modules/scns/$${f#cmake-modules\/}"; \
		done
	@echo "Installing docs ..."
	@mkdir -p $(DEST)/share/libfind/docs
	@$(INSTALL) -m 0644 -D -t $(DEST)/share/libfind/docs docs/*
