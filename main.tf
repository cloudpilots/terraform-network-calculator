/**
* # Terraform Network Calculator
* 
* This terraform helps you to do some network and subnetwork calculations.
* 
* example:
* 
* ```hcl
* module "net_10_10" {
*   source      = "github.com/cloudpilots/terraform-network-calculator"
*   net         = "10.10.0.0/16"
*   subnet_bits = 4
* }
* ```
* 
* This renders mulitple useable and readable output, `net_description` is shown here:
* ```txt
* network:            10.10.0.0/16
* network cidr:       /16
* netmask:            255.255.0.0
* wildcard:           0.0.255.255 
* net addr:           10.10.0.0
* broadcast addr:     10.10.255.255
* address count:      65536
* useable addresses:  65534
* 
*     
* subnetworks: 16
*     0: 10.10.0.0/20 255.255.240.0 10.10.0.0 - 10.10.15.255
*     1: 10.10.16.0/20 255.255.240.0 10.10.16.0 - 10.10.31.255
*     2: 10.10.32.0/20 255.255.240.0 10.10.32.0 - 10.10.47.255
*     3: 10.10.48.0/20 255.255.240.0 10.10.48.0 - 10.10.63.255
*     4: 10.10.64.0/20 255.255.240.0 10.10.64.0 - 10.10.79.255
*     5: 10.10.80.0/20 255.255.240.0 10.10.80.0 - 10.10.95.255
*     6: 10.10.96.0/20 255.255.240.0 10.10.96.0 - 10.10.111.255
*     7: 10.10.112.0/20 255.255.240.0 10.10.112.0 - 10.10.127.255
*     8: 10.10.128.0/20 255.255.240.0 10.10.128.0 - 10.10.143.255
*     9: 10.10.144.0/20 255.255.240.0 10.10.144.0 - 10.10.159.255
*     10: 10.10.160.0/20 255.255.240.0 10.10.160.0 - 10.10.175.255
*     11: 10.10.176.0/20 255.255.240.0 10.10.176.0 - 10.10.191.255
*     12: 10.10.192.0/20 255.255.240.0 10.10.192.0 - 10.10.207.255
*     13: 10.10.208.0/20 255.255.240.0 10.10.208.0 - 10.10.223.255
*     14: 10.10.224.0/20 255.255.240.0 10.10.224.0 - 10.10.239.255
*     15: 10.10.240.0/20 255.255.240.0 10.10.240.0 - 10.10.255.255
* ```
*/

locals {
  prefix_regex = "/.*\\//"

  net = var.net

  net_addr = cidrhost(local.net, 0)
  netmask  = cidrnetmask(local.net)

  netmask_bits = [for bits in split(".", local.netmask) : tonumber(bits)]
  wildcard_bits = [
    for bits in local.netmask_bits : 255 - bits
  ]
  wildcard = join(".", local.wildcard_bits)

  prefix    = tonumber(replace(local.net, local.prefix_regex, ""))
  base_bits = 32 - local.prefix

  address_count  = pow(2, local.base_bits)
  host_count     = local.address_count - 2
  broadcast_addr = cidrhost(local.net, local.address_count - 1)

  subnet_prefix      = try(tonumber(replace(var.subnet_prefix, "/[^0-9]+/", "")), 0)
  subnet_prefix_bits = local.subnet_prefix > local.prefix ? local.subnet_prefix - local.prefix : 0
  subnet_bits        = var.subnet_bits > 0 ? var.subnet_bits : local.subnet_prefix_bits
  subnets_bits = [
    for index in range(pow(2, local.subnet_bits)) : local.subnet_bits
  ]
  subnet_blocks = local.subnet_bits > 0 ? cidrsubnets(local.net, local.subnets_bits...) : [local.net]
  subnet_blocks_details = [
    for subnet in local.subnet_blocks : {
      index         = index(local.subnet_blocks, subnet)
      net           = subnet
      net_addr      = cidrhost(subnet, 0)
      prefix        = tonumber(replace(subnet, local.prefix_regex, ""))
      netmask       = cidrnetmask(subnet)
      address_count = pow(2, 32 - tonumber(replace(subnet, local.prefix_regex, "")))
      broadcast     = cidrhost(subnet, pow(2, 32 - tonumber(replace(subnet, local.prefix_regex, ""))) - 1)
    }
  ]
  subnet_netmask = cidrnetmask(local.subnet_blocks[0])


  net_description = <<-EOT
    network:            ${local.net}
    network cidr:       /${local.prefix}
    netmask:            ${local.netmask}
    wildcard:           ${local.wildcard} 
    net addr:           ${local.net_addr}
    broadcast addr:     ${local.broadcast_addr}
    address count:      ${local.address_count}
    useable addresses:  ${local.host_count}
    %{if local.subnet_bits > 0}
    
    subnetworks: ${length(local.subnet_blocks)}%{for subnet in local.subnet_blocks_details}
      ${format("%3d: %s %s %s - %s", subnet.index, subnet.net, subnet.netmask, subnet.net_addr, subnet.broadcast)}%{endfor}
    %{endif}
  EOT
}



