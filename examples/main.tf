module "net_10" {
  source = "github.com/cloudpilots/terraform-network-calculator"
  net    = "10.0.0.0/8"
}

module "net_172" {
  source        = "github.com/cloudpilots/terraform-network-calculator"
  net           = "172.16.0.0/12"
  subnet_prefix = "/16"
}

module "net_10_10" {
  source      = "github.com/cloudpilots/terraform-network-calculator"
  net         = "10.10.0.0/16"
  subnet_bits = 4
}

output "networks" {
  description = "all networks"
  value       = <<-EOT
    ${module.net_10.net_description}
    ${module.net_172.net_description}
    ${module.net_10_10.net_description}
EOT
}
