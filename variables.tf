variable "cluster_name" {
  type        = string
  description = "Cluster name"
}

variable "api_servers" {
  type        = list(string)
  description = "List of URLs used to reach kube-apiserver"
}

variable "etcd_servers" {
  type        = list(string)
  description = "List of URLs used to reach etcd servers."
}

# optional

variable "networking" {
  type        = string
  description = "Choice of networking provider (flannel or calico or cilium or none)"
  default     = "flannel"

  validation {
    condition     = contains(["flannel", "calico", "cilium", "none"], var.networking)
    error_message = "The networking option must be set to either flannel, calico, cilium, or none."
  }
}

variable "network_mtu" {
  type        = number
  description = "CNI interface MTU (only applies to calico)"
  default     = 1500
}

variable "network_encapsulation" {
  type        = string
  description = "Network encapsulation mode ipip, vxlan or never (only applies to calico)"
  default     = "ipip"
}

variable "network_ip_autodetection_method" {
  type        = string
  description = "Method to autodetect the host IPv4 address (only applies to calico)"
  default     = "first-found"
}

variable "pod_cidr" {
  type        = string
  description = "CIDR IP range to assign Kubernetes pods"
  default     = "10.2.0.0/16"
}

variable "service_cidr" {
  type        = string
  description = <<EOD
CIDR IP range to assign Kubernetes services.
The 1st IP will be reserved for kube_apiserver, the 10th IP will be reserved for kube-dns.
EOD
  default     = "10.3.0.0/24"
}

variable "container_images" {
  type        = map(string)
  description = "Container images to use"
}

variable "enable_reporting" {
  type        = bool
  description = "Enable usage or analytics reporting to upstream component owners (Tigera: Calico)"
  default     = false
}

variable "enable_aggregation" {
  type        = bool
  description = "Enable the Kubernetes Aggregation Layer (defaults to true)"
  default     = true
}

variable "daemonset_tolerations" {
  type        = list(string)
  description = "List of additional taint keys kube-system DaemonSets should tolerate (e.g. ['custom-role', 'gpu-role'])"
  default     = []
}

# unofficial, temporary, may be removed without notice

variable "external_apiserver_port" {
  type        = number
  description = "External kube-apiserver port (e.g. 6443 to match internal kube-apiserver port)"
  default     = 6443
}

variable "cluster_domain_suffix" {
  type        = string
  description = "Queries for domains with the suffix will be answered by kube-dns"
  default     = "cluster.local"
}

variable "components" {
  description = "Configure pre-installed cluster components"
  type = object({
    enable = optional(bool, true)
    coredns = optional(
      object({
        enable = optional(bool, true)
      }),
      {
        enable = true
      }
    )
    kube_proxy = optional(
      object({
        enable = optional(bool, true)
      }),
      {
        enable = true
      }
    )
    # CNI providers are enabled for pre-install by default, but only the
    # provider matching var.networking is actually installed.
    flannel = optional(
      object({
        enable = optional(bool, true)
      }),
      {
        enable = true
      }
    )
    calico = optional(
      object({
        enable = optional(bool, true)
      }),
      {
        enable = true
      }
    )
    cilium = optional(
      object({
        enable = optional(bool, true)
      }),
      {
        enable = true
      }
    )
  })
  default = {
    enable     = true
    coredns    = null
    kube_proxy = null
    flannel    = null
    calico     = null
    cilium     = null
  }
  # Set the variable value to the default value when the caller
  # sets it to null.
  nullable = false
}
