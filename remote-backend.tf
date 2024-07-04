
## BACKEND CONFIGRUATION 
terraform {
	backend "s3" {

		bucket = "task02-remote-backend"
		key = "global/s3/terraform.tfstate"
        region = "ap-northeast-1"
		dynamodb_table = "TerraformBackendLock"
		encrypt	= true
	}
}
