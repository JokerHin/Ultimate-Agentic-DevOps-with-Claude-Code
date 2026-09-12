# Terraform Template Specification

## Target Architecture

- **Provider**: AWS (`hashicorp/aws`, version `~> 5.0`)
- **Hosting**: AWS S3 bucket configured for website hosting (or CloudFront OAC origin)
- **CDN**: CloudFront distribution pointing to the S3 bucket
- **Default Root Object**: `index.html`

## Files to Generate in `terraform/`:

1. `providers.tf`: AWS provider definition with default region `us-east-1` (or parameterizable).
2. `variables.tf`: Configuration variables for bucket name, project environment, and domain names.
3. `main.tf`:
   - `aws_s3_bucket`
   - `aws_s3_bucket_public_access_block`
   - `aws_s3_bucket_policy`
   - `aws_cloudfront_distribution`
4. `outputs.tf`:
   - S3 bucket name and ARN
   - CloudFront distribution ID and domain name
