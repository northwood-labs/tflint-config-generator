{{/*
  DEFINE THE PLUGIN BLOCK.
*/}}
{{ define "plugin" }}

plugin "aws" {
  enabled    = true
  deep_check = true
  version    = "{{ .tag }}"
  source     = "github.com/terraform-linters/tflint-ruleset-google"
}{{ end }}

{{/*
  DEFINE THE PLUGIN RULES.
*/}}
{{ define "plugin_rules" }}
#-------------------------------------------------------------------------------
# Possible Errors
# https://github.com/terraform-linters/tflint-ruleset-google/blob/master/docs/rules/README.md

rule "google_composer_environment_invalid_machine_type" {
    enabled = true
}

rule "google_compute_instance_invalid_machine_type" {
    enabled = true
}

rule "google_compute_instance_template_invalid_machine_type" {
    enabled = true
}

rule "google_compute_reservation_invalid_machine_type" {
    enabled = true
}

rule "google_container_cluster_invalid_machine_type" {
    enabled = true
}

rule "google_container_node_pool_invalid_machine_type" {
    enabled = true
}

rule "google_dataflow_job_invalid_machine_type" {
    enabled = true
}

rule "google_disabled_api" {
    enabled = true
}

rule "google_project_iam_audit_config_invalid_member" {
    enabled = true
}

rule "google_project_iam_binding_invalid_member" {
    enabled = true
}

rule "google_project_iam_member_invalid_member" {
    enabled = true
}

rule "google_project_iam_policy_invalid_member" {
    enabled = true
}

#-------------------------------------------------------------------------------
# Magic Modules Rules
# https://github.com/terraform-linters/tflint-ruleset-google/tree/master/rules/magicmodules
# Just copy-pasted the list of files from GitHub. (a) Sort unique, (b) lines begin with `google`, (c) multi-cursor type the rest.
# @TODO Look into switching to code generation like we do with AWS.

rule "google_access_context_manager_service_perimeter_invalid_perimeter_type" {
    enabled = true
}

rule "google_active_directory_domain_trust_invalid_trust_direction" {
    enabled = true
}

rule "google_active_directory_domain_trust_invalid_trust_type" {
    enabled = true
}

rule "google_apigee_organization_invalid_runtime_type" {
    enabled = true
}

rule "google_app_engine_domain_mapping_invalid_override_strategy" {
    enabled = true
}

rule "google_app_engine_firewall_rule_invalid_action" {
    enabled = true
}

rule "google_app_engine_flexible_app_version_invalid_serving_status" {
    enabled = true
}

rule "google_bigquery_routine_invalid_determinism_level" {
    enabled = true
}

rule "google_bigquery_routine_invalid_language" {
    enabled = true
}

rule "google_bigquery_routine_invalid_routine_type" {
    enabled = true
}

rule "google_binary_authorization_policy_invalid_global_policy_evaluation_mode" {
    enabled = true
}

rule "google_cloud_asset_folder_feed_invalid_content_type" {
    enabled = true
}

rule "google_cloud_asset_organization_feed_invalid_content_type" {
    enabled = true
}

rule "google_cloud_asset_project_feed_invalid_content_type" {
    enabled = true
}

rule "google_cloud_identity_group_invalid_initial_group_config" {
    enabled = true
}

rule "google_cloudiot_device_invalid_log_level" {
    enabled = true
}

rule "google_cloudiot_registry_invalid_log_level" {
    enabled = true
}

rule "google_compute_address_invalid_address_type" {
    enabled = true
}

rule "google_compute_address_invalid_name" {
    enabled = true
}

rule "google_compute_address_invalid_network_tier" {
    enabled = true
}

rule "google_compute_backend_bucket_invalid_name" {
    enabled = true
}

rule "google_compute_backend_bucket_signed_url_key_invalid_name" {
    enabled = true
}

rule "google_compute_backend_service_invalid_load_balancing_scheme" {
    enabled = true
}

rule "google_compute_backend_service_invalid_locality_lb_policy" {
    enabled = true
}

