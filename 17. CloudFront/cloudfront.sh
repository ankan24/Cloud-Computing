#!/bin/bash

# AWS CloudFront CLI Commands

# Configure AWS CLI (if not already configured)
aws configure

# DISTRIBUTION MANAGEMENT

# Create a CloudFront distribution with an S3 origin
aws cloudfront create-distribution \
  --origin-domain-name mybucket.s3.amazonaws.com \
  --default-root-object index.html

# Create a distribution with detailed configuration (using JSON file)
# First, create a configuration file named distribution-config.json
cat > distribution-config.json << 'EOF'
{
  "CallerReference": "cli-example-1",
  "Aliases": {
    "Quantity": 1,
    "Items": ["example.com"]
  },
  "DefaultRootObject": "index.html",
  "Origins": {
    "Quantity": 1,
    "Items": [
      {
        "Id": "my-origin",
        "DomainName": "mybucket.s3.amazonaws.com",
        "S3OriginConfig": {
          "OriginAccessIdentity": "origin-access-identity/cloudfront/EXXXXXXXXXXXXX"
        }
      }
    ]
  },
  "DefaultCacheBehavior": {
    "TargetOriginId": "my-origin",
    "ViewerProtocolPolicy": "redirect-to-https",
    "AllowedMethods": {
      "Quantity": 2,
      "Items": ["GET", "HEAD"],
      "CachedMethods": {
        "Quantity": 2,
        "Items": ["GET", "HEAD"]
      }
    },
    "ForwardedValues": {
      "QueryString": false,
      "Cookies": {
        "Forward": "none"
      }
    },
    "MinTTL": 0,
    "DefaultTTL": 86400,
    "MaxTTL": 31536000,
    "Compress": true
  },
  "PriceClass": "PriceClass_100",
  "Enabled": true,
  "ViewerCertificate": {
    "CloudFrontDefaultCertificate": true
  }
}
EOF

aws cloudfront create-distribution --distribution-config file://distribution-config.json

# List distributions
aws cloudfront list-distributions

# Get distribution details
aws cloudfront get-distribution --id EXXXXXXXXXXXXX

# Get distribution configuration
aws cloudfront get-distribution-config --id EXXXXXXXXXXXXX

# Update a distribution (first get the config and ETag, then update)
aws cloudfront get-distribution-config --id EXXXXXXXXXXXXX --output json > config.json
# Edit config.json to update settings and remove ETag from the file structure (save it separately)
# Then update the distribution using the modified config and saved ETag
aws cloudfront update-distribution --id EXXXXXXXXXXXXX --distribution-config file://modified-config.json --if-match ETAG_VALUE

# Enable/Disable a distribution
# (requires getting config, modifying the Enabled property, and updating)
aws cloudfront get-distribution-config --id EXXXXXXXXXXXXX --output json > config.json
# Edit config.json and set "Enabled": true or "Enabled": false
aws cloudfront update-distribution --id EXXXXXXXXXXXXX --distribution-config file://modified-config.json --if-match ETAG_VALUE

# Delete a distribution (must be disabled first)
aws cloudfront delete-distribution --id EXXXXXXXXXXXXX --if-match ETAG_VALUE

# ORIGIN ACCESS IDENTITY (OAI)

# Create an Origin Access Identity
aws cloudfront create-cloud-front-origin-access-identity \
  --cloud-front-origin-access-identity-config \
  '{"CallerReference": "cli-example-oai", "Comment": "OAI for CloudFront"}'

# List Origin Access Identities
aws cloudfront list-cloud-front-origin-access-identities

# Get Origin Access Identity details
aws cloudfront get-cloud-front-origin-access-identity --id EXXXXXXXXXXXXX

# Delete an Origin Access Identity
aws cloudfront delete-cloud-front-origin-access-identity --id EXXXXXXXXXXXXX --if-match ETAG_VALUE

# CACHE INVALIDATION

# Create an invalidation
aws cloudfront create-invalidation \
  --distribution-id EXXXXXXXXXXXXX \
  --paths "/images/*" "/index.html"

# Create an invalidation using JSON file
cat > invalidation.json << 'EOF'
{
  "Paths": {
    "Quantity": 3,
    "Items": [
      "/images/*",
      "/css/*",
      "/index.html"
    ]
  },
  "CallerReference": "cli-invalidation-1"
}
EOF

aws cloudfront create-invalidation \
  --distribution-id EXXXXXXXXXXXXX \
  --invalidation-batch file://invalidation.json

# List invalidations
aws cloudfront list-invalidations --distribution-id EXXXXXXXXXXXXX

# Get invalidation details
aws cloudfront get-invalidation \
  --distribution-id EXXXXXXXXXXXXX \
  --id IXXXXXXXXXXXXX

# FIELD-LEVEL ENCRYPTION

