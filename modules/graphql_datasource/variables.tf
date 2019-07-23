variable "api_id" {
    description = "The API for the GraphQL API"
    type = string
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

