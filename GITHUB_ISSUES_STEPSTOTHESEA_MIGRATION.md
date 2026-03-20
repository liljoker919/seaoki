# StepstotheSea Astro Migration - GitHub Issue Backlog

Use each section below as a standalone GitHub issue.
Priority order is top to bottom.

---

## Issue 1

### Title

Initialize Astro project with Sea OKI branding foundation

### Description

Create the Astro baseline for stepstothesea.com using Sea OKI as the design system source. This issue is only for scaffolding and shared styling/layout setup so all later tickets can build on a consistent foundation.

### Acceptance Criteria

- Astro project builds and runs locally with `npm run dev` and `npm run build`.
- Global layout and theme styling match Sea OKI branding primitives (fonts, colors, spacing, Bootstrap usage).
- Shared header and footer are wired into the base layout and visible on a starter page.
- Site URL config points to `https://stepstothesea.com`.
- No hard-coded style overrides outside the shared design system unless required for parity.

### Files to Use (copy/adapt from Sea OKI)

- `src/layouts/Layout.astro`
- `src/styles/theme.css`
- `src/styles/global.css`
- `src/components/Navigation.astro`
- `src/components/Footer.astro`
- `astro.config.mjs`
- `src/consts.ts`

---

## Issue 2

### Title

Integrate Font Awesome icon library

### Description

Add Font Awesome to the stepstothesea.com Astro project for consistent iconography throughout the site. Font Awesome icons are used in multiple components including navigation, contact forms, value propositions, and CTAs.

**Required for:** WhyBookDirect component, PlatformLinks component, ContactForm component, and other UI elements that use icons.

### Acceptance Criteria

- Font Awesome 6.x is integrated via CDN in the base layout (same version as seaoki.com).
- Icons render correctly across all browsers.
- Icon usage follows Font Awesome best practices (semantic HTML, accessibility).
- Common icons are tested: `fa-dollar-sign`, `fa-comments`, `fa-shield-alt`, `fa-star`, `fa-home`, `fa-paper-plane`, `fa-check-circle`, `fa-exclamation-triangle`.
- Icons scale properly with responsive typography.
- No console errors related to Font Awesome loading.

### Files to Use (copy/adapt from Sea OKI)

- `src/layouts/Layout.astro` (Font Awesome CDN link in `<head>`)

### Implementation Notes

- Use Font Awesome CDN (cdnjs or official CDN)
- Include in base Layout.astro so it's available site-wide
- Version should match seaoki.com for consistency (Font Awesome 6.0.0 or later)

---

## Issue 3

### Title

Preserve existing URLs with route parity and redirect mapping

### Description

Build the complete URL preservation strategy so existing indexed pages keep ranking and users do not hit 404s. Recreate existing stepstothesea.com routes in Astro where possible, and add 301 redirects only when route changes are unavoidable.

**IMPORTANT**: This issue focuses on URL structure and redirect setup only. Content migration happens in subsequent issues.

### Acceptance Criteria

- A complete URL inventory of current production pages is documented.
- Astro route files exist for all keep-as-is URLs that should remain live.
- A redirect map is created for any URL that cannot be kept exactly.
- 301 redirects are configured and validated for every changed URL.
- No indexed legacy URL returns 404 in QA crawl.

### Files to Use (copy/adapt from Sea OKI)

- `src/pages/index.astro`
- `src/pages/about.astro`
- `src/pages/contact.astro`
- `src/pages/properties.astro`
- `src/pages/404.astro`
- `public/_headers`
- `public/robots.txt`
- `astro.config.mjs`

---

## Issue 4

### Title

Migrate homepage content into Sea OKI component architecture

### Description

Rebuild the current stepstothesea.com homepage in Astro using Sea OKI component patterns, while **preserving all existing content**, brand voice, and lead-generation CTAs. Apply Sea OKI branding and styling only—do not change the homepage content.

**Content to Preserve:**

- "Why Book Direct?" section with all four value propositions (No Service Fees, Direct Communication, Secure Booking, Best Available Price)
- "View Our Listings on Your Favorite Platform" section with links to Airbnb, VRBO, and Houfy (with Houfy marked as Recommended)
- All property information, CTAs, and conversion elements
- Any additional existing content sections

**Only Update:** Typography, colors, spacing, component structure to match Sea OKI design system.

### Acceptance Criteria

- Homepage route matches the current production URL.
- Hero, value proposition, and primary CTA are implemented with existing stepstothesea.com copy.
- "Why Book Direct?" section displays all four value propositions with original content.
- Multi-platform booking section shows Airbnb, VRBO, and Houfy links with proper labels and "Recommended" badge on Houfy.
- Property summary section and conversion CTA are visible above the fold on desktop.
- Mobile layout is responsive and readable.
- Branding and styling match Sea OKI design system (fonts, colors, spacing).
- Content remains identical to current stepstothesea.com.
- Lighthouse mobile performance score is acceptable (no obvious regressions vs current site).

