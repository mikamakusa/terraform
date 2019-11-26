data "template_file" "elasticsearchPolicy" {
  template = file(join(".", [join("/", [path.cwd, "policy", "es-policy"]), "json"]))

  vars = {
    region      = var.region
    account     = base64decode(var.account)
    domain_name = var.domain_name
  }
}