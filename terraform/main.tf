# ========================================================
# Infrastructure Definition (V4 - Security Hardened Schema)
# ========================================================

# 1. AWS S3 Bucket for static assets hosting
resource "aws_s3_bucket" "website_bucket" {
  bucket = "${var.project_name}-${var.domain_name}"
}

# 2. Block Public Access (Best practice for security)
resource "aws_s3_bucket_public_access_block" "website_bucket_lockdown" {
  bucket = aws_s3_bucket.website_bucket.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

# 3. *** SECURITY FIX: Define Origin Access Control (OAC) ***
# This resource generates the secure ID that restricts access to CloudFront only.
resource "aws_cloudfront_origin_access_control" "website_oac" {
  name                              = "my-s3-oac"
  description                       = "OAC for secure S3 access via CloudFront"
  origin_access_control_origin_type = "s3" # Must be 's3' when accessing an S3 bucket
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# 4. S3 Bucket Policy restricted ONLY to the OAC (Principle of Least Privilege)
resource "aws_s3_bucket_policy" "allow_cloudfront" {
  bucket = aws_s3_bucket.website_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "RestrictToCloudFrontOAC",
        Effect    = "Allow",
        Principal = {
          AWS = [aws_cloudfront_origin_access_control.website_oac.iam_arn] # Use the OAC ARN as principal
        },
        Action   = "s3:GetObject",
        Resource = "${aws_s3_bucket.website_bucket.arn}/*"
      }
    ]
  })
}

# 5. CloudFront Distribution pointing to the S3 bucket (Now using OAC)
resource "aws_cloudfront_distribution" "main" {
  origin          = aws_s3_bucket.website_bucket.id # Origin ID for reference, actual config is in s3_origin_config block
  enabled         = true
  default_root_object = "index.html"

  # Define the S3 origin and enforce OAC usage
  origin {
    domain_name = aws_s3_bucket.website_bucket.bucket_regional_domain_name
    origin_id   = "${var.project_name}-s3-origin"
    s3_origin_config {
      # This is the correct way to enforce the OAC ID for s3 origins
      origin_access_control_id = aws_cloudfront_origin_access_control.website_oac.id
    }
  }

  default_cache_behavior {
    target_origin_id       = "${var.project_name}-s3-origin" # Must match the origin ID above
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]

    forwarded_values {
      query     = true
      cookies   = {}
      headers   = []
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true # Use ACM certs in production
  }
}