### Files to Use (copy/adapt from Sea OKI)

- `src/pages/index.astro` (structure/styling only)
- `src/components/Hero.astro`
- `src/components/PropertyCard.astro`
- `src/components/Navigation.astro`
- `src/components/Footer.astro`
- `src/layouts/Layout.astro`

---

## Issue 5

### Title

Create stepstothesea.com-specific components (Why Book Direct & Platform Links)

### Description

Build reusable Astro components for stepstothesea.com-specific content sections that don't exist in Sea OKI. These components should use Sea OKI branding/styling but contain stepstothesea.com's unique conversion-focused content.

**Components to Create:**

1. **WhyBookDirect.astro** - Four-column value proposition grid
2. **PlatformLinks.astro** - Multi-platform booking card section with recommendation badge

### Acceptance Criteria

- `WhyBookDirect.astro` component displays four value propositions:
  - No Service Fees (dollar icon)
  - Direct Communication (chat icon)
  - Secure Booking (shield icon)
  - Best Available Price (star icon)
- Component is responsive and uses Bootstrap grid system.
- `PlatformLinks.astro` component displays three booking platform cards:
  - Airbnb (with icon and "View on Airbnb" CTA)
  - VRBO (with icon and "View on VRBO" CTA)
  - Houfy (with icon, "Book on Houfy" CTA, and "Recommended" badge)
- Houfy card has visual emphasis (border, badge) to indicate it's the recommended option.
- Both components accept props for customization where appropriate.
- Typography and colors match Sea OKI design system.
- Components are reusable across multiple pages.

### Files to Use (copy/adapt from Sea OKI)

- `src/components/PropertyCard.astro` (for card structure patterns)
- `src/styles/theme.css` (for brand colors and typography)
- `src/layouts/Layout.astro` (for Bootstrap usage patterns)

### New Files to Create

- `src/components/WhyBookDirect.astro`
- `src/components/PlatformLinks.astro`

---

## Issue 6

### Title

Implement contact page with lead capture form and AWS Lambda backend integration

### Description

Create a complete contact page for stepstothesea.com by copying the full implementation from seaoki.com. The current stepstothesea.com site does not have a contact page, so this will be a new addition. Include the contact form component, page layout, AWS Lambda function integration, and API Gateway endpoint exactly as implemented in seaoki.com.

**Note:** This requires:

- Full contact form with validation (name, email, phone, check-in, check-out, message)
- AWS Lambda function backend (copy from seaoki.com setup)
- API Gateway endpoint configuration
- Success/error alert handling
- Email notification delivery

### Acceptance Criteria

- Contact page is accessible at `/contact` route.
- ContactForm component is fully functional with all fields: name, email, phone (optional), check-in date, check-out date, and message.
- Client-side validation works for required fields, email format, and date logic (check-out must be after check-in).
- Form submits to AWS Lambda endpoint (same backend setup as seaoki.com).
- Successful submissions show success alert and send email notification.
- Failed submissions show error alert with fallback contact option (Facebook Messenger link).
- Form includes loading state during submission (spinner, disabled button).
- Date picker includes minimum date validation (check-in cannot be in the past).
- Form events are trackable for analytics (`form_start`, `form_submit`, `form_success`, `form_error`).
- AWS Lambda function and API Gateway endpoint are configured for stepstothesea.com domain.

### Files to Use (copy/adapt from Sea OKI)

- `src/components/ContactForm.astro` (copy entire component including script and styles)
- `src/pages/contact.astro` (copy full page layout)
- `src/layouts/Layout.astro`
- `src/styles/theme.css`

### Backend Configuration Required

- Copy AWS Lambda function from seaoki.com setup
- Update API Gateway endpoint URL for stepstothesea.com
- Configure email destination for inquiry notifications
- Set up environment variables for API endpoint

---

## Issue 7

### Title

Create property detail page(s) with content-driven data model

### Description

Build property detail page templates that match existing stepstothesea.com URL structure and content. Use a JSON-backed content model for maintainability and future expansion.

### Acceptance Criteria

- Property detail page route(s) exactly match current production URL(s) wherever required.
- Amenities, gallery, capacity, and booking/inquiry CTA are rendered from structured content.
- JSON content model supports easy updates without editing page markup.
- Internal links between homepage and property pages work correctly.

### Files to Use (copy/adapt from Sea OKI)

