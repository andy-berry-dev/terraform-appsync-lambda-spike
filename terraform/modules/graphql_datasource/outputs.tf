output "datasource_arn" {
  value = "${aws_appsync_datasource.graphql_datasource.arn}"
}

output "lambda_arn" {
  value = "${aws_lambda_function.graphql_lambda.arn}"
}