# AWS Deployment Guide for Sea OKI Collection

This guide provides comprehensive instructions for deploying the Sea OKI Collection website to AWS using S3, CloudFront, and Route 53, with automated deployment via GitHub Actions.

## Project Overview

This project is a static website built with Astro and Bootstrap that showcases two pet-friendly vacation rental properties in Oak Island, NC. The deployment architecture uses:

- **AWS S3**: Static website file storage
- **AWS CloudFront**: Global CDN for fast content delivery and HTTPS support
- **AWS Certificate Manager (ACM)**: Free SSL/TLS certificate
- **AWS Route 53**: DNS management for custom domain
- **GitHub Actions**: Automated CI/CD pipeline

## Prerequisites

Before you begin, ensure you have:

1. **AWS Account**: [Sign up for AWS](https://aws.amazon.com/) if you don't have an account
2. **Domain Name**: A registered domain name (can be registered through Route 53 or transferred)
3. **GitHub Account**: Access to this repository with admin permissions
4. **AWS CLI Installed**: [Install AWS CLI](https://aws.amazon.com/cli/) (optional but recommended)
5. **Node.js**: Version 18+ for local development and testing

## Setup Instructions

### Step 1: Fork & Clone the Repository

1. Fork this repository to your GitHub account
2. Clone your forked repository:
   ```bash
   git clone https://github.com/YOUR-USERNAME/seaoki.git
   cd seaoki
   ```

### Step 2: Configure AWS Credentials

#### Create IAM User with Necessary Permissions

1. Log in to the [AWS Console](https://console.aws.amazon.com/)
2. Navigate to **IAM** → **Users** → **Add User**
3. Create a user named `seaoki-deployer` with **Programmatic access**
4. Attach the following AWS managed policies:
   - `AmazonS3FullAccess`
   - `CloudFrontFullAccess`
   - `AWSCertificateManagerFullAccess`
   - `AmazonRoute53FullAccess`
5. For production, consider creating a custom policy with least-privilege permissions:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "arn:aws:s3:::seaoki.com",
        "arn:aws:s3:::seaoki.com/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "cloudfront:*"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "acm:*"
      ],
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "route53:*"
      ],
      "Resource": "*"
    }
  ]
}
```

6. Save the **Access Key ID** and **Secret Access Key** securely

### Step 3: Configure GitHub Secrets

Add the following secrets to your GitHub repository:

1. Go to your repository on GitHub
2. Navigate to **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret** and add:
   - `AWS_ACCESS_KEY_ID`: Your AWS Access Key ID
   - `AWS_SECRET_ACCESS_KEY`: Your AWS Secret Access Key
   - `AWS_REGION`: `us-east-1` (required for CloudFront/ACM)
   - `S3_BUCKET`: Your S3 bucket name (e.g., `seaoki.com`)
   - `CLOUDFRONT_DISTRIBUTION_ID`: Will be added after AWS infrastructure setup

### Step 4: Configure Route 53 Domain

If your domain is already in Route 53:
1. Note your **Hosted Zone ID** for future reference

If you need to transfer or register a domain:
1. Go to **Route 53** → **Registered domains**
2. Either register a new domain or transfer an existing one
3. Wait for the domain to be active (can take up to 48 hours for transfers)
4. Note the **Hosted Zone ID** created automatically

### Step 5: Set Up AWS Infrastructure Manually

**Important**: You'll need to manually create the AWS infrastructure through the AWS Console:

1. **Create S3 Bucket**:
   - Go to S3 Console and create a bucket with your domain name (e.g., `seaoki.com`)
   - Enable static website hosting
   - Set index document to `index.html`
   - Configure bucket policy for CloudFront access

2. **Request SSL Certificate**:
   - Go to Certificate Manager in `us-east-1` region
   - Request a public certificate for your domain and `*.yourdomain.com`
   - Use DNS validation
   - Add the CNAME records to Route 53 for validation

3. **Create CloudFront Distribution**:
   - Create a new distribution with your S3 bucket as origin
   - Configure custom domain names
   - Set the SSL certificate
   - Configure caching behaviors

4. **Configure Route 53**:
   - Create A records (alias) pointing to your CloudFront distribution
   - Set up both root domain and www subdomain

5. **Get CloudFront Distribution ID**:
   - Copy the Distribution ID from the CloudFront console
   - Add it to your GitHub Secrets as `CLOUDFRONT_DISTRIBUTION_ID`

### Step 6: Verify DNS Configuration

1. After setting up the infrastructure, verify the Route 53 records:
   ```bash
   dig seaoki.com
   dig www.seaoki.com
   ```

2. Both should return the CloudFront distribution domain (e.g., `d1234abcd.cloudfront.net`)

3. **Note**: DNS propagation can take up to 48 hours, but typically completes within minutes

### Step 7: Test Automated Deployment

1. Make a small change to the website (e.g., edit `src/pages/index.astro`)
2. Commit and push to the `main` branch:
   ```bash
   git add .
   git commit -m "Test deployment"
   git push origin main
   ```

3. Go to **Actions** tab in your GitHub repository
4. Watch the deployment workflow execute
5. Once complete, visit your domain to see the changes

## AWS Infrastructure Overview

### Amazon S3 (Simple Storage Service)
- **Purpose**: Stores all static website files (HTML, CSS, JS, images)
- **Configuration**: 
  - Configured for static website hosting
  - Bucket policy allows CloudFront access via Origin Access Identity
  - Public access is blocked; all traffic goes through CloudFront
- **Cost**: ~$0.023 per GB stored + minimal transfer fees

### Amazon CloudFront
- **Purpose**: 
  - Global Content Delivery Network (CDN) for fast content delivery
  - Provides HTTPS/SSL encryption
  - Caches content at edge locations worldwide
- **Configuration**:
  - Default root object: `index.html`
  - HTTP to HTTPS redirect enabled
  - Custom SSL certificate from ACM
  - Custom domain names (seaoki.com, www.seaoki.com)
- **Cost**: Free tier includes 1 TB data transfer out per month

### AWS Certificate Manager (ACM)
- **Purpose**: Provides free SSL/TLS certificates for HTTPS
- **Configuration**:
  - Certificate for `seaoki.com` and `*.seaoki.com`
  - DNS validation (manual setup required)
  - Auto-renewal enabled
- **Cost**: Free for public certificates used with AWS services

### AWS Route 53
- **Purpose**: DNS management and domain name resolution
- **Configuration**:
  - A records (alias) for root domain → CloudFront
  - A records (alias) for www subdomain → CloudFront
  - Automatic health checks
- **Cost**: $0.50 per hosted zone per month + $0.40 per million queries

## Deployment Process

### Automated GitHub Actions Workflow

The deployment is triggered automatically on every push to the `main` branch:

1. **Checkout Code**: Retrieves the latest code from the repository
2. **Setup Node.js**: Installs Node.js 20
3. **Install Dependencies**: Runs `npm install`
4. **Build Site**: Runs `npm run build` to generate static files in `dist/`
5. **Configure AWS**: Sets up AWS credentials from GitHub Secrets
6. **Sync to S3**: Uploads all files from `dist/` to S3 bucket
7. **CloudFront Invalidation**: Clears CloudFront cache to serve fresh content

### Manual Deployment (if needed)

If you need to deploy manually:

```bash
# Build the site
npm run build