- `src/layouts/PropertyDetailLayout.astro`
- `src/pages/properties/steps-to-the-sea.astro`
- `src/components/PhotoGallery.astro`
- `src/components/PropertySchema.astro`
- `src/content/properties/steps-to-the-sea.json`
- `src/content/properties/down-by-the-sea.json`

---

## Issue 8

### Title

Set up blog routes and migrate + refresh blog content

### Description

Implement blog in Astro content collections while preserving existing blog URLs. Existing posts should be migrated and then updated for freshness, internal linking, and conversion alignment.

### Acceptance Criteria

- Blog index and post pages are generated with preserved slug URLs.
- Existing blog URLs resolve without 404 (or are covered by 301 redirects).
- Frontmatter schema is enforced for all posts.
- At least the agreed priority set of legacy posts are rewritten/updated.
- Each post includes a relevant CTA to inquiry or booking flow.

### Files to Use (copy/adapt from Sea OKI)

- `src/content.config.ts`
- `src/pages/blog/index.astro`
- `src/pages/blog/[...slug].astro`
- `src/layouts/BlogPost.astro`
- `src/components/ArticleSchema.astro`
- `src/content/blog/welcome-to-oak-island.md`
- `src/content/blog/pet-friendly-guide-oak-island.md`

---

## Issue 9

### Title

Implement SEO foundations (metadata, schema, sitemap, robots, RSS)

### Description

Preserve and strengthen technical SEO during migration. Ensure all indexable pages have metadata, structured data where appropriate, and crawler-friendly artifacts.

### Acceptance Criteria

- Unique title and meta description are present on all core pages.
- Canonical tags are present and correct.
- Structured data is included for property and article pages.
- `sitemap.xml` includes all intended public pages and excludes non-index pages.
- `robots.txt` and RSS feed are generated and valid.

### Files to Use (copy/adapt from Sea OKI)

- `src/layouts/Layout.astro`
- `src/components/BaseHead.astro`
- `src/components/ArticleSchema.astro`
- `src/components/PropertySchema.astro`
- `astro.config.mjs`
- `src/pages/rss.xml.js`
- `public/robots.txt`

---

## Issue 10

### Title

Add analytics and conversion event tracking for lead funnel

### Description

Integrate analytics for key lead funnel actions so marketing performance is measurable immediately at launch. Track interactions with booking platform links and direct booking CTAs.

### Acceptance Criteria

- GA4 (or chosen analytics) is integrated through environment configuration.
- Conversion events fire on form start, submission, success, and call/email click CTA actions.
- Platform link clicks are tracked (Airbnb, VRBO, Houfy) with platform name as event parameter.
- "Why Book Direct" section interactions are tracked.
- Event names and parameters are documented in a short tracking spec.
- Tracking works in staging and production builds.

### Files to Use (copy/adapt from Sea OKI)

- `src/layouts/Layout.astro`
- `src/components/ContactForm.astro`
- `src/pages/contact.astro`
- `src/pages/index.astro`

### Additional Files to Update

- `src/components/PlatformLinks.astro`
- `src/components/WhyBookDirect.astro`

---

## Issue 11

### Title

Production readiness QA: URL validation, SEO smoke test, launch checklist

### Description

Run final migration QA with emphasis on URL preservation, lead form reliability, SEO crawlability, and performance sanity checks before DNS cutover.

### Acceptance Criteria

- Full URL crawl confirms no broken internal links.
- Legacy URL validation confirms expected 200/301 outcomes.
- Lead form is tested end-to-end and notifications are verified.
- Core Web Vitals and Lighthouse checks show no critical regressions.
- Launch checklist is completed and signed off.

### Files to Use (copy/adapt from Sea OKI)

- `README.md`
- `DEPLOYMENT.md`
- `SECURITY_ENV_SETUP.md`
- `public/robots.txt`
- `astro.config.mjs`

---

## Optional Issue 12

### Title

Create content operations guide for post-launch updates

### Description

Document a simple editing workflow so non-developers can update blog posts, property content, and CTA copy after launch without breaking SEO patterns.

### Acceptance Criteria

- Guide covers blog post creation, editing existing posts, and updating property JSON content.
- Required frontmatter fields are documented with examples.
- Includes SEO checklist for content editors.
- Includes preview/build workflow for safe publishing.

### Files to Use (copy/adapt from Sea OKI)

- `README.md`
- `src/content.config.ts`
- `src/content/blog/*.md`
- `src/content/properties/*.json`

---

## Suggested Labels

- `migration`
- `astro`
- `seo`
- `lead-gen`
- `content`
- `high-priority`

## Suggested Milestones

- `M1 Foundation`
- `M2 URL + SEO Parity`
- `M3 Content + Blog Refresh`
- `M4 Launch`
