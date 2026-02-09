#!/bin/bash

DEST := /usr/local
INSTALL := install
SHELL = /bin/bash

all: install
.PHONY : all

install:
	@echo "Installing cmake modules ..."
	@echo mkdir -p $(DEST)/share/cmake/Modules/scns
	@mkdir -p $(DEST)/share/cmake/Modules/scns

	@for f in $$(ls -1 cmake-modules/*.cmake); do \
		echo "-- Installing $$f to $(DEST)/share/cmake/Modules/scns"; \
		$(INSTALL) -m 0644 -D -t $(DEST)/share/cmake/Modules/scns "$$f"; \
		if [[ "$(uname)" == "Darwin" ]]; then \
			echo sed -i '' \
			-e "s:@INSTALL_PREFIX@:$(DEST):g" \
			-e "s:/opt/anaconda1anaconda2anaconda3:$(DEST):g" \
			"$(DEST)/share/cmake/Modules/scns/${f#cmake-modules\/}"; \
		else \
			echo sed -i -e "s:@INSTALL_PREFIX@:$(DEST):g" \
				-e "s:/opt/anaconda1anaconda2anaconda3:$(DEST):g" \
			"$(DEST)/share/cmake/Modules/scns/${f#cmake-modules\/}"; \
		fi; \
	done
	@echo "Installing docs ..."
	@mkdir -p $(DEST)/share/libfind/docs
	@$(INSTALL) -m 0644 -D -t $(DEST)/share/libfind/docs docs/*
