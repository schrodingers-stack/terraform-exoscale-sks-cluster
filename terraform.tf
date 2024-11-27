terraform {
  # Require Terraform 1.9.0 or later because of cross variable validation.
  required_version = ">= 1.9.0"
  required_providers {
    exoscale = {
      source  = "exoscale/exoscale"
      version = ">= 0.61.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.0.0"
    }
  }
}
