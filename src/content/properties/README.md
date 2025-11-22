# Property Data Files

This directory contains JSON data files for each vacation rental property. Each file defines all the property-specific content used by the `PropertyDetailLayout.astro` component.

## File Structure

Each property JSON file should include:
- Basic information (name, slug, title, description)
- Property details (bedrooms, bathrooms, amenities)
- Hero section content
- Overview section content
- Photo gallery (either Houfy widget IDs or static image URLs)
- Amenities lists (indoor and outdoor)
- Bedroom descriptions
- Location information
- FAQ items
- House rules
- Important information alerts
- Call-to-action text

## Adding a New Property

1. Create a new JSON file: `{property-slug}.json`
2. Copy the structure from an existing property file
3. Update all property-specific content
4. Create the corresponding page file: `src/pages/properties/{property-slug}.astro`
5. Import and use the PropertyDetailLayout component

## Known Issues / TODOs

### Down by the Sea Property
**houfyListingId**: Currently set to placeholder "REPLACE_WITH_ACTUAL_LISTING_ID". Update this with the actual Houfy listing ID when available. The booking widget will not function properly until this is updated.

## Property Schema

See `src/layouts/PropertyDetailLayout.astro` for the TypeScript interface definition of the Property type.
