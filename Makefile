mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(dir $(mkfile_path))

#-------------------------------------------------------------------------------
# Global stuff.

GO=$(shell which go)
TFLINT_AWS_TAG=0.14.0
TFLINT_GCP_TAG=0.17.0
TFLINT_AZURE_TAG=0.16.0

GO=$(shell which go)
BREW_PREFIX=$(shell brew --prefix)

# Determine which version of `echo` to use. Use version from coreutils if available.
ECHOCHECK := $(shell command -v $(BREW_PREFIX)/opt/coreutils/libexec/gnubin/echo 2> /dev/null)
ifdef ECHOCHECK
    ECHO="$(BREW_PREFIX)/opt/coreutils/libexec/gnubin/echo" -e
else
    ECHO=echo
endif

#-------------------------------------------------------------------------------
# Running `make` will show the list of subcommands that will run.

all: help

.PHONY: help
## help: [help]* Prints this help message.
help:
	@ $(ECHO) "Usage:"
	@ $(ECHO) ""
	@ sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' | sed -e 's/^/ /' | \
		while IFS= read -r line; do \
			if [[ "$$line" == *"]*"* ]]; then \
				$(ECHO) "\033[1;33m$$line\033[0m"; \
			else \
				$(ECHO) "$$line"; \
			fi; \
		done

#-------------------------------------------------------------------------------
# Install

.PHONY: tools-go
## tools-go: [deps] Installs the tools using `go install`.
tools-go:
	@ $(ECHO) " "
	@ $(ECHO) "=====> Running go install..."
	go install mvdan.cc/gofumpt@latest

.PHONY: tools-linux
## tools-linux: [deps] Installs the tools using Linux-friendly approaches.
tools-linux: tools-go
	@ $(ECHO) " "
	@ $(ECHO) "=====> Running tools-linux..."
	curl -sfSL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b $$(go env GOPATH)/bin

.PHONY: tools-mac
## tools-mac: [deps] Installs the tools using Mac-friendly Homebrew.
tools-mac: tools-go
	@ $(ECHO) " "
	@ $(ECHO) "=====> Running Homebrew..."
	brew install golangci/tap/golangci-lint

#-------------------------------------------------------------------------------
# Linting

.PHONY: golint
## golint: [lint] Runs `golangci-lint` against all Go (*.go) files.
golint:
	@ $(ECHO) " "
	@ $(ECHO) "=====> Running golangci-lint..."
	- golangci-lint run --fix *.go

.PHONY: gofmt
## gofmt: [lint] Runs `gofumpt` against all Go (*.go) files.
gofmt:
	@ $(ECHO) " "
	@ $(ECHO) "=====> Running gofumpt..."
	- gofumpt -s -w .

.PHONY: markdownlint
## markdownlint: [lint] Runs `markdownlint` against all Markdown (*.md) documents.
markdownlint:
	@ $(ECHO) " "
	@ $(ECHO) "=====> Running Markdownlint..."
	- npx -y markdownlint-cli --fix '**/*.md' --ignore 'node_modules'

.PHONY: lint
## lint: [lint]* Runs ALL linting tasks.
lint: gofmt golint markdownlint

#-------------------------------------------------------------------------------
# Clean

.PHONY: clean-files
## clean-files: [clean] Clean temporary files.
clean-files:
	@ $(ECHO) " "
	@ $(ECHO) "=====> Cleaning files..."
	rm -vf *.tmp
	rm -vf .tflint.hcl *.tflint.hcl
	rm -rf /tmp/tflint-ruleset-*

.PHONY: clean-go
## clean-go: [clean] Clean Go's module cache.
clean-go:
	@ $(ECHO) " "
	@ $(ECHO) "=====> Cleaning Go module cache..."
	$(GO) clean -i -r -x -testcache -modcache -cache

.PHONY: clean
## clean: [clean]* Runs ALL cleaning tasks.
clean: clean-files

#-------------------------------------------------------------------------------
# Building and Running

.PHONY: tidy
## tidy: [build] Runs `go mod tidy`, and ensuring all dependencies are downloaded.
tidy:
	@ $(ECHO) " "
	@ $(ECHO) "=====> Running go mod tidy..."
	$(GO) mod tidy -go=1.17 -v
	$(GO) mod download -x
	$(GO) get -v ./...

.PHONY: base
## base: [build]* Generates a base, non-cloud version of the config file to `.tflint.hcl`.
base:
	@ $(ECHO) " "
	@ $(ECHO) "=====> Generating base configuration..."
	touch .tflint.hcl && rm -f .tflint.hcl
	$(GO) run main.go
	mv -vf base.tflint.hcl .tflint.hcl

#-------------------------------------------------------------------------------
# AWS

