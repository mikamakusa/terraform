To use openstack modules : 

**main.tf**
```hcl
## Openstack Provider
provider "openstack" {
  auth_url    = "${var.os_auth_url}"
  tenant_name = "${var.tenant_id}"
  user_name   = "${var.user}"
  password    = "${var.pass}"
  region      = "${var.region_name}"
}

terraform {
  backend "local" {
    path = "backend.tfstate"
  }
}

## Network
module "openstack_network" {
  source  = "../../modules/Create_Network"
  subnet  = "${var.subnet}"
  network = "${var.network}"
  router  = "${var.router}"
}

## Security
module "openstack_security" {
  source         = "../../modules/Create_Security_Groups"
  sec_group_rule = "${var.sec_group_rule}"
  sec_group      = "${var.sec_group}"
}

## Storage
module "openstack_storage" {
  source            = "../../modules/Create_BlockStorage"
  os_blockstor      = "${var.os_blockstor}"
}

## Instances
module "openstack_servers" {
  source            = "../../modules/Create_Instance_Basic"
  network           = "${var.network}"
  os_instance       = "${var.os_instance}"
  os_keypair        = "${var.key_pair}"
  default_sec_group = "${var.default_sec_group}"
  float_ip          = "${var.float_ip}"
}
```

**vars.tf**  
```hcl
variable "os_instance" {
  type = "list"
}

variable "metadata" {
  type = "map"

  default = {}
}

variable "key_pair" {
  type = "list"
}

variable "float_ip" {
  type = "list"
}

variable "sec_group" {
  type = "list"
}

variable "sec_group_rule" {
  type = "list"
}

variable "network" {
  type = "list"
}

variable "subnet" {
  type = "list"
}

variable "router" {
  type = "list"
}

variable "os_blockstor" {
  type = "list"
}

variable "os_auth_url" {}
variable "tenant_id" {}
variable "user" {}
variable "pass" {}
variable "region_name" {}

variable "pool_ip" {
  default = "admin_ciofip_net"
}

variable "default_sec_group" {}
```

