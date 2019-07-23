variable "cluster_name" {
    description = "The name/id of the cluster"
    type = string
}

variable "master_username" {
    description = "The username for the root user"
    type = string
}
variable "master_password" {
    description = "The password for the root user"
    type = string
}

variable "auto_pause" {
    description = "Pause if there is no usage"
    type = boolean
    deafult = true
}

variable "max_capacity" {
    description = "Maximum number of servers"
    type = number
    default = 5
}

variable "min_capacity" {
    description = "Minimum number of servers"
    type = number
    default = 1
}

variable "seconds_until_auto_pause" {
    description = "Seconds until pausing after no activity"
    type = number
    default = 300
}