rule "google_compute_backend_service_invalid_protocol" {
    enabled = true
}

rule "google_compute_backend_service_invalid_session_affinity" {
    enabled = true
}

rule "google_compute_backend_service_signed_url_key_invalid_name" {
    enabled = true
}

rule "google_compute_external_vpn_gateway_invalid_redundancy_type" {
    enabled = true
}

rule "google_compute_firewall_invalid_direction" {
    enabled = true
}

rule "google_compute_forwarding_rule_invalid_ip_protocol" {
    enabled = true
}

rule "google_compute_forwarding_rule_invalid_load_balancing_scheme" {
    enabled = true
}

rule "google_compute_forwarding_rule_invalid_network_tier" {
    enabled = true
}

rule "google_compute_global_address_invalid_address_type" {
    enabled = true
}

rule "google_compute_global_address_invalid_ip_version" {
    enabled = true
}

rule "google_compute_global_forwarding_rule_invalid_ip_protocol" {
    enabled = true
}

rule "google_compute_global_forwarding_rule_invalid_ip_version" {
    enabled = true
}

rule "google_compute_global_forwarding_rule_invalid_load_balancing_scheme" {
    enabled = true
}

rule "google_compute_global_network_endpoint_group_invalid_network_endpoint_type" {
    enabled = true
}

rule "google_compute_interconnect_attachment_invalid_bandwidth" {
    enabled = true
}

rule "google_compute_interconnect_attachment_invalid_encryption" {
    enabled = true
}

rule "google_compute_interconnect_attachment_invalid_name" {
    enabled = true
}

rule "google_compute_interconnect_attachment_invalid_type" {
    enabled = true
}

rule "google_compute_managed_ssl_certificate_invalid_type" {
    enabled = true
}

rule "google_compute_network_endpoint_group_invalid_network_endpoint_type" {
    enabled = true
}

rule "google_compute_node_template_invalid_cpu_overcommit_type" {
    enabled = true
}

rule "google_compute_region_backend_service_invalid_load_balancing_scheme" {
    enabled = true
}

rule "google_compute_region_backend_service_invalid_locality_lb_policy" {
    enabled = true
}

rule "google_compute_region_backend_service_invalid_protocol" {
    enabled = true
}

rule "google_compute_region_backend_service_invalid_session_affinity" {
    enabled = true
}

rule "google_compute_region_network_endpoint_group_invalid_network_endpoint_type" {
    enabled = true
}

rule "google_compute_route_invalid_name" {
    enabled = true
}

rule "google_compute_router_nat_invalid_nat_ip_allocate_option" {
    enabled = true
}

rule "google_compute_router_nat_invalid_source_subnetwork_ip_ranges_to_nat" {
    enabled = true
}

rule "google_compute_router_peer_invalid_advertise_mode" {
    enabled = true
}

rule "google_compute_ssl_policy_invalid_min_tls_version" {
    enabled = true
}

rule "google_compute_ssl_policy_invalid_profile" {
    enabled = true
}

rule "google_compute_subnetwork_invalid_ipv6_access_type" {
    enabled = true
}

rule "google_compute_subnetwork_invalid_role" {
    enabled = true
}

rule "google_compute_subnetwork_invalid_stack_type" {
    enabled = true
}

rule "google_compute_target_https_proxy_invalid_quic_override" {
    enabled = true
}

rule "google_compute_target_instance_invalid_nat_policy" {
    enabled = true
}

rule "google_compute_target_ssl_proxy_invalid_proxy_header" {
    enabled = true
}

rule "google_compute_target_tcp_proxy_invalid_proxy_header" {
    enabled = true
}

rule "google_data_catalog_entry_group_invalid_entry_group_id" {
    enabled = true
}

rule "google_data_catalog_entry_invalid_type" {
    enabled = true
}

rule "google_data_catalog_entry_invalid_user_specified_system" {
    enabled = true
}

rule "google_data_catalog_entry_invalid_user_specified_type" {
    enabled = true
}

rule "google_data_catalog_tag_template_invalid_tag_template_id" {
    enabled = true
}

