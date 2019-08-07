# Variables specific to the dual fork

variable "apiserver_vip" {
  description = "VIP to use for apiserver HA via keepalived"
  type        = "string"
  default     = ""
}

variable "apiserver_extra_arguments" {
  description = "List of extra arguments for the kube-apiserver"
  type        = "list"
  default     = []
}

variable "apiserver_extra_secrets" {
  description = "Map of extra data to insert into the kube-apiserver Secrets (values must be BASE64 encoded)"
  type        = "map"
  default     = {}
}