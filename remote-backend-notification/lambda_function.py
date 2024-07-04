import json
import boto3
import os

ses_client = boto3.client('ses')

def lambda_handler(event, context):
    try:
        file_name = event['Records'][0]['s3']['object']['key']
        bucket_name = event['Records'][0]['s3']['bucket']['name']

        print("Event details: ", event)
        print("File Name: ", file_name)
        print("Bucket Name: ", bucket_name)

        subject = 'Event from ' + bucket_name
        body = "Terraform state file changed!"

        message = {
            "Subject": {"Data": subject},
            "Body": {"Html": {"Data": body}}
        }

        response = ses_client.send_email(
            Source="haithamelabd@outlook.com",
            Destination={"ToAddresses": ["haithamelabd@outlook.com"]},
            Message=message
        )

        print("The mail is sent successfully")
        return {
            'statusCode': 200,
            'body': json.dumps('Email sent successfully')
        }

    except KeyError as e:
        print(f"KeyError: {str(e)}. The event structure is not as expected: {event}")
        return {
            'statusCode': 400,
            'body': json.dumps(f"Error: {str(e)}")
        }
    except Exception as e:
        print(f"Error: {str(e)}. The event structure is not as expected: {event}")
        return {
            'statusCode': 500,
            'body': json.dumps(f"Error: {str(e)}")
        }
