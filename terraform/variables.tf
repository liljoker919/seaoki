# Terraform Variables for Sea OKI Collection AWS Infrastructure

variable "domain_name" {
  description = "The primary domain name for the website"
  type        = string
  default     = "seaoki.com"
}

variable "aws_region" {
  description = "AWS region for resources (must be us-east-1 for CloudFront/ACM)"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Name of the S3 bucket (defaults to domain_name)"
  type        = string
  default     = ""
}

variable "project_name" {
  description = "Project name for resource tagging"
  type        = string
  default     = "seaoki-collection"
}

variable "environment" {
  description = "Environment name (production, staging, etc.)"
  type        = string
  default     = "production"
}
