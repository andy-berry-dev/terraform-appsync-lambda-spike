locals {
    vpc_cidr_ip_address_prefix = "10.0"
    vpc_cidr_ip_address_suffix = "0.0"
    vpc_cidr_ip_address = "${local.vpc_cidr_ip_address_prefix}.${local.vpc_cidr_ip_address_suffix}"
    vpc_cidr_ip_subnet_mask = "${local.vpc_cidr_ip_address}/16"
    vpc_cidr_ip_subnet_netmask = "${local.vpc_cidr_ip_address}/255.0.0.0"

}