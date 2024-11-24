resource "exoscale_security_group" "default" {
  name        = format("%s-default-sg", var.name)
  description = "Default security group for `${var.name}` SKS cluster."
}

resource "exoscale_security_group_rule" "sks_logs" {
  security_group_id = resource.exoscale_security_group.default.id
  description       = "Allow kubelet traffic between worker nodes."
  type              = "INGRESS"
  protocol          = "TCP"
  cidr              = "0.0.0.0/0"
  start_port        = 10250
  end_port          = 10250
}

resource "exoscale_security_group_rule" "calico_traffic" {
  count = var.cni == "calico" ? 1 : 0

  security_group_id      = resource.exoscale_security_group.default.id
  user_security_group_id = resource.exoscale_security_group.default.id
  description            = "Allow Calico VXLAN communication between worker nodes."
  type                   = "INGRESS"
  protocol               = "UDP"
  start_port             = 4789
  end_port               = 4789
}

resource "exoscale_security_group_rule" "cilium_traffic" {
  count = var.cni == "cilium" ? 1 : 0

  security_group_id      = resource.exoscale_security_group.default.id
  user_security_group_id = resource.exoscale_security_group.default.id
  description            = "Allow Cilium VXLAN communication between worker nodes."
  type                   = "INGRESS"
  protocol               = "UDP"
  start_port             = 8472
  end_port               = 8472
}

resource "exoscale_security_group_rule" "cilium_health_check" {
  count = var.cni == "cilium" ? 1 : 0

  security_group_id      = resource.exoscale_security_group.default.id
  user_security_group_id = resource.exoscale_security_group.default.id
  description            = "Allow Calico health checks between worker nodes."
  type                   = "INGRESS"
  protocol               = "TCP"
  start_port             = 4240
  end_port               = 4240
}

resource "exoscale_security_group_rule" "cilium_health_check_icmp" {
  count = var.cni == "cilium" ? 1 : 0

  security_group_id      = resource.exoscale_security_group.default.id
  user_security_group_id = resource.exoscale_security_group.default.id
  description            = "Allow Calico health checks ICMP between worker nodes."
  type                   = "INGRESS"
  protocol               = "ICMP"
  icmp_code              = 0
  icmp_type              = 8
}

resource "exoscale_security_group_rule" "all" {
  description            = "Allow all traffic from the security group itself."
  security_group_id      = resource.exoscale_security_group.default.id
  user_security_group_id = resource.exoscale_security_group.default.id
  type                   = "INGRESS"
  protocol               = "TCP"
  start_port             = 1
  end_port               = 65535
}