rule "google_data_fusion_instance_invalid_type" {
    enabled = true
}

rule "google_data_loss_prevention_job_trigger_invalid_status" {
    enabled = true
}

rule "google_datastore_index_invalid_ancestor" {
    enabled = true
}

rule "google_deployment_manager_deployment_invalid_create_policy" {
    enabled = true
}

rule "google_deployment_manager_deployment_invalid_delete_policy" {
    enabled = true
}

rule "google_dialogflow_agent_invalid_api_version" {
    enabled = true
}

rule "google_dialogflow_agent_invalid_match_mode" {
    enabled = true
}

rule "google_dialogflow_agent_invalid_tier" {
    enabled = true
}

rule "google_dialogflow_cx_entity_type_invalid_auto_expansion_mode" {
    enabled = true
}

rule "google_dialogflow_cx_entity_type_invalid_kind" {
    enabled = true
}

rule "google_dialogflow_entity_type_invalid_kind" {
    enabled = true
}

rule "google_dialogflow_intent_invalid_webhook_state" {
    enabled = true
}

rule "google_dns_managed_zone_invalid_visibility" {
    enabled = true
}

rule "google_firestore_index_invalid_query_scope" {
    enabled = true
}

rule "google_healthcare_fhir_store_invalid_version" {
    enabled = true
}

rule "google_kms_crypto_key_invalid_purpose" {
    enabled = true
}

rule "google_kms_key_ring_import_job_invalid_import_method" {
    enabled = true
}

rule "google_kms_key_ring_import_job_invalid_protection_level" {
    enabled = true
}

rule "google_memcache_instance_invalid_memcache_version" {
    enabled = true
}

rule "google_monitoring_alert_policy_invalid_combiner" {
    enabled = true
}

rule "google_monitoring_custom_service_invalid_service_id" {
    enabled = true
}

rule "google_monitoring_metric_descriptor_invalid_launch_stage" {
    enabled = true
}

rule "google_monitoring_metric_descriptor_invalid_metric_kind" {
    enabled = true
}

rule "google_monitoring_metric_descriptor_invalid_value_type" {
    enabled = true
}

rule "google_monitoring_slo_invalid_calendar_period" {
    enabled = true
}

rule "google_monitoring_slo_invalid_slo_id" {
    enabled = true
}

rule "google_network_services_edge_cache_origin_invalid_protocol" {
    enabled = true
}

rule "google_notebooks_instance_invalid_boot_disk_type" {
    enabled = true
}

rule "google_notebooks_instance_invalid_data_disk_type" {
    enabled = true
}

rule "google_notebooks_instance_invalid_disk_encryption" {
    enabled = true
}

rule "google_os_config_patch_deployment_invalid_patch_deployment_id" {
    enabled = true
}

rule "google_privateca_ca_pool_invalid_tier" {
    enabled = true
}

rule "google_privateca_certificate_authority_invalid_type" {
    enabled = true
}

rule "google_pubsub_schema_invalid_type" {
    enabled = true
}

rule "google_redis_instance_invalid_connect_mode" {
    enabled = true
}

rule "google_redis_instance_invalid_name" {
    enabled = true
}

rule "google_redis_instance_invalid_read_replicas_mode" {
    enabled = true
}

rule "google_redis_instance_invalid_tier" {
    enabled = true
}

rule "google_redis_instance_invalid_transit_encryption_mode" {
    enabled = true
}

rule "google_scc_source_invalid_display_name" {
    enabled = true
}

rule "google_spanner_database_invalid_name" {
    enabled = true
}

rule "google_spanner_instance_invalid_name" {
    enabled = true
}

rule "google_sql_source_representation_instance_invalid_database_version" {
    enabled = true
}

rule "google_storage_bucket_access_control_invalid_role" {
    enabled = true
}

rule "google_storage_default_object_access_control_invalid_role" {
    enabled = true
}

rule "google_storage_hmac_key_invalid_state" {
    enabled = true
}

rule "google_storage_object_access_control_invalid_role" {
    enabled = true
}
{{ end }}
