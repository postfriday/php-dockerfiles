#!/usr/bin/env make
# SHELL = sh -xv

PHP_VERSION := 8.1
PHP_INTERFACE := fpm
PHP_ENVIRONMENT := development
PHP_TAG := php:${PHP_VERSION}-${PHP_INTERFACE}-${PHP_ENVIRONMENT}
PHP_INI_FILE := 8.2/etc/php.ini-development

.PHONY: help
help:      ## Shows this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: build
build: ## Build
	docker build \
		--tag ${PHP_TAG} \
		--file ./${PHP_VERSION}/Dockerfile \
		--build-arg PHP_INTERFACE=${PHP_INTERFACE} \
		--build-arg PHP_ENVIRONMENT=${PHP_ENVIRONMENT} \
		--build-arg PHP_INI_FILE=${PHP_INI_FILE} \
		.

.PHONY: run
run: ## Run
	docker run \
		--rm \
		--tty \
		--interactive \
		-v "$(PWD):/var/www/html" \
		${PHP_TAG} sh

.PHONY: build-8.2-cli-dev
build-8.2-cli-dev: ## Build PHP 8.2 CLI Development
	make build PHP_VERSION=8.2 PHP_MODE=cli PHP_ENVIRONMENT=development PHP_INI_FILE=8.2/etc/php.ini-development

.PHONY: run-8.2-cli-dev
run-8.2-cli-dev: ## Run PHP 8.2 CLI Development
	make run PHP_VERSION=8.2 PHP_MODE=cli PHP_ENVIRONMENT=development PHP_INI_FILE=8.2/etc/php.ini-development

.PHONY: build-8.2-fpm-dev
build-8.2-fpm-dev: ## Build PHP 8.2 FPM Development
	make build PHP_VERSION=8.2 PHP_MODE=fpm PHP_ENVIRONMENT=development PHP_INI_FILE=8.2/etc/php.ini-development

.PHONY: run-8.2-fpm-dev
run-8.2-fpm-dev: ## Run PHP 8.2 FPM Development
	make run PHP_VERSION=8.2 PHP_MODE=fpm PHP_ENVIRONMENT=development PHP_INI_FILE=8.2/etc/php.ini-development

.PHONY: build-8.2-cli-prod
build-8.2-cli-prod: ## Build PHP 8.2 CLI Production
	make build PHP_VERSION=8.2 PHP_MODE=cli PHP_ENVIRONMENT=production PHP_INI_FILE=8.2/etc/php.ini-production

.PHONY: run-8.2-cli-prod
run-8.2-cli-prod: ## Run PHP 8.2 CLI Production
	make run PHP_VERSION=8.2 PHP_MODE=cli PHP_ENVIRONMENT=production PHP_INI_FILE=8.2/etc/php.ini-production

.PHONY: build-8.2-fpm-prod
build-8.2-fpm-prod: ## Build PHP 8.2 FPM Production
	make build PHP_VERSION=8.2 PHP_MODE=fpm PHP_ENVIRONMENT=production PHP_INI_FILE=8.2/etc/php.ini-production

.PHONY: run-8.2-fpm-prod
run-8.2-fpm-prod: ## Run PHP 8.2 FPM Production
	make run PHP_VERSION=8.2 PHP_MODE=fpm PHP_ENVIRONMENT=production PHP_INI_FILE=8.2/etc/php.ini-production
