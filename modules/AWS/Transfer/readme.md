# How to use this module ?

## The resource
```hcl-terraform
module "transfer-server" {
  source = "Transfer"
  transfer_server = ""
  vpc_endpoint-id = ""
}
```

## The variables
```hcl-terraform
variable "transfer_server" {
  type = "list"
}

variable "vpc_endpoint_id" {}
```

## The variable file
```hcl-terraform
transfer_server = [
  {
    endpoint_type = "PUBLIC"
    vpc_endpoint_type = []
  }
]
```