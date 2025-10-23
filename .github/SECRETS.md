# GitHub Actions Secrets Setup Guide

This document explains how to configure the required GitHub Secrets for automated deployment.

## Required Secrets

The following secrets must be added to your GitHub repository before the deployment workflow can run:

### 1. AWS_ACCESS_KEY_ID
- **Description**: AWS IAM user access key ID
- **How to get**: Create an IAM user in AWS Console → IAM → Users
- **Permissions needed**: S3, CloudFront access

### 2. AWS_SECRET_ACCESS_KEY
- **Description**: AWS IAM user secret access key
- **How to get**: Created when you generate the access key ID
- **Important**: Save this immediately - it's only shown once

### 3. AWS_REGION
- **Description**: AWS region for deployment
- **Value**: `us-east-1`
- **Note**: Must be us-east-1 for CloudFront/ACM compatibility

### 4. S3_BUCKET
- **Description**: Name of your S3 bucket
- **Value**: `seaoki.com` (or your domain name)
- **Note**: This is the bucket you create manually in AWS Console

### 5. CLOUDFRONT_DISTRIBUTION_ID
- **Description**: CloudFront distribution ID
- **How to get**: Copy from CloudFront Console → Distributions
- **Format**: Looks like `E1234ABCDEFGH`
- **Note**: Added after AWS infrastructure setup

## Step-by-Step Setup

### Before AWS Infrastructure Setup

1. Go to your GitHub repository
2. Click **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Add the following secrets:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
   - `AWS_REGION` = `us-east-1`
   - `S3_BUCKET` = `seaoki.com` (or your domain)

### After AWS Infrastructure Setup

1. Set up your AWS infrastructure manually through the console
2. Copy the CloudFront Distribution ID from AWS Console
3. Add the final secret:
   - `CLOUDFRONT_DISTRIBUTION_ID` = `E1234ABCDEFGH` (your actual ID)

## Security Best Practices

- **Never commit secrets** to the repository
- **Rotate credentials** regularly (every 90 days)
- **Use least privilege** IAM permissions
- **Enable MFA** on AWS account
- **Review access logs** periodically

## Verification

After adding all secrets, you can verify they're set:

1. Go to **Settings** → **Secrets and variables** → **Actions**
2. You should see 5 secrets listed (values are hidden)

## Testing

To test the workflow:

1. Make a small change to the website
2. Commit and push to the `main` branch
3. Go to **Actions** tab to watch the deployment
4. Check for any errors in the workflow logs

## Troubleshooting

### "Secrets not found" error
- Verify all 5 secrets are added
- Check for typos in secret names (case-sensitive)

### "Access Denied" error
- Verify IAM user has correct permissions
- Check that credentials are valid and not expired

### "Distribution not found" error
- Ensure `CLOUDFRONT_DISTRIBUTION_ID` is correct
- Verify CloudFront distribution exists in AWS

## Additional Resources

- [GitHub Encrypted Secrets Documentation](https://docs.github.com/en/actions/security-guides/encrypted-secrets)
- [AWS IAM Best Practices](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html)
- [AWS CLI Configuration](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html)