# Sync to S3 (requires AWS CLI configured)
aws s3 sync dist/ s3://seaoki.com --delete

# Create CloudFront invalidation
aws cloudfront create-invalidation \
  --distribution-id YOUR_DISTRIBUTION_ID \
  --paths "/*"
```

## Architecture Diagram

```
┌─────────────┐
│   GitHub    │
│  Repository │
└──────┬──────┘
       │ Push to main
       ↓
┌─────────────┐
│   GitHub    │
│   Actions   │
└──────┬──────┘
       │ Build & Deploy
       ↓
┌─────────────┐      ┌──────────────┐
│   AWS S3    │ ←────│  CloudFront  │
│   Bucket    │      │ Distribution │
└─────────────┘      └──────┬───────┘
                            │
                     ┌──────┴───────┐
                     │  ACM SSL/TLS │
                     │ Certificate  │
                     └──────────────┘
                            │
                     ┌──────┴───────┐
                     │   Route 53   │
                     │     DNS      │
                     └──────────────┘
                            │
                     ┌──────┴───────┐
                     │    Users     │
                     │ (seaoki.com) │
                     └──────────────┘
```

## Troubleshooting

### Issue: SSL Certificate Validation Pending

**Symptom**: SSL Certificate validation is pending

**Solution**: 
- Ensure your domain's nameservers are pointing to Route 53
- Check Route 53 hosted zone for validation CNAME records
- Manually add validation CNAME records if not automatically added
- Wait up to 30 minutes for validation to complete

### Issue: CloudFront Returns 403 Forbidden

**Symptom**: Accessing the site shows "Access Denied"

**Solution**:
- Verify S3 bucket policy allows CloudFront OAI
- Check that files were uploaded to S3
- Ensure CloudFront default root object is set to `index.html`

### Issue: Changes Not Appearing on Website

**Symptom**: Deployed updates don't show on the live site

**Solution**:
- Check if CloudFront invalidation completed in GitHub Actions
- Manually create invalidation: `aws cloudfront create-invalidation --distribution-id ID --paths "/*"`
- Wait a few minutes for cache to clear
- Hard refresh browser (Ctrl+Shift+R)

### Issue: GitHub Actions Failing

**Symptom**: Deployment workflow fails

**Solution**:
- Verify GitHub Secrets are correctly set
- Check AWS credentials have necessary permissions
- Review workflow logs in the Actions tab
- Ensure S3 bucket name matches the secret

## Cost Estimation

Based on moderate traffic (10,000 visitors/month):

| Service | Monthly Cost |
|---------|-------------|
| S3 Storage (5 GB) | ~$0.12 |
| S3 Requests | ~$0.05 |
| CloudFront (50 GB transfer) | Free tier |
| Route 53 Hosted Zone | $0.50 |
| Route 53 Queries | ~$0.04 |
| ACM Certificate | Free |
| **Total** | **~$0.71/month** |

**Note**: These are estimates. First-year costs may be higher if you registered a domain through Route 53 ($12-$15/year for .com domains).

## Security Best Practices

1. **IAM Least Privilege**: Use the minimum required permissions for the deployer user
2. **Secrets Management**: Never commit AWS credentials to the repository
3. **HTTPS Only**: CloudFront redirects all HTTP to HTTPS
4. **Origin Access Identity**: S3 bucket is not publicly accessible
5. **CloudFront Signed URLs**: Consider implementing for private content
6. **Regular Updates**: Keep dependencies updated for security patches

## Maintenance

### Updating the Site

1. Make changes to files in `src/`
2. Test locally: `npm run dev`
3. Commit and push to `main` branch
4. GitHub Actions will automatically deploy

### Monitoring

- **CloudFront Metrics**: Monitor in AWS Console → CloudFront → Monitoring
- **S3 Bucket Metrics**: Monitor in AWS Console → S3 → Metrics
- **GitHub Actions**: Review deployment history in Actions tab

### Backup

- **Regular Backups**: Consider backing up your S3 bucket content regularly
- **Infrastructure Documentation**: Keep records of your AWS resource configurations
- **GitHub Repository**: Your code is automatically backed up in GitHub

## Advanced Configuration

### Custom Error Pages

Add custom 404 page in CloudFront console:

1. Go to CloudFront → Your Distribution → Error Pages
2. Create Custom Error Response:
   - HTTP Error Code: 404
   - Response Page Path: `/404.html`
   - HTTP Response Code: 404

### Multiple Environments

For multiple environments (staging, production):

1. Create separate S3 buckets for each environment
2. Create separate CloudFront distributions
3. Use different GitHub repository secrets for each environment
4. Consider using separate GitHub repositories or branches

## Additional Resources

- [Astro Documentation](https://docs.astro.build/)
- [AWS S3 Static Website Hosting](https://docs.aws.amazon.com/AmazonS3/latest/userguide/WebsiteHosting.html)
- [CloudFront Documentation](https://docs.aws.amazon.com/cloudfront/)
- [AWS Console Documentation](https://docs.aws.amazon.com/console/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)

## Support

For issues with:
- **Deployment**: Check GitHub Actions logs and this guide's troubleshooting section
- **AWS Resources**: Review AWS CloudWatch logs and service health dashboard
- **Website Content**: Test changes locally before deploying

## License

This deployment configuration is provided as-is for use with the Sea OKI Collection website.
