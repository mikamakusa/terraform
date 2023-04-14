/*
provider "iosxe" {
  device_password = "Admcal2023!"
  device_username = "admcal"
  host            = "https://192.168.1.1"
  insecure        = true
}

terraform {
  required_providers {
    iosxe = {
      source  = "CiscoDevNet/iosxe"
      version = "0.1.1"
    }
  }
}

resource "iosxe_rest" "vlan_example_post" {
  method = "POST"
  path   = "/data/Cisco-IOS-XE-native:native/vlan"
  payload = jsonencode(
    {
      "Cisco-IOS-XE-vlan:vlan-list" : {
        "id" : "52",
        "name" : "VLAN52"
      }
    }
  )
}*/

terraform {
  required_providers {
    iosxe = {
      source  = "terraform.local/local/iosxe"
      version = "0.1.15"
    }
  }
}

/*terraform {
  required_providers {
    iosxe = {
      source  = "CiscoDevNet/iosxe"
      version = "0.1.1"
    }
  }
}*/

/*provider "iosxe" {
  device_password = "Azerty123!"
  device_username = "admkal"
  host            = "https://192.168.1.1"
  insecure        = true
}*/

provider "iosxe" {
  username = "admkal"
  password = "Azerty123!"
  url      = "https://192.168.1.1"
  insecure = true
}

/*module "vrf" {
  source = "../../modules/Cisco/IOSXE/VRF"
  vrf = {
    VRF-1 = {}
  }
}*/

module "switching" {
  source = "../../modules/Cisco/IOSXE/Switching"
  vlan = {
    vlan-105 = {
      vlan_id = 105
    },
    vlan-106 = {
      vlan_id = 106
    }
  }
}

module "management" {
  source = "../../modules/Cisco/IOSXE/Management"
  logging = [
    {
      monitor_severity  = "informational"
      buffered_size     = 16000
      buffered_severity = "informational"
      console_severity  = "informational"
      facility          = "local0"
      history_size      = 100
      history_severity  = "informational"
      trap              = true
      trap_severity     = "informational"
    }
  ]
  ipv4_logging = [
    {
      ipv4_host = "2.2.2.2"
    }
  ]
  group = {
    grp1 = {
      v3_security = [
        {
          security_level  = "priv"
          context_node    = "CON1"
          match_node      = "exact"
          read_node       = "VIEW1"
          write_node      = "VIEW2"
          notify_node     = "VIEW3"
        }
      ]
    }
  }
  user = {
    user1 = {
      grpname           = "grp1"
      v3_auth_algorithm = "md5"
      v3_auth_password  = "Azerty123!"
    }
  }
}