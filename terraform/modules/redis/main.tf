resource "aws_elasticache_cluster" "redis" {
    cluster_id = "${var.cluster_name}"
    engine = "redis"
    node_type = "${var.node_type}"
    num_cache_nodes = 1
    parameter_group_name = "${var.parameter_group_name}"
    engine_version = "${var.engine_version}"
    port = "${var.port}"
    subnet_group_name = "${var.subnet_name}"
    security_group_ids = "${var.security_group_ids}"
}