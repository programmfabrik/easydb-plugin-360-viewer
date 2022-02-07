PLUGIN_NAME = easydb-360-viewer-plugin

EASYDB_LIB = easydb-library

L10N_FILES = l10n/$(PLUGIN_NAME).csv
L10N_GOOGLE_KEY = 1Z3UPJ6XqLBp-P8SUf-ewq4osNJ3iZWKJB83tc6Wrfn0
L10N_GOOGLE_GID = 473765655

INSTALL_FILES = \
	$(WEB)/l10n/cultures.json \
	$(WEB)/l10n/de-DE.json \
	$(WEB)/l10n/en-US.json \
	$(WEB)/l10n/es-ES.json \
	$(WEB)/l10n/it-IT.json \
	$(CSS) \
	$(JS) \
	manifest.yml

COFFEE_FILES = src/webfrontend/Viewer360AssetDetailPlugin.coffee
SCSS_FILES = src/webfrontend/scss/easydb-360-viewer-plugin.scss

LIB_FILES = src/lib/three.min.js \
	src/lib/panolens.min.js

all: build

include $(EASYDB_LIB)/tools/base-plugins.make

${JS}: $(subst .coffee,.coffee.js,${COFFEE_FILES}) ${LIB_FILES}
	mkdir -p $(dir $@)
	cat $^ > $@

build: code $(L10N) buildinfojson

code: $(JS) css

clean: clean-base

wipe: wipe-base

