variable "bucket_name" {
  description = "The name of the S3 bucket to be used"
  type        = string
  default     = "task02-remote-backend" # Update this value if necessary
}

# CREATE S3 BUCKET 
resource "aws_s3_bucket" "TerraformBackend_S3" {
  bucket = var.bucket_name
  
  # PREVENT ACCIDENTAL DELETION OF THIS S3 BUCKET, OF COURSE, IF YOU REALLY MEAN TO DELETE IT, YOU CAN JUST COMMENT THAT SETTING OUT
  #  lifecycle {
  #    prevent_destroy = true
  # }
}

# ENABLE VERSIONING SO YOU CAN SEE THE FULL REVISION HISTORY OF YOUR STATE FILES
resource "aws_s3_bucket_versioning" "versioning_enabled" {
  bucket = aws_s3_bucket.TerraformBackend_S3.id
  
  versioning_configuration {
    status = "Enabled"
  }
}

# ENABLE SERVER-SIDE ENCRYPTION BY DEFAULT
resource "aws_s3_bucket_server_side_encryption_configuration" "default" {
  bucket = aws_s3_bucket.TerraformBackend_S3.id
  
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# EXPLICITLY BLOCK ALL PUBLIC ACCESS TO THE S3 BUCKET
resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.TerraformBackend_S3.id
  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}

# BUILDING DYNAMODB TABLE 
resource "aws_dynamodb_table" "TerraformBackendLock" {
  name         = "TerraformBackendLock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  
  attribute {
    name = "LockID"
    type = "S"
  }
}