**vars.tfvars** (for example)  
```hcl
### Infra ###
network = [
  {
    network_id     = "0"
    name           = "dacec_net_dev"
    admin_state_up = "true"
    region         = ""
  },
]

subnet = [
  {
    subnet_id  = "0"
    cidr       = "10.10.0.0/24"
    id_network = "0"
    ip_version = "4"
    region     = ""
    name       = "dacec_sub_dev"
  },
]

router = [
  {
    router_id           = "0"
    name                = "dacec_rt_dev"
    admin_state_up      = "true"
    region              = ""
    external_network_id = "84e6527f-422a-4708-b94b-f38b0c34a711"
  },
]

### Servers / SSH Keys ###
key_pair = [
  {
    key_pair_id = "0"
    name        = "bastion"
    key_file    = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDjYRfHeqvW3v7CTVgC+euBFPPXLt6PBBhptiytIBi8UhY8qRrrE/42MPyi6jZpcnr0pDCEyEg0jjVrCAcsWbR27qJ8TY3heGBDngez6jet+oogwkCfeKyUXeeBHsWBqoAS/7jcvS2N5FiRO5dqATAOw5znMtB3xDM3fAc99SH4q9y0slhd11pYVAXE9hzrdxpX5VAfhZHxED/TSdoW9NHPxaQkk66NL3jMn29N3M3ZUEN31qcM6QwKZ9Hlepob5rPU6eWe7GVVySbxYsweUaPnm4bjCTKqxEY7lfVwFAXetAoeYkbMA7uCpbe1ZFaNgPQwXJQ2Osta9LOQWKCEY8mo4wpOI/kcGyXJbW/gfBG4zrrUY4nmaBNRMWte672f64tAX4xU4rwqs8JtmLRi7zrmTi0MXT0ZVaBuyjy6bIa4UbvcWwv5CkNA+nrB6sp3L3cHGNTb8xYrijxVSNREuRJHU7tVDB7pQMFWb/P0LmSNE+iAuzaB74gdXclBfT7WdnWQE8EGupjmn5fvZv4u+527L2VSoc2VxcDFGIkkZu7+SZ2mOWu8HFWHjQdip0V3hZRAHpcU5sZ5AkXxy65MHj/vCOjOnu+/ifAZUg4lKvHSrgAJiqWKlJ3sGJwVBIpumFRirbOXY0X0MXJ7ScQeq1nM3oyBTDm5BYxo6vWikLVvaQ== root@mylinux"
  },
  {
    key_pair_id = "1"
    name        = "front"
    key_file    = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDCBRiOWavLIiLIcweMFff3V4r5/2H5nufOXJ6+Dn/ioPp4VSvIniYbbUP3ZJ4yP5HXqDfXG6Y/tywB5A7lE6frASJ+E5PRNcHuFleHHqfPz5iXIwLznxECK56W0a+HM/P3vhrj2DrEdsbJ9PGbC6RfcmD6w/elM5X9bUDWOp5uXYa8ufyDL19PStTs5Ccifn/68/V3UE4jCqUSzica/vxnTX5YlbxVYgHSWZT32rv9fbAU8x5S7mDYmv93nRTkBFEnpepDiz5vPtnAcJTZUn+akd5z/VIWqAg0biois+E9otkZ1m4MCRN+wnQjWVroVUwxCEDxPMGQmzEEy1KBs5Z/IM0tcnLUV+khcaEqhfWv0EBwL4T1akl0g88F6IpY+GUxYmjSLXDaZvKDTBC7O69JNFYloiyZxfEm5Hrm9x8gefjIaId5kUSvrc5sS3FCj3u27q1tn+p6yveURtxjT2xw6r/InDZdjBq0XHRMjvNPZ6IOkoZ/2plXllQXUJUo9poZzXtN2gAqKmooNuCR/JsHjvUJ+rOXUqMyp7PpOPq4nDvRC8ihiPTnt9NteiwmOc2VZjJSfImubgpyqlMcpgrxsr5FfIP/jhL5no90wTgg/xyX5TyIP4WvvHx5jmZZlIHrXJa9fKgOt7JKgevDoSK3q5S0NImy+7uDr5qYLskaBQ== root@mylinux"
  },
  {
    key_pair_id = "2"
    name        = "postgre"
    key_file    = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDDhp4qemrkYECLEgwYqqRFzDOoNwOA0EFs3YbsnUZ+boz4jK0i+GMGf7Z/a1Lz4BnToQ6pYzNIOWciOQn2lUsgwMQ4nOwFWoyM9kCXg+/Ii64sXXa4xo7yPkegsUmT6b6jAXMTMb6sB+mXl2eego4o1YfGmiv6snFSwz1r7NWSxzKp+1lyEVcgdlZ2Tm6vOPe4kiASAOYnmL9fcJrdRMwoKu8lYcOdkBgI8qE6isXpN2v2XoFS8uG/bQ3ExoyQu4Rqd0VXhRwb9l2w1K3mmzkmmnaA4aJ+IZxfx2svjuGqOwRAC/orTfQ8GbuwpA0nMy+XF7MeUgZ4JLYyz99Xh4ARAY9obpM9BT2RuismekJmoPchohZHRoE/ncAWr26xQogM1Z4v9csoLRryv1StoAOJF2fw/1CRKDzF0o0L2WDutVLD24IW9+coFmOBiThRaO483TT2ceB8UDnGlG+QQKNan5adXgXL5SMTHcv/xgLlzfJ+mHP+UsXi/Ea7WayW6nqO7olxe8khxKx7HCjzQG+Q4lUWZVrwMILxJXr7AQeRV85FTGy7uQLa3IDgUH+DrWxeJCJU6FvEeQRMc5p3e0DNHnUhFYId6riAMTHfB54nay5QHeEneRt+86pRDAbAaDOHUH9BCcEg2it83/7FL4kG7pJFCkNJgFOibQ7AW9Lk9Q== root@mylinux"
  },
]

os_instance = [
  {
    id_instance  = "0"
    name         = "bastion"
    image_name   = "centos-7-x86_64"
    flavor_name  = "m2.2small"
    network_name = "dev_dacechange_network"
    key_pair_id  = "0"
    sec_group_id = "0"
    fixed_ip_v4  = "10.10.0.50"
  },
  {
    id_instance  = "1"
    name         = "front"
    image_name   = "centos-7-x86_64"
    flavor_name  = "m2.8medium"
    network_name = "dev_dacechange_network"
    key_pair_id  = "1"
    sec_group_id = "1"
    fixed_ip_v4  = "10.10.0.60"
  },
  {
    id_instance  = "2"
    name         = "postgre"
    image_name   = "centos-7-x86_64"
    flavor_name  = "m2.2small"
    network_name = "dev_dacechange_network"
    key_pair_id  = "2"
    sec_group_id = "2"
    fixed_ip_v4  = "10.10.0.70"
  },
]

float_ip = [
  {
    float_ip_id = "0"
    region      = ""
    pool        = "admin_ciofip_net"
    id_instance = "0"
    floating_ip = "100.72.65.24"
  },
  {
    float_ip_id = "1"
    region      = ""
    pool        = "admin_ciofip_net"
    id_instance = "1"
    floating_ip = "100.72.64.232"
  },
]

### Storage
os_blockstor = [
  {
    blockstor_id   = "0"
    name           = "front_blockstor"
    size           = "10"
    instance_name  = "front"
  },
  {
    blockstor_id   = "0"
    name           = "postgre_blockstor"
    size           = "10"
    instance_name  = "postgre"
  },  
]

### Security ###
default_sec_group = "6a9a7ae2-c67f-4a26-99e2-fb6dca70dbf3"

sec_group = [
  {
    sec_group_id = "0"
    name         = "bastion"
    description  = "Bastion Security rules"
    region       = ""
  },
  {
    sec_group_id = "1"
    name         = "front"
    description  = "Front security rules"
    region       = ""
  },
  {
    sec_group_id = "2"
    name         = "postgre"
    description  = "PostgreSQL security rules"
    region       = ""
  },
]

sec_group_rule = [
  {
    sec_group_rule_id = "0"
    sec_group_id      = "0"
    direction         = "ingress"
    ethertype         = "IPv4"
    protocol          = "tcp"
    port_range_min    = "22"
    port_range_max    = "22"
    remote_ip_prefix  = "0.0.0.0/0"
    region            = ""
  },
  {
    sec_group_rule_id = "1"
    sec_group_id      = "1"
    direction         = "ingress"
    ethertype         = "IPv4"
    protocol          = "tcp"
    port_range_min    = "22"
    port_range_max    = "22"
    remote_ip_prefix  = "0.0.0.0/0"
    region            = ""
  },
  {
    sec_group_rule_id = "2"
    sec_group_id      = "1"
    direction         = "ingress"
    ethertype         = "IPv4"
    protocol          = "tcp"
    port_range_min    = "80"
    port_range_max    = "80"
    remote_ip_prefix  = "0.0.0.0/0"
    region            = ""
  },
  {
    sec_group_rule_id = "3"
    sec_group_id      = "1"
    direction         = "ingress"
    ethertype         = "IPv4"
    protocol          = "tcp"
    port_range_min    = "443"
    port_range_max    = "443"
    remote_ip_prefix  = "0.0.0.0/0"
    region            = ""
  },
  {
    sec_group_rule_id = "4"
    sec_group_id      = "1"
    direction         = "ingress"
    ethertype         = "IPv4"
    protocol          = "tcp"
    port_range_min    = "389"
    port_range_max    = "389"
    remote_ip_prefix  = "0.0.0.0/0"
    region            = ""
  },
  {
    sec_group_rule_id = "5"
    sec_group_id      = "2"
    direction         = "ingress"
    ethertype         = "IPv4"
    protocol          = "tcp"
    port_range_min    = "22"
    port_range_max    = "22"
    remote_ip_prefix  = "0.0.0.0/0"
    region            = ""
  },
]

```