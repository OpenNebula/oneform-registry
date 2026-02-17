variable "cidr_block" {
    description = "CIDR block for the VPC"
    type        = string
    default     = "10.0.0.0/16"
}

variable "provision_id" {
    description = "Provision ID for the cluster"
    type        = number
}

variable "key_suffix" {
    description = "Suffix name for resource names"
    type        = string
}

variable "aws_tags" {
    description = "Tags to assign to the AWS resources"
    type        = map(string)
    default     = {}
}
