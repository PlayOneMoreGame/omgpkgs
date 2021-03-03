ROOT_DIR := $(shell pwd)
TF_DIR := $(ROOT_DIR)/terraform

.DEFAULT_GOAL := list
.ONESHELL:

build:
	nix-build

publish:
	nix-build | cachix push omg

###############################################################################
#                              TERRAFORM TARGETS                              #
###############################################################################

tf-ci: tf-ci-init
	@cd $(TF_DIR)/ci
	terraform plan

tf-ci-init:
	@cd $(TF_DIR)/ci
	terraform init

tf-ci-apply: tf-ci-init
	@cd $(TF_DIR)/ci
	terraform apply -auto-approve

tf-ci-upgrade:
	@cd $(TF_DIR)/ci
	terraform init -upgrade

tf-ci-output:
	@cd $(TF_DIR)/ci
	@terraform output -json

# https://stackoverflow.com/a/26339924/11547115
.PHONY: list
list:
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'

