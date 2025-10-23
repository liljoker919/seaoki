# Sea OKI Collection - Vacation Rentals Website

Welcome to the Sea OKI Collection website repository! This is an Astro-based static website for two pet-friendly beach houses in Oak Island, NC, featuring property listings, a blog, and direct booking capabilities.

## Features

- ✅ Modern Astro-based static site
- ✅ Bootstrap 5.3 styling
- ✅ SEO-friendly with canonical URLs and OpenGraph data
- ✅ Sitemap and RSS feed support
- ✅ Blog with Markdown & MDX support
- ✅ Property showcase pages
- ✅ Automated AWS deployment with CloudFront CDN
- ✅ HTTPS/SSL with custom domain support

## Quick Start (Local Development)

### Prerequisites
- Node.js 18+ installed
- npm or pnpm package manager

### Installation

```sh
# Clone the repository
git clone https://github.com/liljoker919/seaoki.git
cd seaoki

# Install dependencies
npm install

# Start development server
npm run dev
```

The site will be available at `http://localhost:4321`

## 🚀 Project Structure

Inside of your Astro project, you'll see the following folders and files:

```text
├── public/
├── src/
│   ├── components/
│   ├── content/
│   ├── layouts/
│   └── pages/

├── .github/
│   └── workflows/      # GitHub Actions for deployment
├── astro.config.mjs
├── DEPLOYMENT.md       # Complete AWS deployment guide
├── README.md
├── package.json
└── tsconfig.json
```

Astro looks for `.astro` or `.md` files in the `src/pages/` directory. Each page is exposed as a route based on its file name.

There's nothing special about `src/components/`, but that's where we like to put any Astro/React/Vue/Svelte/Preact components.

The `src/content/` directory contains "collections" of related Markdown and MDX documents. Use `getCollection()` to retrieve posts from `src/content/blog/`, and type-check your frontmatter using an optional schema. See [Astro's Content Collections docs](https://docs.astro.build/en/guides/content-collections/) to learn more.

Any static assets, like images, can be placed in the `public/` directory.

## 🧞 Commands

All commands are run from the root of the project, from a terminal:

| Command                   | Action                                           |
| :------------------------ | :----------------------------------------------- |
| `npm install`             | Installs dependencies                            |
| `npm run dev`             | Starts local dev server at `localhost:4321`      |
| `npm run build`           | Build your production site to `./dist/`          |
| `npm run preview`         | Preview your build locally, before deploying     |
| `npm run astro ...`       | Run CLI commands like `astro add`, `astro check` |
| `npm run astro -- --help` | Get help using the Astro CLI                     |

## 🚀 AWS Deployment

This project includes complete AWS deployment infrastructure using:
- **AWS S3**: Static website hosting
- **AWS CloudFront**: Global CDN with HTTPS
- **AWS Certificate Manager**: Free SSL/TLS certificates
- **AWS Route 53**: DNS management
- **GitHub Actions**: Automated CI/CD

### Deployment Setup

For complete deployment instructions, see **[DEPLOYMENT.md](./DEPLOYMENT.md)**

Quick overview:
1. Set up AWS credentials and GitHub secrets
2. Configure your domain in Route 53
3. Manually set up AWS infrastructure (S3, CloudFront, ACM, Route 53)
4. Push to main branch for automated deployment

```bash
# Automatic deployment happens on push to main
git push origin main
```

## 📁 Project Documentation

- **[DEPLOYMENT.md](./DEPLOYMENT.md)** - Complete AWS deployment guide
- **[.github/SECRETS.md](./.github/SECRETS.md)** - GitHub Actions secrets setup

## 🌐 Live Website

Once deployed, the website will be available at:
- Production: https://seaoki.com
- www subdomain: https://www.seaoki.com

## 👀 Want to learn more?

- [Astro Documentation](https://docs.astro.build)
- [Bootstrap Documentation](https://getbootstrap.com/docs/5.3/)
- [AWS Console Documentation](https://docs.aws.amazon.com/console/)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)

## Credit

This theme is based off of the lovely [Bear Blog](https://github.com/HermanMartinus/bearblog/).
