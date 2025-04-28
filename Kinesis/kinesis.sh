#!/bin/bash

# AWS Kinesis CLI Commands

# Configure AWS CLI (if not already configured)
aws configure

# KINESIS DATA STREAMS COMMANDS

# Create a Kinesis Data Stream
aws kinesis create-stream --stream-name my-stream --shard-count 1

# List streams
aws kinesis list-streams

# Describe a stream
aws kinesis describe-stream --stream-name my-stream

# Get shard iterator (for reading data)
aws kinesis get-shard-iterator \
  --stream-name my-stream \
  --shard-id shardId-000000000000 \
  --shard-iterator-type TRIM_HORIZON

# Put a record into the stream
aws kinesis put-record \
  --stream-name my-stream \
  --partition-key user1 \
  --data "Hello, Kinesis!" \
  --cli-binary-format raw-in-base64-out

# Put multiple records into the stream
aws kinesis put-records \
  --stream-name my-stream \
  --records '[{"Data":"SGVsbG8sIEtpbmVzaXMhCg==","PartitionKey":"user1"},{"Data":"SGVsbG8sIEFXUyE=","PartitionKey":"user2"}]'

# Get records using shard iterator
aws kinesis get-records --shard-iterator <shard-iterator-value>

# Update shard count (scaling)
aws kinesis update-shard-count \
  --stream-name my-stream \
  --target-shard-count 2 \
  --scaling-type UNIFORM_SCALING

# Enable enhanced monitoring
aws kinesis enable-enhanced-monitoring \
  --stream-name my-stream \
  --shard-level-metrics ALL

# Disable enhanced monitoring
aws kinesis disable-enhanced-monitoring \
  --stream-name my-stream \
  --shard-level-metrics ALL

# Delete a stream
aws kinesis delete-stream --stream-name my-stream

# KINESIS DATA FIREHOSE COMMANDS

# Create a Kinesis Firehose delivery stream to S3
aws firehose create-delivery-stream \
  --delivery-stream-name my-delivery-stream \
  --delivery-stream-type DirectPut \
  --s3-destination-configuration \
  "RoleARN=arn:aws:iam::123456789012:role/firehose-role,BucketARN=arn:aws:s3:::my-bucket,Prefix=firehose/,BufferingHints={SizeInMBs=5,IntervalInSeconds=300},CompressionFormat=UNCOMPRESSED"

# List delivery streams
aws firehose list-delivery-streams

# Describe a delivery stream
aws firehose describe-delivery-stream --delivery-stream-name my-delivery-stream

# Put a record into a delivery stream
aws firehose put-record \
  --delivery-stream-name my-delivery-stream \
  --record '{"Data":"SGVsbG8sIEZpcmVob3NlIQ=="}'

# Put multiple records into a delivery stream
aws firehose put-record-batch \
  --delivery-stream-name my-delivery-stream \
  --records '[{"Data":"SGVsbG8sIEZpcmVob3NlIQ=="},{"Data":"SGVsbG8sIEFXUyE="}]'

# Update a delivery stream
aws firehose update-destination \
  --delivery-stream-name my-delivery-stream \
  --current-delivery-stream-version-id 1 \
  --destination-id destinationId-000000000001 \
  --s3-destination-update '{"RoleARN":"arn:aws:iam::123456789012:role/firehose-role","BucketARN":"arn:aws:s3:::my-bucket","Prefix":"firehose/updated/","BufferingHints":{"SizeInMBs":10,"IntervalInSeconds":600}}'

# Delete a delivery stream
aws firehose delete-delivery-stream --delivery-stream-name my-delivery-stream

# KINESIS DATA ANALYTICS COMMANDS

# Create a Kinesis Analytics application
aws kinesisanalytics create-application \
  --application-name my-analytics-app \
  --application-description "My Kinesis Analytics Application" \
  --runtime-environment SQL-1_0 \
  --inputs '[{"NamePrefix":"SOURCE_SQL_STREAM","KinesisStreamsInput":{"ResourceARN":"arn:aws:kinesis:us-east-1:123456789012:stream/my-stream","RoleARN":"arn:aws:iam::123456789012:role/kinesis-analytics-role"},"InputSchema":{"RecordFormat":{"RecordFormatType":"JSON","MappingParameters":{"JSONMappingParameters":{"RecordRowPath":"$"}}},"RecordEncoding":"UTF-8","RecordColumns":[{"Name":"timestamp","SqlType":"TIMESTAMP","Mapping":"$.timestamp"},{"Name":"value","SqlType":"DOUBLE","Mapping":"$.value"}]}}]'

# List analytics applications
aws kinesisanalytics list-applications

# Describe an analytics application
aws kinesisanalytics describe-application --application-name my-analytics-app

# Add application output
aws kinesisanalytics add-application-output \
  --application-name my-analytics-app \
  --current-application-version-id 1 \
  --output '{"Name":"DESTINATION_SQL_STREAM","KinesisStreamsOutput":{"ResourceARN":"arn:aws:kinesis:us-east-1:123456789012:stream/output-stream","RoleARN":"arn:aws:iam::123456789012:role/kinesis-analytics-role"},"DestinationSchema":{"RecordFormatType":"JSON"}}'

# Start an analytics application
aws kinesisanalytics start-application \
  --application-name my-analytics-app \
  --input-configurations '[{"Id":"1.1","InputStartingPositionConfiguration":{"InputStartingPosition":"NOW"}}]'

# Stop an analytics application
aws kinesisanalytics stop-application \
  --application-name my-analytics-app

# Delete an analytics application
aws kinesisanalytics delete-application \
  --application-name my-analytics-app \
  --current-application-version-id 1

# KINESIS VIDEO STREAMS COMMANDS

# Create a Kinesis Video Stream
aws kinesisvideo create-stream \
  --stream-name my-video-stream \
  --data-retention-in-hours 24 \
  --media-type video/h264

# List video streams
aws kinesisvideo list-streams

# Describe a video stream
aws kinesisvideo describe-stream --stream-name my-video-stream

# Get data endpoint for a video stream
aws kinesisvideo get-data-endpoint \
  --stream-name my-video-stream \
  --api-name PUT_MEDIA

# Delete a video stream
aws kinesisvideo delete-stream --stream-name my-video-stream