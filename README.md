# Terraform Subnet calculator

This terraform helps you to do some network and subnetwork calculations.

example:

```hcl
module "net_10_10" {
  source      = "github.com/cloudpilots/terraform-network-calculator"
  net         = "10.10.0.0/16"
  subnet_bits = 4
}
```

This renders mulitple useable and readable output, `net_description` is shown here:
```txt
network:            10.10.0.0/16
network cidr:       /16
netmask:            255.255.0.0
wildcard:           0.0.255.255
net addr:           10.10.0.0
broadcast addr:     10.10.255.255
address count:      65536
useable addresses:  65534

subnetworks: 16
    0: 10.10.0.0/20 255.255.240.0 10.10.0.0 - 10.10.15.255
    1: 10.10.16.0/20 255.255.240.0 10.10.16.0 - 10.10.31.255
    2: 10.10.32.0/20 255.255.240.0 10.10.32.0 - 10.10.47.255
    3: 10.10.48.0/20 255.255.240.0 10.10.48.0 - 10.10.63.255
    4: 10.10.64.0/20 255.255.240.0 10.10.64.0 - 10.10.79.255
    5: 10.10.80.0/20 255.255.240.0 10.10.80.0 - 10.10.95.255
    6: 10.10.96.0/20 255.255.240.0 10.10.96.0 - 10.10.111.255
    7: 10.10.112.0/20 255.255.240.0 10.10.112.0 - 10.10.127.255
    8: 10.10.128.0/20 255.255.240.0 10.10.128.0 - 10.10.143.255
    9: 10.10.144.0/20 255.255.240.0 10.10.144.0 - 10.10.159.255
    10: 10.10.160.0/20 255.255.240.0 10.10.160.0 - 10.10.175.255
    11: 10.10.176.0/20 255.255.240.0 10.10.176.0 - 10.10.191.255
    12: 10.10.192.0/20 255.255.240.0 10.10.192.0 - 10.10.207.255
    13: 10.10.208.0/20 255.255.240.0 10.10.208.0 - 10.10.223.255
    14: 10.10.224.0/20 255.255.240.0 10.10.224.0 - 10.10.239.255
    15: 10.10.240.0/20 255.255.240.0 10.10.240.0 - 10.10.255.255
```

## Requirements

No requirements.

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| net | Network in CIDR notation | `any` | n/a | yes |
| subnet\_bits | subnetwork bits | `number` | `0` | no |
| subnet\_prefix | subnet prefix | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| address\_count | amount of addresses in this network |
| broadcast\_addr | network broadcast address |
| host\_count | amount of useable addresses in this network |
| net | network |
| net\_address | netork address |
| net\_description | string describing the network for better readabiltity |
| netmask | network mask |
| network\_cidr | network cidr notification |
| subnet\_bits | subnetwork bits |
| subnet\_blocks | subnet blocks |
| subnet\_netmask | subnetwork netmask |
| subnets | subnetwork details |
| wildcard | wildcard address |

