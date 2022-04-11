# TFLint Config Generator

Tools for generating an up-to-date `.tflint.hcl` configuration file for use with [`tflint`](https://github.com/terraform-linters/tflint).

The configuration options change often enough to annoy me, so here is some automation for generating it.

## Requirements

* macOS/Linux/WSL
* make
* Git
* Go
* Familiarity with Go templates (for making changes)

## Usage

There are 4 supported modes:

* Amazon Web Services (AWS)
* Google Cloud Platform (GCP)
* Microsoft Azure (Azure)
* "base" (e.g., New Relic, PagerDuty, Cloudflare, Artifactory)

### Base version

This is the version that has the good rules for standard Terraform, but is not tied to any particular cloud provider. This is useful when using one of the _other_ 2,000 providers that aren't AWS, GCP, or Azure.

```bash
make base
```

This will output a file called `.tflint.hcl` which can be copied into your project and used with `tflint`.

### Cloud versions

This is the version that has everything that _base_ has, with the addition of all of the cloud-specific rules enabled.

> **NOTE:** There is not yet any way to override individual values as `enabled = false`. Open an issue if you want this and are willing to help.

```bash
make aws
make gcp
make azure
```

This will output a file called `.tflint.hcl` which can be copied into your project and used with `tflint`.

This whole approach works by fetching the `terraform-linters/tflint-ruleset-*` repository and leveraging its existing code generation in a different way. By default, this uses the latest version of that ruleset I've personally tested. But if there is a newer/older version you want to use instead, you can pass the intended Git tag for the repository.

```bash
make aws TFLINT_AWS_TAG=0.13.2
make gcp TFLINT_GCP_TAG=0.16.1
make azure TFLINT_AZURE_TAG=0.15.0
```

You can find Git tag values at:

* <https://github.com/terraform-linters/tflint-ruleset-aws/tags>
* <https://github.com/terraform-linters/tflint-ruleset-google/tags>
* <https://github.com/terraform-linters/tflint-ruleset-azurerm/tags>

## How does it work?

### Base

1. Generate the "Base" `.tflint.hcl` file from the `_base.tmpl.hcl` template.

### Cloud

1. Read `_base.tmpl.hcl`.
1. Apply cloud-specific overlay (e.g., `_aws.tmpl.hcl`) to generate a _new_ template that will be passed to the _ruleset_ repo for further code generation.
1. Clones the `tflint-ruleset-*` repo to your `/tmp` directory.
1. Resolves the Git submodules.
1. There is a file that is used as a template for generating a [README](https://github.com/terraform-linters/tflint-ruleset-aws/blob/master/docs/rules/README.md) with a list of all of the options. We replace that template with our own (see step 2).
1. We run the generation step that's already part of the the upstream build process.
1. We take the output file, and replace our `.tflint.hcl` file with it.
