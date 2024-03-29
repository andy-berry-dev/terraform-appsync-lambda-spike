variable "cluster_name" {
    description = "The name/id of the cluster"
    type = string
}

variable "subnet_name" {
    description = "The name of the subnet to deploy to"
    type = string
}

variable "security_group_ids" {
    description = "The security group IDs for the cluster"
    type = set(string)
    default = []
}

variable "node_type" {
    description = "The size of the node"
    type = string
    default = "cache.t2.micro"
}

variable "parameter_group_name" {
    description = "The name of the parameter group"
    type = string
    default = "default.redis3.2"
}

variable "engine_version" {
    description = "The engine version"
    type = string
    default = "3.2.10"
}

variable "port" {
    description = "Redis port"
    type = number
    default = 6379
}

