# Security: Environment Variables Setup

This document explains how to set up environment variables for the Sea OKI Collection website after moving hardcoded secrets to environment variables.

## Background

Previously, sensitive tokens were hardcoded in the source code:
- Google Analytics ID
- Houfy Access Token

These have been moved to environment variables for better security practices.

## Local Development Setup

1. Copy `.env.example` to create your local `.env` file:
   ```bash
   cp .env.example .env
   ```

2. Update `.env` with your actual values:
   ```
   PUBLIC_GOOGLE_ANALYTICS_ID=G-XXXXXXXXXX
   PUBLIC_HOUFY_ACCESS_TOKEN=your_houfy_access_token_here
   ```

3. The `.env` file is already in `.gitignore` and will not be committed to the repository.

## Production Deployment

### ⚠️ CRITICAL: Rotate Compromised Tokens

The Houfy Access Token (`rgrksxiilsbfus279551`) that was previously hardcoded in the source code is **COMPROMISED** and must be rotated immediately.

### Steps to Rotate Houfy Access Token:

1. Log in to your Houfy dashboard at https://www.houfy.com/dashboard
2. Navigate to the API/Widget settings section
3. Generate a new Access Token
4. **Immediately invalidate/revoke the old token** (`rgrksxiilsbfus279551`)
5. Update the new token in your production environment variables (see below)

### Setting Environment Variables in Production

Depending on your hosting platform, set the following environment variables:

#### Vercel
```bash
vercel env add PUBLIC_GOOGLE_ANALYTICS_ID
vercel env add PUBLIC_HOUFY_ACCESS_TOKEN
```

Or use the Vercel Dashboard:
1. Go to Project Settings → Environment Variables
2. Add `PUBLIC_GOOGLE_ANALYTICS_ID` with your Google Analytics ID
3. Add `PUBLIC_HOUFY_ACCESS_TOKEN` with your **NEW** Houfy token
4. Redeploy the application

#### Netlify
```bash
netlify env:set PUBLIC_GOOGLE_ANALYTICS_ID "G-XXXXXXXXXX"
netlify env:set PUBLIC_HOUFY_ACCESS_TOKEN "your_new_token_here"
```

Or use the Netlify Dashboard:
1. Go to Site settings → Environment variables
2. Add `PUBLIC_GOOGLE_ANALYTICS_ID` with your Google Analytics ID
3. Add `PUBLIC_HOUFY_ACCESS_TOKEN` with your **NEW** Houfy token
4. Trigger a new deploy

#### Other Platforms
Refer to your hosting platform's documentation for setting environment variables. The variables must be available at build time since Astro is a static site generator.

## Environment Variables Reference

| Variable Name | Description | Required | Example |
|--------------|-------------|----------|---------|
| `PUBLIC_GOOGLE_ANALYTICS_ID` | Google Analytics Measurement ID | Yes | `G-C9W0RLWLJX` |
| `PUBLIC_HOUFY_ACCESS_TOKEN` | Houfy Widget Access Token | Yes | `your_token_here` |

**Note:** All variables are prefixed with `PUBLIC_` because they are included in the client-side bundle by Astro.

## Verification Checklist

After setting up environment variables in production:

- [ ] New Houfy Access Token has been generated
- [ ] Old Houfy Access Token has been invalidated/revoked
- [ ] Environment variables are set in the production hosting platform
- [ ] Application has been redeployed
- [ ] Booking widgets on property pages are functioning correctly
- [ ] Google Analytics is tracking page views
- [ ] No hardcoded secrets remain in the source code

## Testing

To verify the setup locally:

1. Ensure `.env` file exists with valid values
2. Run the development server: `npm run dev`
3. Visit property pages and verify the Houfy booking widget loads
4. Check browser console for any errors
5. Verify Google Analytics is loading (check Network tab in DevTools)

## Support

If you encounter issues:
- Check that environment variables are properly formatted (no extra spaces, quotes, etc.)
- Ensure variables are available at build time
- Verify the Houfy token is valid by testing it in the Houfy widget documentation
- Check Google Analytics ID format (should start with `G-`)
