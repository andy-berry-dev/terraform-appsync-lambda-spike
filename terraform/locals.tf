locals {
    build_dir = "./build"
    lambda_common_node_modules_layer_name = "common_node_modules"
    lambda_common_node_modules_layer_output_path = "${local.build_dir}/${local.lambda_common_node_modules_layer_name}.zip"
    lambda_utils_layer_name = "mobilize-dashboard-api-utils"
    lambda_utils_layer_output_path = "${local.build_dir}/${local.lambda_utils_layer_name}.zip"
}