import boto3
import csv

# configs 
clientid = '22855'
config_bucket_name = 'qas-dba'
file_bucket_name = 'qtest-prod-eu'
changed_id_file_name = 'tmp/clientmigration_move_s3.csv'

# read changed id file
s3_client = boto3.client('s3')
response = s3_client.get_object(Bucket=config_bucket_name, Key=changed_id_file_name)
lines = response[u'Body'].read().split()
# loop and rename
for row in csv.DictReader(lines):
    original_key = clientid+'-'+str(row["fromid"])
    new_key = clientid+'-'+str(row["id"])
    copy_source = {'Bucket': file_bucket_name,'Key': original_key}
    print 'renaming file %s' % original_key
    s3_client.copy_object(Bucket=file_bucket_name, CopySource=copy_source, Key=new_key)
    s3_client.delete_object(Bucket=file_bucket_name, Key=original_key)



