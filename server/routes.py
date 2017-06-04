import boto3

# バケット名
AWS_S3_BUCKET_NAME = 'tahiro-bucket'

s3 = boto3.resource('s3')
bucket = s3.Bucket(AWS_S3_BUCKET_NAME)

def knb():
    return bucket.get_available_subresources()
