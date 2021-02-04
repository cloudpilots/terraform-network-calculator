variable "net" {
  description = "Network in CIDR notation"
}

variable "subnet_bits" {
  description = "subnetwork bits"
  default     = 0
  type        = number
}

variable "subnet_prefix" {
  description = "subnet prefix"
  default     = ""
}

