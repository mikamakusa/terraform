module "sentinel" {
  source = "../../modules/Azure/Sentinel"
  resource_group = [
    {
      id       = 0
      location = ""
      name     = ""
    }
  ]
  log_analytics_workspace = [
    {
      id                         = 0
      resource_group_id          = 0
      name                       = "log-workspace-1"
      internet_ingestion_enabled = true
      internet_query_enabled     = true
    }
  ]
  log_analytics_solution = [
    {
      id                = 0
      resource_group_id = 0
      workspace_id      = 0
    }
  ]
  sentinel_onboarding = [
    {
      id                           = 0
      name                         = "sentinel-onboarding-1"
      customer_managed_key_enabled = true
      resource_group_id            = 0
      workspace_id                 = 0
    }
  ]
}