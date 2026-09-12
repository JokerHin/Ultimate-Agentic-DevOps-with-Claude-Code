# ========================================================
# Configuration Variables
# ========================================================

variable "aws_region" {
  description = "The AWS region to deploy resources into."
  type        = string
  default     = "us-east-1" # Default specified in spec or can be parameterized.
}

variable "project_name" {
  description = "A unique prefix for all created resources (e.g., marketing/acme)."
  type        = string
}

variable "domain_name" {
  description = "The root domain name for the website."
  type        = string
}