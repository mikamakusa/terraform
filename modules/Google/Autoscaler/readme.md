# How to use it ?

In the main.tf file :  
```yaml
module "autoscale" {
  source                 = "../modules/Autoscaler"
  app_admin              = var.app_admin
  autoscaler             = var.autoscaler
  instance_group_manager = var.instance_group_manager
  network                = "projects/${var.project}/global/networks/${var.network_name}"
  pool                   = var.pool
  prefix                 = var.prefix
  project                = var.project
  region                 = var.region
  ssh_key                = var.ssh_keys
  subnetwork             = "projects/${var.project}/regions/europe-west1/subnetworks/${var.subnetwork_name}"
  target_pools           = var.pool
  template               = var.template
  zone                   = var.zone
}
```

in vars.tf :   
```yaml
variable "project" {}
variable "app_admin" {}
variable "ssh_keys" {}
variable "zone" {}
variable "network_name" {}
variable "subnetwork_name" {}
variable "autoscaler" {
 type = "list"
}

variable "template" {
 type = "list"
}

variable "instance_group_manager" {
 type = "list"
}

variable "pool" {
 type = "list"
}
```

in main.tfvars :
```yaml  
project = ""
app_admin = ""
ssh_keys = ""
zone = ""
subnetwork_name = ""
network_name = ""

template = [
  {
    id           = "0"
    machine_type = "n1-standard-2"
    source_image = "centos-cloud/centos-7"
    disk_size_gb = "100"
  },
]

pool = [
  {
    id   = "0"
    name = "workerha"

    instances = [
      "europe-west1-b/epope-workerha-0",
      "europe-west1-b/epope-workerha-1",
      "europe-west1-b/epope-workerha-2",
    ]
  },
  {
    id   = "1"
    name = "workernoha"

    instances = [
      "europe-west1-b/epope-workernoha-0",
      "europe-west1-b/epope-workernoha-1",
      "europe-west1-b/epope-workernoha-2",
    ]
  },
  {
    id   = "2"
    name = "controller"

    instances = [
      "europe-west1-b/epope-controller-0",
      "europe-west1-b/epope-controller-1",
    ]
  },
]

instance_group_manager = [
  {
    id                 = "0"
    name               = "workerha"
    base_instance_name = "workerha"
    template_id        = "0"
    pool_id            = "0"
  },
  {
    id                 = "0"
    name               = "workernoha"
    base_instance_name = "workernoha"
    template_id        = "0"
    pool_id            = "1"
  },
  {
    id                 = "0"
    name               = "controller"
    base_instance_name = "controller"
    template_id        = "0"
    pool_id            = "2"
  },
]

autoscaler = [
  {
    id              = "0"
    name            = "workerha"
    max_replicas    = "8"
    min_replicas    = "1"
    cooldown_period = "60"
    igm_id          = "0"
  },
  {
    id              = "1"
    name            = "workernoha"
    max_replicas    = "6"
    min_replicas    = "2"
    cooldown_period = "60"
    igm_id          = "1"
  },
  {
    id              = "2"
    name            = "controller"
    max_replicas    = "6"
    min_replicas    = "2"
    cooldown_period = "60"
    igm_id          = "2"
  },
]
```
