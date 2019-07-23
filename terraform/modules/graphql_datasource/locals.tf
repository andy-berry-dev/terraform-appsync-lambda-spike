locals {
   lambda_function_name = "graphql_${var.type}_${var.field}"

   lambda_deployment_package_output_path = "./build/${local.lambda_function_name}.zip"
}
