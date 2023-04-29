provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

resource "aws_s3_bucket" "static_website" {
  bucket = var.bucket_name
  acl    = "public-read"

  website {
    index_document = "index.html"
  }

  tags = {
    Environment = var.environment
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.static_website.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject"
        ]
        Effect = "Allow"
        Resource = "${aws_s3_bucket.static_website.arn}/*"
        Principal = {
          AWS = "*"
        }
      }
    ]
  })
}

# Upload website files to S3 bucket
resource "aws_s3_bucket_object" "index_html" {
  bucket = aws_s3_bucket.static_website.id
  key    = "index.html"
  source = "${path.module}/website/index.html"
  etag   = filemd5("${path.module}/website/index.html")
}

resource "aws_s3_bucket_object" "style_css" {
  bucket = aws_s3_bucket.static_website.id
  key    = "style.css"
  source = "${path.module}/website/style.css"
  etag   = filemd5("${path.module}/website/style.css")
}

output "website_endpoint" {
  value = aws_s3_bucket.static_website.website_endpoint
}
