output "net" {
  description = "network"
  value       = local.net
}

output "net_address" {
  description = "netork address"
  value       = local.net_addr
}

output "broadcast_addr" {
  description = "network broadcast address"
  value       = local.broadcast_addr
}

output "netmask" {
  description = "network mask"
  value       = local.netmask
}

output "wildcard" {
  description = "wildcard address"
  value       = local.wildcard
}

output "subnet_bits" {
  description = "subnetwork bits"
  value       = local.subnet_bits
}

output "subnet_blocks" {
  description = "subnet blocks"
  value       = local.subnet_blocks
}

output "subnet_netmask" {
  description = "subnetwork netmask"
  value       = local.subnet_netmask
}

output "subnets" {
  description = "subnetwork details"
  value       = local.subnet_blocks_details
}


output "network_cidr" {
  description = "network cidr notification"
  value       = "/${local.prefix}"
}

output "address_count" {
  description = "amount of addresses in this network"
  value       = local.address_count
}
output "host_count" {
  description = "amount of useable addresses in this network"
  value       = local.host_count
}

output "net_description" {
  description = "string describing the network for better readabiltity"
  value       = local.net_description
}
