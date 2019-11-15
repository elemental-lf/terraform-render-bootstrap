# Variables specific to the dual fork

variable "apiserver_vip" {
  description = "VIP to use for apiserver HA via keepalived"
  type        = string
}

variable "apiserver_extra_arguments" {
  description = "List of extra arguments for the kube-apiserver"
  type        = list(string)
  default     = []
}
