# https://github.com/terraform-aws-modules/terraform-aws-vpc/tree/v1.49.0/examples/simple-vpc

module "vpc" {
    source = "terraform-aws-modules/vpc/aws"
    version = "2.2.0"
    name = "${var.name}"
    cidr = "${local.vpc_cidr_ip_subnet_mask}"
    azs = var.azs

    private_subnets = [
        "${local.vpc_cidr_ip_address_prefix}.1.0/24",
        "${local.vpc_cidr_ip_address_prefix}.2.0/24",
        "${local.vpc_cidr_ip_address_prefix}.3.0/25"
    ]

    public_subnets  = [
        "${local.vpc_cidr_ip_address_prefix}.4.0/24",
        "${local.vpc_cidr_ip_address_prefix}.5.0/24",
        "${local.vpc_cidr_ip_address_prefix}.6.0/25"
    ]

    database_subnets = [
        "${local.vpc_cidr_ip_address_prefix}.7.0/24",
        "${local.vpc_cidr_ip_address_prefix}.8.0/24",
        "${local.vpc_cidr_ip_address_prefix}.9.0/25"
    ]

    elasticache_subnets = [
        "${local.vpc_cidr_ip_address_prefix}.10.0/24",
        "${local.vpc_cidr_ip_address_prefix}.11.0/24",
        "${local.vpc_cidr_ip_address_prefix}.12.0/25"
    ]

    assign_generated_ipv6_cidr_block = true

    enable_nat_gateway = true
    single_nat_gateway = true

    public_subnet_tags = {}
    tags = {}
    vpc_tags = {}
}