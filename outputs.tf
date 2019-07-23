output "appsync_endpoints" {
  value = "${aws_appsync_graphql_api.graphql_api.uris}"
}
