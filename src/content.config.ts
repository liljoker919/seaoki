import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

const blog = defineCollection({
	// Load Markdown and MDX files in the `src/content/blog/` directory.
	loader: glob({ base: './src/content/blog', pattern: '**/*.{md,mdx}' }),
	// Type-check frontmatter using a schema
	schema: ({ image }) =>
		z.object({
			title: z.string(),
			description: z.string(),
			// Transform string to Date object
			pubDate: z.coerce.date(),
			updatedDate: z.coerce.date().optional(),
			heroImage: image().optional(),
		}),
});

const dining = defineCollection({
	// Load JSON files with restaurant data
	loader: glob({ base: './src/content/dining', pattern: '*.json' }),
	// Type-check restaurant data using a schema
	schema: z.object({
		name: z.string(),
		category: z.string(),
		description: z.string(),
		image: z.string(),
		website: z.string().url(),
		phone: z.string().optional(),
		address: z.string().optional(),
		petFriendly: z.boolean().default(false),
		priceRange: z.enum(['$', '$$', '$$$', '$$$$']).optional(),
	}),
});

export const collections = { blog, dining };
