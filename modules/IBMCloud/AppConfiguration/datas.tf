data "ibm_app_config_environment" "this" {
  count          = var.environment_id ? 1 : 0
  environment_id = var.environment_id.environment
  guid           = var.environment_id.guid
}

data "ibm_app_config_collection" "this" {
  count         = var.collection_id ? 1 : 0
  collection_id = var.collection_id.collection
  guid          = var.collection_id.guid
}