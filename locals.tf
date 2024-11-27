locals {
  # Decode the YAML kubeconfig file into a structured value in order to generate separate outputs for each of 
  # its fields.
  kubeconfig = yamldecode(resource.exoscale_sks_kubeconfig.this.kubeconfig)

  # Select the default node pool to associate with the LB if it is not is not defined.
  # NOTE: technically, the `private_lb_instance_pool_name` will always be the same as `var.private_lb_nodepool` 
  # because it is a required variable.
  public_lb_instance_pool_name  = var.public_lb_nodepool != null ? var.public_lb_nodepool : keys(var.nodepools)[0]
  private_lb_instance_pool_name = var.private_lb_nodepool != null ? var.private_lb_nodepool : keys(var.nodepools)[0]
}
