# Copilot Instructions for Sea OKI Collection

## Project Overview
This is an Astro-based vacation rental website for the Sea OKI Collection - two pet-friendly beach houses in Oak Island, NC. The site features property listings, a blog, and direct booking capabilities.

## Architecture & Key Patterns

### Project Structure
- **`src/content/`**: Content collections using Astro's content system with Zod schemas
- **`src/pages/properties/`**: Individual property detail pages (steps-to-the-sea.astro, down-by-the-sea.astro)
- **`src/components/`**: Reusable Astro components, all using TypeScript interfaces for props
- **`src/layouts/`**: Base layouts with SEO optimization and Bootstrap integration

### Content Management
- Blog posts in `src/content/blog/` use frontmatter schema defined in `src/content.config.ts`
- Required frontmatter: `title`, `description`, `pubDate`, optional `updatedDate`, `heroImage`
- Content collections use glob loader pattern for Markdown/MDX files

### Design System
- **CSS Framework**: Bootstrap 5.3.3 via CDN (not npm)
- **Brand Colors**: CSS custom properties in Layout.astro with primary brand color
- **Typography**: Inter font family from Google Fonts
- **Component Props**: All components use TypeScript interfaces with proper typing

### Key Components
- **`PropertyCard.astro`**: Displays property info with bedrooms/baths/sleeps/pet-friendly status
- **`Layout.astro`**: Base layout with Bootstrap, SEO meta tags, and brand styling
- **Property pages**: Follow hero section → overview → amenities → booking pattern

## Development Workflows

### Commands
- `npm run dev` - Development server on localhost:4321
- `npm run build` - Production build with Astro
- `npm run preview` - Preview built site

### Adding Content
1. **New blog posts**: Add `.md` files to `src/content/blog/` with required frontmatter
2. **New properties**: Create new `.astro` file in `src/pages/properties/` following existing pattern
3. **Property cards**: Update `src/pages/index.astro` with new PropertyCard component

## Project-Specific Conventions

### SEO & Meta Tags
- All pages include Oak Island vacation rental keywords
- Default description set in Layout.astro props
- Property pages use descriptive titles with "Sea OKI Collection" branding

### Bootstrap Integration
- Bootstrap loaded via CDN, not bundled
- Custom brand styling extends Bootstrap classes
- Responsive grid system used throughout (col-lg-6, col-md-3, etc.)

### Image Handling
- Currently using placeholder.co for development images
- Images referenced directly in component props and markdown frontmatter
- Property images follow naming pattern based on property titles

### Navigation & Routing
- File-based routing with Astro conventions
- Property detail pages in `/properties/[property-name]` structure
- Blog uses Astro's content collections with dynamic routing

## Critical Integration Points
- **Content Schema**: Changes to blog schema require updating `src/content.config.ts`
- **Site Configuration**: Update `astro.config.mjs` for production site URL
- **Global Constants**: Site title/description stored in `src/consts.ts`
- **Bootstrap Dependencies**: JavaScript bundle loaded in Layout.astro for interactive components