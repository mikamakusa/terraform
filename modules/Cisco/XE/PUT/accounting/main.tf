resource "iosxe_rest" "aaa_accounting" {
  method = "PUT"
  path   = "/data/Cisco-IOS-XE-native:native/aaa/accounting"
  payload = jsonencode(
    {
      "Cisco-IOS-XE-aaa:accounting": {
        "network": [
          {
            "id": "default-put"
          },
          {
            "id": "network2",
            "start-stop": {
              "group-config": {
                "group1": {
                  "group": "radius"
                },
                "group2": {
                  "group": "tacacs+"
                }
              }
            }
          }
        ],
        "system": {
          "guarantee-first": false
        }
      }
    }
  )
}