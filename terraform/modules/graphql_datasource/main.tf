data "archive_file" "lambda_deployment_package" {
    type = "zip"
    source_dir = "${var.source_path}"
    output_path = "${local.lambda_deployment_package_output_path}"
    #depends_on = [ null_resource.lambda_knex_datasource_deps ]
}



resource "aws_lambda_function" "graphql_lambda" {
    function_name = "${local.lambda_function_name}"
    description = "${var.type} handler, for the field ${var.field}, from the GraphQL API ${var.api_id}"
    filename = "${local.lambda_deployment_package_output_path}"
    source_code_hash = "${data.archive_file.lambda_deployment_package.output_base64sha256}"
    handler = "${var.lambda_handler}"
    runtime = "${var.lambda_runtime}"
    #   vpc_config {
    #     subnet_ids = var.local_db_subnet_ids
    #     security_group_ids = var.local_db_security_group_ids
    #   }
    #   environment {
    #     variables = {
    #       DBNAME        = "${var.local_db_name}"
    #       ENDPOINT      = "${var.local_db_endpoint}"
    #       USERNAME      = "${var.local_db_username}"
    #       PASSWORD      = "${var.local_db_password}"
    #     }
    #   }
    role = "${var.lambda_role}"
    timeout = "${var.lambda_timeout}"
    #   depends_on = [ aws_s3_bucket_object.knex_source_zip, data.archive_file.lambda_knex_datasource ]
    #depends_on = [
    #    archive_file.lambda_deployment_package,
    #]
}

resource "aws_appsync_datasource" "graphql_datasource" {
  api_id           = "${var.api_id}"
  name             = "${local.lambda_function_name}"
  type             = "AWS_LAMBDA"
  service_role_arn = "${var.lambda_role}"
  lambda_config {
      function_arn = "${aws_lambda_function.graphql_lambda.arn}"
  }
}

resource "aws_appsync_resolver" "test" {
    api_id = "${var.api_id}"
    field = "${var.field}"
    type = "${var.type}"
    data_source = "${aws_appsync_datasource.graphql_datasource.name}"
    request_template = <<EOF
{
  "version": "2018-05-29",
  "operation": "Invoke",
}
EOF
    response_template = <<EOF
  $util.toJson($context.result)
EOF
    #depends_on = [ aws_appsync_datasource.create_lambda_datasource ]
}