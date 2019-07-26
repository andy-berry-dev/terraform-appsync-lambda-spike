variable "name" {
    description = "The name of the VPC"
    type = string
}

variable "azs" {
  description = "The AZS to use for the VPC"
  type = list(string)
  default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}