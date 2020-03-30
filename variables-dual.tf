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
