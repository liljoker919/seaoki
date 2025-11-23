# Sea OKI Collection - Setup Guide

## Environment Variables Setup

The application requires certain environment variables to be configured for full functionality.

### Required Setup Steps

1. **Create `.env` file**
   
   Copy the example environment file:
   ```bash
   cp .env.example .env
   ```

2. **Configure Houfy Booking Widget**

   The Houfy booking widget requires an access token to function properly. Without this token, the "Check Availability" widget will not load on property pages.

   **Steps to get your Houfy Access Token:**
   - Log in to your Houfy dashboard at https://www.houfy.com/dashboard
   - Navigate to the Widgets or API section
   - Copy your Access Token
   - Update the `.env` file:
     ```
     PUBLIC_HOUFY_ACCESS_TOKEN=your_actual_token_here
     ```

3. **Configure Google Analytics** (Optional)

   If you want to track site analytics:
   - Get your Google Analytics ID from https://analytics.google.com/
   - Update the `.env` file:
     ```
     PUBLIC_GOOGLE_ANALYTICS_ID=G-XXXXXXXXXX
     ```

### Troubleshooting

#### Booking Widget Not Loading

If the "Book Your Stay" section appears empty or shows no content:

**Common Causes:**
1. **Missing `.env` file** - Make sure you've created the `.env` file as described above
2. **Invalid or missing Houfy Access Token** - Verify your token is correct and has not expired
3. **Ad blocker interference** - Some ad blockers block the Houfy widget script. Try disabling ad blockers or whitelisting your site
4. **Browser privacy settings** - Strict privacy settings may block third-party widgets

**How to Verify:**
1. Check browser console for errors (F12 → Console tab)
2. Look for failed requests to `widgets.houfy.com`
3. Verify the `data-accessToken` attribute is present in the HTML source
4. Restart the development server after changing `.env` file

### Development

After creating or modifying the `.env` file, restart the development server:

```bash
npm run dev
```

The application will automatically load the environment variables on startup.

### Production Deployment

For production deployments, set the environment variables through your hosting provider's dashboard or deployment configuration. Do not commit the `.env` file to version control.

**Vercel/Netlify:**
- Add environment variables in the project settings dashboard
- Ensure variable names start with `PUBLIC_` for client-side access

**Note:** The `.env` file is gitignored by default and should never be committed to the repository.
