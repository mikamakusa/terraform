resource "azurerm_lb" "azure_lb" {
  count               = "${length(var.lb)}"
  name                = "${lookup(var.lb[count.index],"name")}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  sku                 = "${lookup(var.lb[count.index],"sku")}"

  frontend_ip_configuration {
    name                          = "${var.prefix}-${lookup(var.lb[count.index],"name")}-nic"
    subnet_id                     = "${element(var.subnet_id,lookup(var.lb[count.index],"subnet_id"))}"
    private_ip_address            = "static"
    private_ip_address_allocation = "${lookup(var.lb[count.index],"static_ip")}"
  }
}

resource "azurerm_lb_backend_address_pool" "lb_backend" {
  count               = "${length(var.lb)}"
  loadbalancer_id     = "${element(azurerm_lb.azure_lb.*.id,"count.index")}"
  name                = "${var.prefix}-${lookup(var.lb[count.index],"name")}-bzckend"
  resource_group_name = "${var.resource_group_name}"
}

resource "azurerm_lb_probe" "lb_probe" {
  count               = "${length(var.lb_rules)}"
  resource_group_name = "${var.resource_group_name}"
  loadbalancer_id     = "${element(azurerm_lb.azure_lb.*.id,lookup(var.lb_rules[count.index], "Id_Lb"))}"
  name                = "${var.prefix}${lookup(var.lb_rules[count.index], "suffix_name")}-probe${lookup(var.lb_rules[count.index], "Id")}"
  port                = "${lookup(var.lb_rules[count.index], "lb_port")}"
  protocol            = "${lookup(var.lb_rules[count.index], "probe_protocol")}"
  request_path        = "${"${lookup(var.lb_rules[count.index], "probe_protocol")}" == "Tcp" ? "" : "${lookup(var.lb_rules[count.index], "request_path")}"}"
}

resource "azurerm_lb_rule" "lb_rule" {
  count                          = "${length(var.lb_rules)}"
  resource_group_name            = "${var.resource_group_name}"
  loadbalancer_id                = "${element(azurerm_lb.azure_lb.*.id,lookup(var.lb_rules[count.index], "Id_Lb"))}"
  name                           = "${var.prefix}${lookup(var.lb_rules[count.index], "suffix_name")}-rule${lookup(var.lb_rules[count.index], "Id")}"
  protocol                       = "Tcp"
  frontend_port                  = "${lookup(var.lb_rules[count.index], "lb_port")}"
  backend_port                   = "${lookup(var.lb_rules[count.index], "lb_port")}"
  frontend_ip_configuration_name = "${var.prefix}${lookup(var.lb_rules[count.index], "suffix_name")}-nic1-LBCFG"
  backend_address_pool_id        = "${element(azurerm_lb_backend_address_pool.lb_backend.*.id,lookup(var.lb_rules[count.index], "Id_Lb"))}"
  probe_id                       = "${element(azurerm_lb_probe.lb_probe.*.id,count.index)}"
  load_distribution              = "Default"
  idle_timeout_in_minutes        = 4
}