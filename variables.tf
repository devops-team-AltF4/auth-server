# variables.tf | Auth and Application variables

# variable "aws_access_key" {
#   type        = string
#   description = "AWS Access Key"
# }

# variable "aws_secret_key" {
#   type        = string
#   description = "AWS Secret Key"
# }

# variable "aws_key_pair_name" {
#   type        = string
#   description = "AWS Key Pair Name"
# }

# variable "aws_key_pair_file" {
#   type = string
#   description = "AWS Key Pair File"
# }

variable "aws_region" {
  type        = string
  description = "AWS Region"
  default = "ap-northeast-2"
}

variable "aws_cloudwatch_retention_in_days" {
  type        = number
  description = "AWS CloudWatch Logs Retention in Days"
  default     = 1
}

variable "app_name" {
  type        = string
  description = "Application Name"
  default = "dev-app"
}

variable "app_environment" {
  type        = string
  description = "Application Environment"
  default = "dev"
}

variable "cidr" {
  description = "The CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "List of public subnets"
  default = ["10.10.100.0/24", "10.10.101.0/24"]
}

variable "private_subnets" {
  description = "List of private subnets"
  default = ["10.10.0.0/24", "10.10.1.0/24"]
}

variable "availability_zones" {
  description = "List of availability zones"
  default = ["ap-northeast-2a", "ap-northeast-2b"]
}
