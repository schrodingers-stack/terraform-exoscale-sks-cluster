# NOTE: the variables in this file are organized in alphabetical order.

variable "auto_upgrade" {
  type        = bool
  default     = false
  nullable    = false
  description = "Enable automatic upgrade of the SKS cluster control plane."
}

variable "cni" {
  type        = string
  default     = "cilium"
  nullable    = false
  description = "Specify which CNI plugin to use (cannot be changed after the first deployment). Accepted values are `calico` or `cilium`. This module creates the required security group rules."

  validation {
    condition     = contains(["calico", "cilium"], var.cni)
    error_message = "The CNI plugin must be either 'calico' or 'cilium'."
  }
}

variable "csi" {
  type = object({
    enabled = bool
    default = bool
  })
  default = {
    enabled = true
    default = true
  }
  nullable    = false
  description = "Enable the Exoscale CSI driver and eventually set its `StorageClass` as the default one to be used by `PersistentVolumeClaims`."

  validation {
    condition     = var.csi.default == true ? var.csi.enabled == true : true
    error_message = "The Exoscale CSI driver must be enabled if you want to set its `StorageClass` as the default `PersistentVolume` provider for the cluster."
  }
}

variable "description" {
  type        = string
  default     = null
  description = "A free-form string description to apply to the SKS cluster."
}

variable "enable_private_lb" {
  type        = bool
  default     = false
  description = "Enable the creation of a private load balancer for the SKS cluster. This will expose the services of the cluster to the IPs defined in the `var.private_lb_ip_whitelist`."
}

variable "enable_public_lb" {
  type        = bool
  default     = true
  description = "Enable the creation of a public load balancer for the SKS cluster. This will expose the services of the cluster to the internet."
}

variable "kubeconfig_file_create" {
  description = "Create a Kubeconfig file in the directory where `terraform apply` is run. The file will be named `<cluster_name>-config.yaml`."
  type        = bool
  default     = false
}

variable "kubeconfig_ttl" {
  description = "Validity period of the Kubeconfig file (that is used to create the `kubernetes_*` authentication outputs) in seconds. See https://registry.terraform.io/providers/exoscale/exoscale/latest/docs/resources/sks_kubeconfig#ttl_seconds[official documentation] for more information, namely the effect of setting the TTL."
  type        = number
  default     = 0 # Unlimited lifetime
}

variable "kubeconfig_early_renewal" {
  description = "Renew the Kubeconfig file (that is used to create the `kubernetes_*` authentication outputs) if its age is older than this value in seconds. See https://registry.terraform.io/providers/exoscale/exoscale/latest/docs/resources/sks_kubeconfig#early_renewal_seconds[official documentation] for more information."
  type        = number
  default     = 0
}

variable "kubernetes_version" {
  type        = string
  nullable    = false
  description = "The Kubernetes version to use for the SKS cluster. You can use the https://community.exoscale.com/documentation/tools/exoscale-command-line-interface/[Exoscale CLI] and run `exo compute sks versions` to see the available versions. May only be set at creation time."
}

variable "oidc" {
  type = object({
    client_id       = string
    issuer_url      = string
    groups_claim    = optional(string)
    groups_prefix   = optional(string)
    required_claim  = optional(map(string))
    username_claim  = optional(string)
    username_prefix = optional(string)
  })
  default     = null
  description = "OpenID Connect configuration to allow access to the SKS cluster. Can only be set at creation time."
}

variable "name" {
  type        = string
  nullable    = false
  description = "The name of the SKS cluster."
}

variable "nodepools" {
  type = map(object({
    size                = number
    instance_type       = string
    instance_prefix     = optional(string, null)
    disk_size           = optional(number, 50)
    labels              = optional(map(string), {})
    taints              = optional(map(string), {})
    private_network_ids = optional(list(string), [])
    security_group_ids  = optional(list(string), [])
  }))
  nullable    = false
  description = <<-EOT
    Map containing the SKS node pools to be created.

    Needs to be a map of maps, where the key is the name of the node pool and the value is a map containing at least the keys `instance_type` and `size`.
    The other keys are optional: `description`, `instance_prefix`, `disk_size`, `labels`, `taints`, `private_network_ids` and `security_group_ids`. Check the official documentation https://registry.terraform.io/providers/exoscale/exoscale/latest/docs/resources/sks_nodepool[here] for more information.
  EOT
}
variable "private_lb_nodepool" {
  type        = string
  default     = null
  description = <<-EOT
    The name of the node pool to use as the backend for the public load balancer.
    
    This is the node pool where your public ingress controller should reside. A new security group with specific rules will be created for this node pool.
  EOT

  validation {
    condition     = var.enable_private_lb ? var.private_lb_nodepool != null : true
    error_message = "The private load balancer is enabled, but `var.private_lb_nodepool` is not set. Please provide the name of the node pool to use as the backend for the private load balancer."
  }

  validation {
    condition     = var.private_lb_nodepool != null ? contains(keys(var.nodepools), var.private_lb_nodepool) : true
    error_message = "The name of node pool to be attached to the security group rules of the private load balancer must be present in `var.nodepools`."
  }
}

variable "private_lb_ip_whitelist" {
  type        = list(string)
  nullable    = false
  default     = []
  description = "List of IP addresses or CIDR blocks that are allowed to access the private load balancer. If empty, the private load balancer will not be accessible from the internet."

  validation {
    condition     = var.enable_private_lb ? length(var.private_lb_ip_whitelist) > 0 : true
    error_message = "The private load balancer is enabled, but the IP whitelist is empty. Please provide at least one IP address or CIDR block."
  }
}

variable "public_lb_nodepool" {
  type        = string
  default     = null
  description = <<-EOT
    The name of the node pool to use as the backend for the public load balancer.
    
    This is the node pool where your public ingress controller should reside. A new security group with specific rules will be created for this node pool.
    
    If not set, the first node pool in `var.nodepools` will be used.
  EOT

  validation {
    condition     = var.enable_public_lb && var.public_lb_nodepool != null ? contains(keys(var.nodepools), var.public_lb_nodepool) : true
    error_message = "The name of node pool to be attached to the security group rules of the public load balancer must be present in `var.nodepools`."
  }

  validation {
    condition = (var.enable_public_lb && var.enable_private_lb && var.private_lb_nodepool != null ?
      (var.public_lb_nodepool == null ?
        var.private_lb_nodepool != keys(var.nodepools)[0] :
        var.public_lb_nodepool != var.private_lb_nodepool
      ) :
      true
    )
    error_message = "The public and private load balancers cannot use the same node pool as the backend."
  }
}

variable "service_level" {
  type        = string
  default     = "pro"
  description = "Choose the service level for the SKS cluster. _Starter_ can be used for test and development purposes, _Pro_ is recommended for production workloads. The official documentation is available https://community.exoscale.com/documentation/sks/overview/#pricing-tiers[here]."

  validation {
    condition     = contains(["starter", "pro"], var.service_level)
    error_message = "The service level must be either 'starter' or 'pro'."
  }
}

variable "zone" {
  type        = string
  nullable    = false
  description = "The name of the zone where to deploy the SKS cluster. Available zones can be consulted https://community.exoscale.com/documentation/sks/overview/#availability[here]."
}
