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
# }

module "redis_cache" {
    source = "./modules/redis"
    cluster_name = "graphql-test"
}

module "graphql_query_test" {
    source = "./modules/graphql_datasource"
    api_id = "${aws_appsync_graphql_api.graphql_api.id}"
    lambda_role = "${aws_iam_role.appsync_graphql_role.arn}"
    type = "Query"
    field = "test"
    source_path = "../engine/graphql/queries/test"
}