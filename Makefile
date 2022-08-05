PLUGIN_NAME = easydb-plugin-360-viewer
ZIP_NAME ?= "${PLUGIN_NAME}.zip"

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
SCSS_FILES = src/webfrontend/scss/easydb-plugin-360-viewer.scss

LIB_FILES = src/lib/three.min.js \
	src/lib/panolens.min.js

all: build

include $(EASYDB_LIB)/tools/base-plugins.make

${JS}: $(subst .coffee,.coffee.js,${COFFEE_FILES}) ${LIB_FILES}
	mkdir -p $(dir $@)
	cat $^ > $@

code: $(JS) css

clean: clean-base
	rm -rf build/

wipe: wipe-base

build: clean code $(L10N) buildinfojson ## copy files to build folder
	mkdir -p build/${PLUGIN_NAME}
	cp -r l10n build/${PLUGIN_NAME}
	cp -r build/webfrontend build/${PLUGIN_NAME}
	cp -r manifest.yml build/${PLUGIN_NAME}/manifest.yml

zip: build ## build zip file
	cd build && zip ${ZIP_NAME} -r ${PLUGIN_NAME}/
