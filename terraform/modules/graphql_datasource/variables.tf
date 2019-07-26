variable "api_id" {
    description = "The API for the GraphQL API"
    type = string
}

variable "subnet_ids" {
    description = "The IDs of the subnet(s) to deploy the Lambda function to"
    type = list(string)
}

variable "security_group_ids" {
    description = "The ID(s) of the security group for the Lambda function"
    type = list(string)
}

variable "lambda_role" {
    description = "The role for the Lambda function"
    type = string
}

variable "type" {
    description = "The type of the datasource"
    type = string
}

variable "field" {
    description = "The field of the datasource"
    type = string
}

variable "source_path" {
    description = "The path for the Lambda source code"
    type = string
}

variable "env_vars" {
    description = "Environment variables for the Lambda function"
    type = map
}

variable "lambda_layers" {
    description = "The function entrypoint"
    type = list(string)
    default = []
}

variable "lambda_handler" {
    description = "The function entrypoint"
    type = string
    default = "index.handler"
}

variable "lambda_runtime" {
    description = "The function runtime"
    type = string
    default = "nodejs10.x"
}

variable "lambda_memory_size" {
    description = "Memory allocation for the lambda function"
    type = number
    default = 128
}

variable "lambda_timeout" {
    description = "Timeout value for the lambda function"
    type = number
    default = 5
}

