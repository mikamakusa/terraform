resource "azurerm_key_vault" "az_keyvault" {
  count                       = "${length(var.keyvault)}"
  name                        = "${var.prefix}-${lookup(var.keyvault[count.index],"name")}"
  location                    = "${var.location}"
  resource_group_name         = "${var.resource_group_name}"
  tenant_id                   = "${var.tenant_id}"
  enabled_for_disk_encryption = "${lookup(var.keyvault[count.index],"enabled_for_disk_encryption")}"

  "sku" {
    name = "${lookup(var.keyvault,"sku_name")}"
  }

  access_policy {
    object_id               = "${var.tenant_id}"
    tenant_id               = "${var.object_id}"
    certificate_permissions = ["${var.certificate_permissions}"]
    key_permissions         = ["${var.key_permissions}"]
    secret_permissions      = ["${var.secret_permissions}"]
    storage_permissions     = ["${var.storage_permissions}"]
  }
}

resource "azurerm_key_vault_certificate" "az_cert_import" {
  count        = "${ "${length(var.keyvault)}" == "0" ? "0" : "${length(var.cert_import)}" }"
  name         = "${var.prefix}-${lookup(var.cert_import[count.index],"name")}-cert"
  key_vault_id = "${element(azurerm_key_vault.az_keyvault.*.id,lookup(var.cert_import[count.index],"keyvault_id"))}"

  certificate {
    contents = "${filebase64(lookup(var.cert_import[count.index],"certificate_contents"))}"
    password = "${lookup(var.cert_import[count.index],"certificate_password")}"
  }

  "certificate_policy" {
    "issuer_parameters" {
      name = "${lookup(var.cert_import[count.index],"issuer_name")}"
    }

    "key_properties" {
      exportable = true
      key_size   = "${lookup(var.cert_import[count.index],"key_size")}"
      key_type   = "RSA"
      reuse_key  = true
    }

    "secret_properties" {
      content_type = "${lookup(var.cert_import[count.index],"content_type")}"
    }
  }
}

resource "azurerm_key_vault_certificate" "az_cert_gen" {
  count        = "${ "${length(var.keyvault)}" == "0" ? "0" : "${length(var.cert_import)}" }"
  name         = "${var.prefix}-${lookup(var.cert_gen[count.index],"name")}-cert"
  key_vault_id = "${element(azurerm_key_vault.az_keyvault.*.id,lookup(var.cert_gen[count.index],"keyvault_id"))}"

  "certificate_policy" {
    "issuer_parameters" {
      name = "${lookup(var.cert_import[count.index],"issuer_name")}"
    }

    "key_properties" {
      exportable = true
      key_size   = 0
      key_type   = "RSA"
      reuse_key  = true
    }

    lifetime_action {
      "action" {
        action_type = "${lookup(var.cert_gen[count.index],"action_type")}"
      }

      "trigger" {
        days_before_expiry = "${lookup(var.cert_gen[count.index],"days_before_expiry")}"
      }
    }

    "secret_properties" {
      content_type = "${lookup(var.cert_gen[count.index],"content_type")}"
    }

    x509_certificate_properties {
      key_usage = [
        "cRLSign",
        "dataEncipherment",
        "digitalSignature",
        "keyAgreement",
        "keyCertSign",
        "keyEncipherment",
      ]

      subject            = "${lookup(var.cert_gen[count.index],"subject")}"
      validity_in_months = "${lookup(var.cert_gen[count.index],"validity_in_months")}"
    }
  }
}

resource "azurerm_key_vault_key" "az_key" {
  count        = "${ "${length(var.keyvault)}" == "0" ? "0" : "${length(var.az_key)}" }"
  name         = "${var.prefix}-${lookup(var.az_key[count.index],"name")}-sshkey"
  key_vault_id = "${element(azurerm_key_vault.az_keyvault.*.id,lookup(var.az_key[count.index],"keyvault_id"))}"

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]

  key_size = "${lookup(var.az_key[count.index],"key_size")}"
  key_type = "${lookup(var.az_key[count.index],"key_type")}"
}

resource "azurerm_key_vault_secret" "az_secret" {
  count        = "${ "${length(var.keyvault)}" == "0" ? "0" : "${length(var.secret)}" }"
  name         = "${var.prefix}-${lookup(var.secret[count.index],"name")}-secret"
  value        = "${lookup(var.secret[count.index],"value")}"
  key_vault_id = "${element(azurerm_key_vault.az_keyvault.*.id,lookup(var.secret[count.index],"keyvault_id"))}"
}