# Create a field-level encryption profile
aws cloudfront create-field-level-encryption-profile \
  --field-level-encryption-profile-config '{"Name":"EncryptProfile1","CallerReference":"cli-example-1","EncryptionEntities":{"Quantity":1,"Items":[{"PublicKeyId":"KXXXXXXXXXXXXX","ProviderId":"KeyProvider1","FieldPatterns":{"Quantity":1,"Items":["CreditCardNumber"]}}]}}'

# List field-level encryption profiles
aws cloudfront list-field-level-encryption-profiles

# Create a field-level encryption configuration
aws cloudfront create-field-level-encryption-config \
  --field-level-encryption-config '{"CallerReference":"cli-example-1","Comment":"Encrypt sensitive fields","QueryArgProfileConfig":{"ForwardWhenQueryArgProfileIsUnknown":false,"QueryArgProfiles":{"Quantity":1,"Items":[{"QueryArg":"cc","ProfileId":"PXXXXXXXXXXXXX"}]}},"ContentTypeProfileConfig":{"ForwardWhenContentTypeIsUnknown":false,"ContentTypeProfiles":{"Quantity":1,"Items":[{"Format":"URLEncoded","ProfileId":"PXXXXXXXXXXXXX","ContentType":"application/x-www-form-urlencoded"}]}}}'

# SIGNING URLs AND COOKIES

# Generate a CloudFront key pair (must be done in AWS Console)
# After downloading the private key, you can use it to sign URLs or cookies

# Example of signing a URL using a script (conceptual, requires additional implementation)
# This would typically be implemented in your application code
cat > sign-url.sh << 'EOF'
#!/bin/bash
# This is a conceptual example and would need proper implementation
# Key pair ID from AWS
KEY_PAIR_ID="KXXXXXXXXXXXXX"
# Path to the private key file downloaded from AWS
PRIVATE_KEY_PATH="./private_key.pem"
# URL to sign
RESOURCE="https://dxxxxxxxxxxxxx.cloudfront.net/protected-content.mp4"
# Expiration time (one hour from now)
EXPIRATION=$(($(date +%s) + 3600))

# This is where you would implement the actual signing logic
# For actual implementation, use AWS SDKs which provide this functionality
echo "Signed URL would be generated here in a real implementation"
EOF

# MONITORING AND LOGGING

# Enable real-time logs
aws cloudfront create-realtime-log-config \
  --end-points '[{"StreamType":"Kinesis","KinesisStreamConfig":{"RoleARN":"arn:aws:iam::123456789012:role/CloudFront-Kinesis","StreamARN":"arn:aws:kinesis:us-east-1:123456789012:stream/cf-realtime-logs"}}]' \
  --fields '["timestamp","c-ip","time-to-first-byte","sc-status","sc-bytes","cs-method","cs-uri-stem"]' \
  --name "MyRealtimeLogs" \
  --sampling-rate 100

# List real-time log configurations
aws cloudfront list-realtime-log-configs

# TAG MANAGEMENT

# Add tags to a distribution
aws cloudfront tag-resource \
  --resource arn:aws:cloudfront::123456789012:distribution/EXXXXXXXXXXXXX \
  --tags 'Items=[{Key=Environment,Value=Production},{Key=Project,Value=Website}]'

# List tags for a resource
aws cloudfront list-tags-for-resource \
  --resource arn:aws:cloudfront::123456789012:distribution/EXXXXXXXXXXXXX

# Remove tags from a resource
aws cloudfront untag-resource \
  --resource arn:aws:cloudfront::123456789012:distribution/EXXXXXXXXXXXXX \
  --tag-keys '["Environment"]'

# PUBLIC KEYS (for field-level encryption or signed URLs/cookies)

# Create a public key
aws cloudfront create-public-key \
  --public-key-config '{"CallerReference": "cli-example-1", "Name": "MyPublicKey", "EncodedKey": "-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxPL28fmPxHy6PqoVR...rest-of-key...IDAQAB\n-----END PUBLIC KEY-----"}'

# List public keys
aws cloudfront list-public-keys

# Get public key details
aws cloudfront get-public-key --id KXXXXXXXXXXXXX

# Delete a public key
aws cloudfront delete-public-key --id KXXXXXXXXXXXXX --if-match ETAG_VALUE

# FUNCTIONS (Lambda@Edge)

# Note: Lambda@Edge functions are created and managed through AWS Lambda CLI commands
# and then associated with CloudFront distributions.

# Example of creating a Lambda@Edge function
aws lambda create-function \
  --function-name edge-function \
  --runtime nodejs18.x \
  --role arn:aws:iam::123456789012:role/lambda-edge-role \
  --handler index.handler \
  --zip-file fileb://function.zip

# Publish a version (required for Lambda@Edge)
aws lambda publish-version \
  --function-name edge-function

# Associate Lambda@Edge function with a CloudFront behavior (in distribution config)
# This would be done when creating or updating a distribution