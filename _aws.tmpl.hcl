{{/*
  DEFINE THE PLUGIN BLOCK.
*/}}
{{ define "plugin" }}

plugin "aws" {
  enabled    = true
  deep_check = true
  version    = "{{ .tag }}"
  source     = "github.com/terraform-linters/tflint-ruleset-aws"
}{{ end }}

{{/*
  DEFINE THE PLUGIN RULES.
*/}}
{{ define "plugin_rules" }}
#-------------------------------------------------------------------------------
# Possible Errors
# https://github.com/terraform-linters/tflint-ruleset-aws/blob/master/docs/rules/README.md

rule "aws_alb_invalid_security_group" {
  enabled = true
}

rule "aws_alb_invalid_subnet" {
  enabled = true
}

rule "aws_api_gateway_model_invalid_name" {
  enabled = true
}

rule "aws_db_instance_invalid_db_subnet_group" {
  enabled = true
}

rule "aws_db_instance_invalid_engine" {
  enabled = true
}

rule "aws_db_instance_invalid_option_group" {
  enabled = true
}

rule "aws_db_instance_invalid_parameter_group" {
  enabled = true
}

rule "aws_db_instance_invalid_type" {
  enabled = true
}

rule "aws_db_instance_invalid_vpc_security_group" {
  enabled = true
}

rule "aws_elasticache_cluster_invalid_parameter_group" {
  enabled = true
}

rule "aws_elasticache_cluster_invalid_security_group" {
  enabled = true
}

rule "aws_elasticache_cluster_invalid_subnet_group" {
  enabled = true
}

rule "aws_elasticache_cluster_invalid_type" {
  enabled = true
}

rule "aws_elasticache_replication_group_invalid_type" {
  enabled = true
}

rule "aws_elb_invalid_instance" {
  enabled = true
}

rule "aws_elb_invalid_security_group" {
  enabled = true
}

rule "aws_elb_invalid_subnet" {
  enabled = true
}

rule "aws_instance_invalid_ami" {
  enabled = true
}

rule "aws_instance_invalid_iam_profile" {
  enabled = true
}

rule "aws_instance_invalid_key_name" {
  enabled = true
}

rule "aws_instance_invalid_subnet" {
  enabled = true
}

rule "aws_instance_invalid_vpc_security_group" {
  enabled = true
}

rule "aws_launch_configuration_invalid_iam_profile" {
  enabled = true
}

rule "aws_launch_configuration_invalid_image_id" {
  enabled = true
}

rule "aws_route_invalid_egress_only_gateway" {
  enabled = true
}

rule "aws_route_invalid_gateway" {
  enabled = true
}

rule "aws_route_invalid_instance" {
  enabled = true
}

rule "aws_route_invalid_nat_gateway" {
  enabled = true
}

rule "aws_route_invalid_network_interface" {
  enabled = true
}

rule "aws_route_invalid_route_table" {
  enabled = true
}

rule "aws_route_invalid_vpc_peering_connection" {
  enabled = true
}

rule "aws_route_not_specified_target" {
  enabled = true
}

rule "aws_route_specified_multiple_targets" {
  enabled = true
}

#-------------------------------------------------------------------------------
# Best Practices/Naming Conventions
# https://github.com/terraform-linters/tflint-ruleset-aws/blob/master/docs/rules/README.md

rule "aws_db_instance_previous_type" {
  enabled = true
}

rule "aws_db_instance_default_parameter_group" {
  enabled = true
}

rule "aws_elasticache_cluster_previous_type" {
  enabled = true
}

rule "aws_elasticache_cluster_default_parameter_group" {
  enabled = true
}

rule "aws_elasticache_replication_group_previous_type" {
  enabled = true
}

rule "aws_elasticache_replication_group_default_parameter_group" {
  enabled = true
}

rule "aws_instance_previous_type" {
  enabled = true
}

rule "aws_iam_policy_document_gov_friendly_arns" {
  enabled = false
}

rule "aws_iam_policy_gov_friendly_arns" {
  enabled = false
}

rule "aws_iam_role_policy_gov_friendly_arns" {
  enabled = false
}

rule "aws_resource_missing_tags" {
  enabled = false
}

rule "aws_s3_bucket_name" {
  enabled = true
}

#-------------------------------------------------------------------------------
# SDK-based Validations
# https://github.com/terraform-linters/tflint-ruleset-aws/blob/master/docs/rules/README.md

{{ "{{" }} range $v := .RuleNames -{{ "}}" }}
rule "{{ "{{" }} $v {{ "}}" }}" {
  enabled = true
}

{{ "{{" }} end -{{ "}}" }}
{{- end }}
