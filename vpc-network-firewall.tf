module "network_firewall" {
  count  = var.create_network_firewall && var.create_vpc && var.create_igw ? 1 : 0
 
  source  = "../terraform-unqork-network-firewall/"

  firewall_name = format("%s-firewall", var.name)
  vpc_id        = local.vpc_id

  subnet_mapping =  [
    for index, subnet in aws_subnet.firewall: {
      subnet_id = subnet.id
    }
  ]

  tags = {
    Name        = format("%s-firewall", var.name)
    Created_By  = "Terraform"
  }

  suricata_stateful_rule_group = var.suricata_stateful_rule_group
  domain_stateful_rule_group = var.domain_stateful_rule_group
  fivetuple_stateful_rule_group = var.fivetuple_stateful_rule_group
  stateless_rule_group = var.stateless_rule_group


}
