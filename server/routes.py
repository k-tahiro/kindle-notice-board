import sys
import email

import boto3

sys.path.append('./image-to-ascii')
import converter_cli

# バケット名
AWS_S3_BUCKET_NAME = 'tahiro-bucket'

s3 = boto3.resource('s3')
bucket = s3.Bucket(AWS_S3_BUCKET_NAME)


def _download_latest_mail() -> None:
    object_summary_iterator = bucket.objects.all()

    target_object = None
    for os in object_summary_iterator:
        if target_object is None or (target_object.last_modified < os.last_modified):
            target_object = os

    bucket.download_file(target_object.key, 'tmpfile')


def _extract_attached_file():
    with open('tmpfile') as f:
        message = email.message_from_file(f)

    for part in message.walk():
        if part.get_content_maintype() == 'multipart':
            continue
        attach_fname = part.get_filename()
        if attach_fname:
            img = part.get_payload(decode=True)
            with open('image', 'wb') as f:
                f.write(img)


def _convert_aa():
    return converter_cli.run('image', custom_char='*')


def knb():
    _download_latest_mail()
    _extract_attached_file()
    return _convert_aa()
