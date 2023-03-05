SHELL := /bin/bash

.DEFAULT_GOAL := help

.PHONY: up
up: down volume
	@echo -e "\n\n# Starting joomla"
	@echo "============================="
	@source ./scripts/environment.sh && docker-compose -f docker-compose.yml up -d

.PHONY: map
map: down volume
	@echo -e "\n\n# Starting joomla & Mapping files to joomla installation"
	@echo "============================="
	./scripts/map.sh
	@source ./scripts/environment.sh && docker-compose -f docker-compose.yml -f docker-compose.map.yml up -d

.PHONY: down
down:
	@echo -e "\n\n# Stopping joomla"
	@echo "============================="
	@source ./scripts/environment.sh && docker-compose down

.PHONY: volume
volume:
	@echo -e "\n\n# Creating db volume if it doesn't exist"
	@echo "============================="
	docker volume create --name=joomladb_data

.PHONY: copy
copy: clean
	@echo -e "\n\n# Copying files to joomla installation"
	@echo "============================="
	./scripts/copy.sh

.PHONY: build
build: clean
	@echo -e "\n\n# Building package"
	@echo "============================="
	./scripts/build.sh

.PHONY: headers
headers:
	@echo -e "\n\n# Adding/updating copyright headers in ./src"
	@echo "============================="
	@source ./scripts/environment.sh && php -f ./scripts/headers.php

.PHONY: clean
clean:
	@echo -e "\n\n# Cleaning up ./dist directory"
	@echo "============================="
	@source ./scripts/environment.sh && rm -rf "$${DIST_DIR:?}"

.PHONY: dependencies
dependencies:
	@echo -e "\n\n# Dependencies list"
	@echo "============================="
	./scripts/dependencies.sh

#.PHONY: watch
#watch:
#	while true; do \
##		inotifywait -qr -e modify -e create -e delete -e move src; \
#		inotifywait -r -e modify -e create -e delete -e move src; \
#		make dev; \
#	done

.PHONY: lint
lint:
	@echo -e "\n\n# Lint"
	@echo "============================="
	@$(MAKE) --no-print-directory _lint-php-cs-fixer
	@$(MAKE) --no-print-directory _lint-phpcs

.PHONY: _lint-php-cs-fixer
_lint-php-cs-fixer:
	@echo -e "\n\n# PHP CS Fixer"
	@echo "============================="
	docker-compose -f docker-compose.quality.yml run --rm php-cs-fixer

.PHONY: _lint-phpcs
_lint-phpcs:
	@echo -e "\n\n# PHP CodeSniffer"
	@echo "============================="
	docker-compose -f docker-compose.quality.yml run --rm phpcs

.PHONY: help
help:
	@echo "Available Targets: "
	@echo "up      - Start joomla docker environment without mapping ./src files"
	@echo "map     - Start joomla docker environment & Map ./src files to the joomla installation"
	@echo "down    - Stop joomla docker environment"
	@echo "copy    - Copy files to development environment"
	@echo "build   - Create Joomla package. (in ./dist)"
	@echo "clean   - Clean ./dist directory"
	@echo "headers - Add/update copyright headers + XML metadata in ./src"
#	@echo "watch - Watch ./src directory for changes"
	@echo "lint    - Run PHP lint tools (PHP CS Fixer, PHP CodeSniffer)"
	@source ./scripts/environment.sh && echo "$${META_HEADER_COPYRIGHT_TEXT}"
