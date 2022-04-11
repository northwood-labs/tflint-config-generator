{{/*
  DEFINE THE PLUGIN BLOCK.
*/}}
{{ define "plugin" }}

plugin "azurerm" {
  enabled    = true
  deep_check = true
  version    = "{{ .tag }}"
  source     = "github.com/terraform-linters/tflint-ruleset-azurerm"
}{{ end }}

{{/*
  DEFINE THE PLUGIN RULES.
*/}}
{{ define "plugin_rules" }}
#-------------------------------------------------------------------------------
# Basic Rules
# https://github.com/terraform-linters/tflint-ruleset-azurerm/blob/master/docs/README.md

rule "azurerm_linux_virtual_machine_invalid_size" {
  enabled = true
}

rule "azurerm_linux_virtual_machine_scale_set_invalid_sku" {
  enabled = true
}

rule "azurerm_virtual_machine_invalid_vm_size" {
  enabled = true
}

rule "azurerm_windows_virtual_machine_invalid_size" {
  enabled = true
}

rule "azurerm_windows_virtual_machine_scale_set_invalid_sku" {
  enabled = true
}

#-------------------------------------------------------------------------------
# API Specification Rules
# https://github.com/terraform-linters/tflint-ruleset-azurerm/blob/master/docs/README.md

{{ "{{" }} range $v := .RuleNameList -{{ "}}" }}
rule "{{ "{{" }} $v {{ "}}" }}" {
  enabled = true
}

{{ "{{" }} end -{{ "}}" }}
{{- end }}
