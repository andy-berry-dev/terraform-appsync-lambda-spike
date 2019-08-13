resource "aws_iam_role" "appsync_graphql_role" {
  name = "appsync-lambda-resolver"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "appsync.amazonaws.com"
      },
      "Effect": "Allow"
    },
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "appsync_graphql_policy" {
  name = "appsync-lambda-resolver"
  role = "appsync-lambda-resolver"
  depends_on = [ aws_iam_role.appsync_graphql_role ]
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
          "lambda:invokeFunction"
      ],
      "Resource": [
          "*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "appsync_graphql_AWSLambdaVPCAccessExecutionRole" {
    role = "${aws_iam_role.appsync_graphql_role.name}"
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}


module "vpc" {
    source = "./modules/vpc"
    name = "Test"
}


resource "aws_appsync_graphql_api" "graphql_api" {
    authentication_type = "API_KEY"
    name = "test-graphql-api"
    schema = <<EOF
schema {
    query: Query
}
type Query {
    test: Int
}
EOF
}

# module "rds" {
#     source = "./modules/rds"
#     cluster_name = "graphql-test"
#     master_username = "root"
#     master_password = "supersecret1234"
#     auto_pause = true
#     max_capacity = 1
#     min_capacity = 1
#     seconds_until_auto_pause = 300
#     subnet_name = "${module.vpc.vpc.elasticache_subnet_group_name}"
# }

module "redis_cache" {
    source = "./modules/redis"
    cluster_name = "graphql-test"
    subnet_name = "${module.vpc.vpc.elasticache_subnet_group_name}"
    security_group_ids = ["${module.vpc.vpc.default_security_group_id}"]
}

# archive_file has a bug where it doesn't follow symlinks
# use an external zip call instead - see https://github.com/terraform-providers/terraform-provider-archive/issues/6#issuecomment-321380047
data "external" "lambda_common_node_modules_layer" {
    program = ["sh", "${path.module}/bin/node_modules_zip.sh"]
    working_dir = "${path.module}"
    query = {
        build_dir = "${local.build_dir}"
        node_modules_src = "${path.module}/../dashboard-api/node_modules"
        zipfile_path = "${local.lambda_common_node_modules_layer_output_path}"
    }
}

resource "aws_lambda_layer_version" "lambda_common_node_modules_layer" {
    layer_name = "${local.lambda_common_node_modules_layer_name}"
    filename   = "${data.external.lambda_common_node_modules_layer.result.zipfile_path}"
    source_code_hash = "${data.external.lambda_common_node_modules_layer.result.zipfile_hash}"
    compatible_runtimes = ["nodejs8.10"]
    depends_on = [ data.external.lambda_common_node_modules_layer ]
}

module "graphql_query_test" {
    source = "./modules/graphql_datasource"
    api_id = "${aws_appsync_graphql_api.graphql_api.id}"
    lambda_role = "${aws_iam_role.appsync_graphql_role.arn}"
    type = "Query"
    field = "test"
    source_path = "../dashboard-api/graphql"
    lambda_handler = "queries/test/index.handler"
    lambda_layers = [
      "${aws_lambda_layer_version.lambda_common_node_modules_layer.arn}"
    ]
    subnet_ids = "${module.vpc.vpc.private_subnets}"
    # TODO: change the security group
    security_group_ids = ["${module.vpc.vpc.default_security_group_id}"]
    env_vars = {
        REDIS_HOST = "${module.redis_cache.cache_nodes.0.address}"
        REDIS_PORT = "${module.redis_cache.port}"
    }
}
