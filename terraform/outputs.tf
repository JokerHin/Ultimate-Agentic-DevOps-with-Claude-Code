# ========================================================
# Outputs
# ========================================================

output "s3_bucket_name" {
  description = "The name of the deployed S3 bucket."
  value       = aws_s3_bucket.website_bucket.bucket
}

output "s3_bucket_arn" {
  description = "The Amazon Resource Name (ARN) for the S3 bucket."
  value       = aws_s3_bucket.website_bucket.arn
}

output "cloudfront_distribution_id" {
  description = "The ID of the CloudFront distribution."
  value       = aws_cloudfront_distribution.main.id
}

output "cloudfront_domain_name" {
  description = "The domain name (endpoint) for the CloudFront distribution."
  value       = aws_cloudfront_distribution.main.domain_name
}