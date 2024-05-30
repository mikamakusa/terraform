data "nomad_plugin" "this" {
  count            = var.nomad_plugin ? 1 : 0
  plugin_id        = var.nomad_plugin
  wait_for_healthy = true
}