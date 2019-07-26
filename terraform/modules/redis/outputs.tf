output "cache_nodes" {
  value = "${aws_elasticache_cluster.redis.cache_nodes}"
}
output "port" {
  value = "${aws_elasticache_cluster.redis.port}"
}
output "cluster_id" {
  value = "${aws_elasticache_cluster.redis.cluster_id}"
}
