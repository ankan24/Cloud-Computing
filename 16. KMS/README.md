# AWS Key Management Service (KMS)

## Overview
AWS Key Management Service (KMS) is a managed service that makes it easy for you to create and control the encryption keys used to encrypt your data. AWS KMS uses Hardware Security Modules (HSMs) to protect the security of your keys.

## Features
- **Centralized Key Management**: Create, import, and manage cryptographic keys across AWS services and in your applications.
- **Key Rotation**: Automatically rotate customer master keys (CMKs) on a yearly basis.
- **Access Control**: Define who can use keys and under what conditions.
- **Audit Capability**: Monitor key usage with AWS CloudTrail integration.
- **Secure**: Keys never leave AWS KMS unencrypted.
- **Regional**: Keys are created and used in specific AWS regions.

## How to Create and Use KMS

### Key Creation
1. **Create a Customer Managed Key (CMK)**:
   - Navigate to AWS KMS in the AWS Console
   - Click "Create key"
   - Choose key type (Symmetric/Asymmetric)
   - Define key administrative permissions
   - Define key usage permissions
   - Review and create the key

2. **Create a Key via AWS CLI**:
   ```bash
   aws kms create-key --description "Your key description"
   ```

### Key Usage

1. **Encrypting Data**:
   ```bash
   aws kms encrypt --key-id alias/your-key-alias --plaintext fileb://path/to/file --output text --query CiphertextBlob | base64 --decode > encrypted_file.enc
   ```

2. **Decrypting Data**:
   ```bash
   aws kms decrypt --ciphertext-blob fileb://encrypted_file.enc --output text --query Plaintext | base64 --decode > decrypted_file
   ```

3. **Integration with other AWS Services**:
   - Configure AWS services like S3, RDS, EBS to use your KMS keys for encryption
   - Example for S3:
     ```bash
     aws s3api put-bucket-encryption --bucket your-bucket-name --server-side-encryption-configuration '{
       "Rules": [
         {
           "ApplyServerSideEncryptionByDefault": {
             "SSEAlgorithm": "aws:kms",
             "KMSMasterKeyID": "your-key-arn"
           }
         }
       ]
     }'
     ```

## Best Practices

1. **Key Policies**: Implement least privilege access to keys
2. **Key Rotation**: Enable automatic key rotation for CMKs
3. **Monitoring**: Monitor key usage with CloudTrail and CloudWatch
4. **Cross-Region Considerations**: Remember that KMS keys are region-specific
5. **Envelope Encryption**: Use envelope encryption for large data sets
6. **Key Aliases**: Use aliases to refer to your keys instead of key IDs

## Cost Considerations

- **Monthly Fee**: $1.00 per month for each customer managed CMK
- **API Requests**: $0.03 per 10,000 API requests
- **Key Material Import**: $1.00 for each imported key material
- **Free Tier**: AWS KMS offers a free tier for the first 20,000 API requests per month

## Common Use Cases

1. **Data Encryption**: Protect sensitive data at rest
2. **Digital Signatures**: Sign and verify code or data
3. **Secure Communication**: Protect data in transit
4. **Compliance**: Meet regulatory requirements for data protection

## Limitations

- Keys are region-specific
- Key material cannot be extracted once created
- Default quotas on number of keys and API requests per second (can be increased)
- Key policies have a size limit of 32 KB

## Related Services

- **AWS CloudHSM**: For more control over the HSMs
- **AWS Secrets Manager**: For storing and rotating secrets
- **AWS Certificate Manager**: For SSL/TLS certificates
- **Systems Manager Parameter Store**: For smaller secrets and configuration