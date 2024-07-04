# CREATE LAMBDA EXECUTION ROLE 
resource "aws_iam_role" "lambda_execution_role_2" {
  name = "lambda_execution_role_2"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# IAM POLICY FOR LAMBDA TO ACCESS THE SPECIFIED S3 BUCKET AND SES WITH FULL ACCESS# CREATE LAMBDA POLICY FOR S3 
resource "aws_iam_policy" "lambda_policy_2" {
  name        = "lambda_policy_2"
  description = "IAM policy for Lambda to access the specified S3 bucket and SES with full access"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action   = "s3:*",
        Effect   = "Allow",
        Resource = [
          "arn:aws:s3:::${var.bucket_name}",        # THE BUCKET ITSELF
          "arn:aws:s3:::${var.bucket_name}/*"       # ALL OBJECTS IN THE BUCKET
        ]
      },
      {
        Action   = "ses:*",
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

# DEFINE AN IAM ROLE FOR LAMBDA EXECUTION
resource "aws_iam_role_policy_attachment" "lambda_policy_2_attachment" {
  role       = aws_iam_role.lambda_execution_role_2.name
  policy_arn = aws_iam_policy.lambda_policy_2.arn
}

# CREATE A LAMBDA FUNCTION TRIGGERED BY S3 EVENTS

resource "aws_lambda_function" "s3_trigger" {
  filename         = "lambda_function.zip"
  function_name    = "s3_trigger"
  role             = aws_iam_role.lambda_execution_role_2.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.9"
}
# ALLOW S3 TO INVOKE THE LAMBDA FUNCTION
resource "aws_lambda_permission" "allow_s3" {
  statement_id  = "AllowS3Invoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.s3_trigger.function_name
  principal     = "s3.amazonaws.com"
  source_arn    =aws_s3_bucket.TerraformBackend_S3.arn
}

# CONFIGURE S3 BUCKET NOTIFICATIONS TO TRIGGER THE LAMBDA FUNCTION
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.TerraformBackend_S3.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.s3_trigger.arn
    events              = ["s3:ObjectCreated:*"]
  }
}