.PHONY: aws
## aws: [build]* Generates an AWS-specific version of the config file to `.tflint.hcl`.
aws: _aws-announce _aws-gen-def _aws-fetch-sdk _aws-copy-gen

# Private
.PHONY: _aws-announce
_aws-announce:
	@ $(ECHO) " "
	@ $(ECHO) "=====> Generating AWS configuration..."

# Private
.PHONY: _aws-gen-def
_aws-gen-def:
	touch .tflint.hcl && rm -f .tflint.hcl
	$(GO) run main.go -rules=aws -rules-tag=$(TFLINT_AWS_TAG)

# Private
.PHONY: _aws-fetch-sdk
_aws-fetch-sdk:
	mkdir -p /tmp/tflint-ruleset-aws
	rm -rf /tmp/tflint-ruleset-aws
	git clone --recurse-submodules --branch v$(TFLINT_AWS_TAG) --single-branch https://github.com/terraform-linters/tflint-ruleset-aws.git /tmp/tflint-ruleset-aws

# Private
.PHONY: _aws-copy-gen
_aws-copy-gen:
	cp -fv _aws.tflint.hcl.tmp /tmp/tflint-ruleset-aws/docs/rules/README.md.tmpl
	cd /tmp/tflint-ruleset-aws/rules/models/ && go run -tags generators ./generator
	cp -fv /tmp/tflint-ruleset-aws/docs/rules/README.md ./.tflint.hcl

#-------------------------------------------------------------------------------
# GCP

.PHONY: gcp
## gcp: [build]* Generates an GCP-specific version of the config file to `.tflint.hcl`.
gcp: _gcp-announce _gcp-gen-def _gcp-copy-gen

# Private
.PHONY: _gcp-announce
_gcp-announce:
	@ $(ECHO) " "
	@ $(ECHO) "=====> Generating GCP configuration..."

# Private
.PHONY: _gcp-gen-def
_gcp-gen-def:
	touch .tflint.hcl && rm -f .tflint.hcl
	$(GO) run main.go -rules=gcp -rules-tag=$(TFLINT_GCP_TAG)

# Private
.PHONY: _gcp-copy-gen
_gcp-copy-gen:
	cp -fv _gcp.tflint.hcl.tmp ./.tflint.hcl

#-------------------------------------------------------------------------------
# Azure

.PHONY: azure
## azure: [build]* Generates an Azure-specific version of the config file to `.tflint.hcl`.
azure: _azure-announce _azure-gen-def _azure-fetch-sdk _azure-copy-gen

# Private
.PHONY: _azure-announce
_azure-announce:
	@ $(ECHO) " "
	@ $(ECHO) "=====> Generating Azure configuration..."

# Private
.PHONY: _azure-gen-def
_azure-gen-def:
	touch .tflint.hcl && rm -f .tflint.hcl
	$(GO) run main.go -rules=azure -rules-tag=$(TFLINT_AZURE_TAG)

# Private
.PHONY: _azure-fetch-sdk
_azure-fetch-sdk:
	mkdir -p /tmp/tflint-ruleset-azure
	rm -rf /tmp/tflint-ruleset-azure
	git clone --recurse-submodules --branch v$(TFLINT_AZURE_TAG) --single-branch https://github.com/terraform-linters/tflint-ruleset-azurerm.git /tmp/tflint-ruleset-azure

# Private
.PHONY: _azure-copy-gen
_azure-copy-gen:
	cp -fv _azure.tflint.hcl.tmp /tmp/tflint-ruleset-azure/tools/apispec-rule-gen/doc_README.md.tmpl
	cd /tmp/tflint-ruleset-azure/tools/ && go run ./apispec-rule-gen
	cp -fv /tmp/tflint-ruleset-azure/docs/README.md ./.tflint.hcl

#-------------------------------------------------------------------------------
# Dist

.PHONY: dist
## dist: [build]* Generates all flavors of `.tflint.hcl` into the dist/ directory.
dist: _dist-prep _dist-base _dist-aws _dist-gcp _dist-azure clean-files

.PHONY: _dist-prep
_dist-prep:
	mkdir -p ./dist && rm -Rf ./dist/*.hcl || return

.PHONY: _dist-base
_dist-base: base
	cp -vf .tflint.hcl dist/base.tflint.hcl

.PHONY: _dist-aws
_dist-aws: aws
	cp -vf .tflint.hcl dist/aws.tflint.hcl

.PHONY: _dist-gcp
_dist-gcp: gcp
	cp -vf .tflint.hcl dist/gcp.tflint.hcl

.PHONY: _dist-azure
_dist-azure: azure
	cp -vf .tflint.hcl dist/azure.tflint.hcl
