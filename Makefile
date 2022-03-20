.DEFAULT_GOAL := help

COM_NAME = com_papermanager
PLG_NAME = plg_papermanager
PKG_NAME = pkg_papermanager

.PHONY: dev
dev: clean
	@echo -e "\n\n# Copying to build directory"
	@echo "============================="
	mkdir build
#	mkdir build/administrator
#	mkdir build/administrator/components
#	mkdir build/administrator/components/$(COM_NAME)
	mkdir -p build/administrator/components/$(COM_NAME)
	cp -ar src/$(COM_NAME)/admin/. build/administrator/components/$(COM_NAME)
	cp -ar src/$(COM_NAME)/papermanager.xml build/administrator/components/$(COM_NAME)
#	mkdir build/components
#	mkdir build/components/$(COM_NAME)
	mkdir -p build/components/$(COM_NAME)
	cp -ar src/$(COM_NAME)/site/. build/components/$(COM_NAME)
#	mkdir build/plugins
#	mkdir build/plugins/content
#	mkdir build/plugins/content/papermanager
	mkdir -p build/plugins/content/papermanager
	cp -ar src/$(PLG_NAME)/. build/plugins/content/papermanager
#	mkdir build/administrator/manifests
#	mkdir build/administrator/manifests/packages
	mkdir -p build/administrator/manifests/packages
	cp -ar src/$(PKG_NAME).xml build/administrator/manifests/packages
	@echo -e "\n\n# Finished"
	@echo "=========="
	@echo "Files copied to development environment."

.PHONY: build
build: clean
	@echo -e "\n\n# Copying to build directory"
	@echo "============================="
	mkdir build
	cp -a src/$(COM_NAME) build/$(COM_NAME)
	cp -a src/$(PLG_NAME) build/$(PLG_NAME)
	cp -a src/$(PKG_NAME).xml build/$(PKG_NAME).xml
	find build/$(COM_NAME) -type d -not -path build/$(COM_NAME) -exec cp build/$(COM_NAME)/index.html {} \;
	find build/$(PLG_NAME) -type d -not -path build/$(PLG_NAME) -exec cp build/$(PLG_NAME)/index.html {} \;
	@echo -e "\n\n# Compressing from build directory"
	@echo "============================="
	mkdir build/packages
	cd build/$(COM_NAME);zip -r9 ../packages/$(COM_NAME).zip . -x \*.swp
	cd build/$(PLG_NAME);zip -r9 ../packages/$(PLG_NAME).zip . -x \*.swp
	rm -rf build/$(COM_NAME)
	rm -rf build/$(PLG_NAME)
	cd build;zip -r9 $(PKG_NAME).zip . -x \*.swp
	rm -rf build/packages
	rm -rf build/$(PKG_NAME).xml
	@echo -e "\n\n# Finished"
	@echo "=========="
	@echo "Joomla package can be found in ./build directory."

.PHONY: clean
clean:
	@echo -e "\n\n# Cleaning up build directory"
	@echo "============================="
	rm -rf build

.PHONY: watch
watch:
	while true; do \
#		inotifywait -qr -e modify -e create -e delete -e move src; \
		inotifywait -r -e modify -e create -e delete -e move src; \
		make dev; \
	done

.PHONY: help
help:
	@echo "Available Targets: "
	@echo "build - Create Joomla package."
	@echo "clean - Clean build directory"
	@echo "watch - Watch src directory for changes"
