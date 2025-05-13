#!/bin/bash
# AWS KMS (Key Management Service) Commands Reference
# This script contains example commands for working with AWS KMS

# Set variables
KEY_DESCRIPTION="My KMS Key"
KEY_ALIAS="alias/my-kms-key"
REGION="us-east-1"
FILE_TO_ENCRYPT="sensitive_data.txt"
ENCRYPTED_FILE="encrypted_data.bin"
DECRYPTED_FILE="decrypted_data.txt"

echo "AWS KMS Command Reference"
echo "========================="

# Display current KMS keys
echo -e "\n[1] Listing existing KMS keys:"
aws kms list-keys --region $REGION

# Create a new symmetric KMS key
echo -e "\n[2] Creating a new symmetric KMS key:"
KEY_ID=$(aws kms create-key \
  --description "$KEY_DESCRIPTION" \
  --region $REGION \
  --output json \
  --query 'KeyMetadata.KeyId' \
  --output text)

echo "Created key with ID: $KEY_ID"

# Create an alias for the key
echo -e "\n[3] Creating an alias for the key:"
aws kms create-alias \
  --alias-name $KEY_ALIAS \
  --target-key-id $KEY_ID \
  --region $REGION

# Get key information
echo -e "\n[4] Getting key information:"
aws kms describe-key \
  --key-id $KEY_ID \
  --region $REGION

# Create a key policy
echo -e "\n[5] Getting current key policy:"
aws kms get-key-policy \
  --key-id $KEY_ID \
  --policy-name default \
  --region $REGION \
  --output text > key_policy.json

echo "Key policy saved to key_policy.json"

# Enable key rotation
echo -e "\n[6] Enabling automatic key rotation (annual):"
aws kms enable-key-rotation \
  --key-id $KEY_ID \
  --region $REGION

# Check rotation status
echo -e "\n[7] Checking key rotation status:"
aws kms get-key-rotation-status \
  --key-id $KEY_ID \
  --region $REGION

# Encrypt a file
echo -e "\n[8] Encrypting a file:"
echo "This is sensitive data" > $FILE_TO_ENCRYPT
aws kms encrypt \
  --key-id $KEY_ID \
  --plaintext fileb://$FILE_TO_ENCRYPT \
  --output text \
  --query CiphertextBlob \
  --region $REGION | base64 --decode > $ENCRYPTED_FILE

echo "File encrypted and saved as $ENCRYPTED_FILE"

# Generate a data key
echo -e "\n[9] Generating a data key for envelope encryption:"
aws kms generate-data-key \
  --key-id $KEY_ID \
  --key-spec AES_256 \
  --region $REGION

# Decrypt the file
echo -e "\n[10] Decrypting a file:"
aws kms decrypt \
  --ciphertext-blob fileb://$ENCRYPTED_FILE \
  --output text \
  --query Plaintext \
  --region $REGION | base64 --decode > $DECRYPTED_FILE

echo "File decrypted and saved as $DECRYPTED_FILE"

# Create a grant for the key
echo -e "\n[11] Creating a grant for temporary permissions:"
aws kms create-grant \
  --key-id $KEY_ID \
  --grantee-principal arn:aws:iam::123456789012:role/ApplicationRole \
  --operations Decrypt Encrypt \
  --region $REGION

# List grants for the key
echo -e "\n[12] Listing grants for the key:"
aws kms list-grants \
  --key-id $KEY_ID \
  --region $REGION

# Create an asymmetric key for encryption/decryption
echo -e "\n[13] Creating an asymmetric key for encryption/decryption:"
ASYMMETRIC_KEY_ID=$(aws kms create-key \
  --description "Asymmetric Encryption Key" \
  --key-spec RSA_2048 \
  --key-usage ENCRYPT_DECRYPT \
  --region $REGION \
  --output json \
  --query 'KeyMetadata.KeyId' \
  --output text)

echo "Created asymmetric key with ID: $ASYMMETRIC_KEY_ID"

# Get the public key
echo -e "\n[14] Getting the public key for the asymmetric key:"
aws kms get-public-key \
  --key-id $ASYMMETRIC_KEY_ID \
  --region $REGION \
  --output text \
  --query 'PublicKey' | base64 --decode > public_key.der

echo "Public key saved as public_key.der"

# Create a signing key
echo -e "\n[15] Creating an asymmetric key for signing:"
SIGNING_KEY_ID=$(aws kms create-key \
  --description "Signing Key" \
  --key-spec RSA_2048 \
  --key-usage SIGN_VERIFY \
  --region $REGION \
  --output json \
  --query 'KeyMetadata.KeyId' \
  --output text)

echo "Created signing key with ID: $SIGNING_KEY_ID"

# Import key material (requires additional setup - this is just a template)
echo -e "\n[16] Importing key material (template - requires additional setup):"
echo "# aws kms get-parameters-for-import --key-id KEY_ID --wrapping-algorithm RSAES_OAEP_SHA_1 --wrapping-key-spec RSA_2048"
echo "# aws kms import-key-material --key-id KEY_ID --encrypted-key-material fileb://EncryptedKeyMaterial.bin --import-token fileb://ImportToken.bin --expiration-model KEY_MATERIAL_DOES_NOT_EXPIRE"

# Schedule key deletion (30 day minimum waiting period)
echo -e "\n[17] Scheduling key deletion (example only - commented out):"
echo "# aws kms schedule-key-deletion --key-id KEY_ID --pending-window-in-days 30"

# Tag a key
echo -e "\n[18] Adding tags to a key:"
aws kms tag-resource \
  --key-id $KEY_ID \
  --tags TagKey=Environment,TagValue=Production \
  --region $REGION

# List tags for a key
echo -e "\n[19] Listing tags for a key:"
aws kms list-resource-tags \
  --key-id $KEY_ID \
  --region $REGION

# Create a multi-Region primary key 
echo -e "\n[20] Creating a multi-Region primary key:"
MULTI_REGION_KEY_ID=$(aws kms create-key \
  --description "Multi-Region Primary Key" \
  --multi-region \
  --region $REGION \
  --output json \
  --query 'KeyMetadata.KeyId' \
  --output text)

echo "Created multi-region key with ID: $MULTI_REGION_KEY_ID"

# Replicate a multi-Region key to another region
echo -e "\n[21] Replicating multi-Region key to another region (example):"
echo "# aws kms replicate-key --key-id $MULTI_REGION_KEY_ID --replica-region us-west-2"

# Setting up key policy for S3 bucket encryption
echo -e "\n[22] Example: Configuring S3 bucket to use KMS key:"
echo "# aws s3api put-bucket-encryption \\"
echo "#   --bucket my-secure-bucket \\"
echo "#   --server-side-encryption-configuration '{\"Rules\": [{\"ApplyServerSideEncryptionByDefault\": {\"SSEAlgorithm\": \"aws:kms\", \"KMSMasterKeyID\": \"$KEY_ID\"}}]}'"

# Clean up (commented out for safety)
echo -e "\n[23] Clean up (commented out for safety):"
echo "# aws kms disable-key --key-id $KEY_ID --region $REGION"
echo "# aws kms schedule-key-deletion --key-id $KEY_ID --pending-window-in-days 30 --region $REGION"
echo "# aws kms delete-alias --alias-name $KEY_ALIAS --region $REGION"

echo -e "\nScript execution complete!"