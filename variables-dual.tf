# Variables specific to the dual fork

variable "apiserver_vip" {
  description = "VIP to use for apiserver HA via keepalived"
  type        = string
}

variable "apiserver_vip_interface" {
  description = "Interface to use for apiserver HA via keepalived"
  type        = string
}

variable "apiserver_vip_vrrp_id" {
  description = "VRRP id to use for apiserver HA via keepalived"
  type        = number
}

variable "apiserver_extra_arguments" {
  description = "List of extra arguments for the kube-apiserver"
  type        = list(string)
  default     = []
}

variable "enable_kube_proxy" {
  description = "Enable kube-proxy daemon set"
  type        = bool
  default     = true
}

variable "apiserver_cert_dns_names" {
  description = "List of additional DNS names to add to the kube-apiserver TLS certificate"
  type        = list(string)
  default     = []
}

variable "apiserver_cert_ip_addresses" {
  description = "List of additional IP addresses to add to the kube-apiserver TLS certificate"
  type        = list(string)
  default     = []
}
