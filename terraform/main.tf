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

# 3. Define Origin Access Control (OAC)
resource "aws_cloudfront_origin_access_control" "website_oac" {
  name                              = "my-s3-oac"
  description                       = "OAC for secure S3 access via CloudFront"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# 4. S3 Bucket Policy restricted to CloudFront using OAC Condition
resource "aws_s3_bucket_policy" "allow_cloudfront" {
  bucket = aws_s3_bucket.website_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "AllowCloudFrontServicePrincipalReadOnly",
        Effect    = "Allow",
        Principal = {
          Service = "cloudfront.amazonaws.com"
        },
        Action   = "s3:GetObject",
        Resource = "${aws_s3_bucket.website_bucket.arn}/*",
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.main.arn
          }
        }
      }
    ]
  })
}

# 5. CloudFront Distribution pointing to the S3 bucket (Using OAC)
resource "aws_cloudfront_distribution" "main" {
  enabled             = true
  default_root_object = "index.html"

  origin {
    domain_name              = aws_s3_bucket.website_bucket.bucket_regional_domain_name
    origin_id                = "${var.project_name}-s3-origin"
    origin_access_control_id = aws_cloudfront_origin_access_control.website_oac.id
    # REMOVED: s3_origin_config { ... } (not needed when using OAC)
  }

  default_cache_behavior {
    target_origin_id       = "${var.project_name}-s3-origin"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]

    # FIX: Corrected attribute names and structure for forwarded_values
    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}