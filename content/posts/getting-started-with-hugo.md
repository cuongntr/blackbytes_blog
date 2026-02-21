---
title: "Getting Started with Hugo: Build Your Blog from Zero to Production"
date: 2026-02-22T00:00:00+07:00
draft: false
tags: ["hugo", "blog", "tutorial", "github-pages", "static-site"]
categories: ["Tutorial"]
author: "Cuong NT"
showToc: true
TocOpen: true
description: "A comprehensive, step-by-step guide to building and deploying a personal blog using Hugo v0.156.0, the PaperMod theme, and GitHub Pages."
cover:
  image: ""
  alt: "Getting Started with Hugo"
  caption: ""
  relative: false
  hidden: true
---

Hugo is one of the fastest and most popular static site generators in the world. In this guide, I'll walk you through **everything** — from installing Hugo to deploying a production-ready blog on GitHub Pages — based on the latest stack available in 2026.

## Why Hugo?

Before we dive in, here's why Hugo stands out:

- **Blazing fast** — builds thousands of pages in milliseconds
- **No runtime dependencies** — single binary, no Node.js or Ruby needed
- **Markdown-native** — write content in Markdown, Hugo handles the rest
- **Rich theme ecosystem** — 400+ themes available at [themes.gohugo.io](https://themes.gohugo.io/)
- **Built-in features** — taxonomies, menus, i18n, image processing, RSS, sitemaps, and more
- **Free hosting** — deploy to GitHub Pages, Netlify, Cloudflare Pages, etc.

## Prerequisites

Before starting, make sure you have:

- **Git** installed ([download here](https://git-scm.com/downloads))
- A **GitHub account** ([sign up here](https://github.com/signup))
- A **terminal/command line** you're comfortable with
- Basic familiarity with **Markdown** syntax

## Step 1: Install Hugo

Hugo ships as a single binary. Install the **extended** version (it includes Sass/SCSS support, which many themes need).

### macOS (Homebrew)

```bash
brew install hugo
```

### Linux (Debian/Ubuntu)

```bash
# Download the latest .deb package
HUGO_VERSION="0.156.0"
wget "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.deb"
sudo dpkg -i "hugo_extended_${HUGO_VERSION}_linux-amd64.deb"
rm "hugo_extended_${HUGO_VERSION}_linux-amd64.deb"
```

### Windows (Chocolatey)

```powershell
choco install hugo-extended
```

### Windows (Winget)

```powershell
winget install Hugo.Hugo.Extended
```

### Verify installation

```bash
hugo version
# Expected output (something like):
# hugo v0.156.0+extended darwin/arm64 ...
```

> **💡 Tip:** Always use the **extended** version. Many themes (including PaperMod) require it for Sass/SCSS processing.

## Step 2: Create a New Hugo Site

```bash
hugo new site my-blog --format yaml
cd my-blog
```

This creates the following structure:

```
my-blog/
├── archetypes/      # Content templates
│   └── default.md
├── assets/          # Files processed by Hugo Pipes
├── content/         # Your blog posts and pages
├── data/            # Data files (JSON, YAML, TOML)
├── i18n/            # Translation strings
├── layouts/         # Custom layout overrides
├── static/          # Static files (images, CSS, JS)
├── themes/          # Installed themes
└── hugo.yaml        # Site configuration
```

> **📝 Note:** We use `--format yaml` because YAML is easier to read than TOML. Hugo supports both.

## Step 3: Initialize Git and Add a Theme

We'll use **[PaperMod](https://github.com/adityatelange/hugo-PaperMod)** — the most popular Hugo theme with 13k+ GitHub stars. It's fast, clean, responsive, and feature-rich.

```bash
# Initialize git repository
git init

# Add PaperMod as a git submodule
git submodule add --depth=1 \
  https://github.com/adityatelange/hugo-PaperMod.git \
  themes/PaperMod
```

### Why a git submodule?

Using a submodule keeps the theme as a separate repo. You can update it independently:

```bash
# Update the theme to the latest version
git submodule update --remote --merge
```

## Step 4: Configure Your Site

Replace the contents of `hugo.yaml` with a proper configuration. Here's a complete, production-ready example:

```yaml
baseURL: "https://yourusername.github.io/your-repo/"
title: My Blog
paginate: 5
theme: PaperMod

enableRobotsTXT: true
buildDrafts: false
buildFuture: false
buildExpired: false

minify:
  disableXML: true
  minifyOutput: true

params:
  env: production
  title: My Blog
  description: "A personal blog about tech and software engineering."
  keywords: [Blog, Technology, Programming]
  author: Your Name
  DateFormat: "January 2, 2006"
  defaultTheme: auto        # auto switches between light/dark
  disableThemeToggle: false

  ShowReadingTime: true
  ShowShareButtons: true
  ShowPostNavLinks: true
  ShowBreadCrumbs: true
  ShowCodeCopyButtons: true
  ShowWordCount: true
  ShowRssButtonInSectionTermList: true
  UseHugoToc: true
  showtoc: true
  tocopen: false

  # Home page greeting
  homeInfoParams:
    Title: "Hi there 👋"
    Content: "Welcome to my blog"

  # Social icons displayed on the home page
  socialIcons:
    - name: github
      url: "https://github.com/yourusername"
    - name: x
      url: "https://x.com/yourusername"
    - name: linkedin
      url: "https://linkedin.com/in/yourusername"

  # Search configuration (uses Fuse.js)
  fuseOpts:
    isCaseSensitive: false
    shouldSort: true
    location: 0
    distance: 1000
    threshold: 0.4
    minMatchCharLength: 0
    limit: 10
    keys: ["title", "permalink", "summary", "content"]

# Navigation menu
menu:
  main:
    - identifier: archive
      name: Archive
      url: /archives/
      weight: 5
    - identifier: categories
      name: Categories
      url: /categories/
      weight: 10
    - identifier: tags
      name: Tags
      url: /tags/
      weight: 20
    - identifier: search
      name: Search
      url: /search/
      weight: 30

# Required for search functionality (JSON output)
outputs:
  home:
    - HTML
    - RSS
    - JSON

# Code highlighting
pygmentsUseClasses: true
markup:
  highlight:
    noClasses: false
```

### Key configuration explained

| Setting | Purpose |
|---|---|
| `baseURL` | Your site's public URL — critical for links and assets to work |
| `theme: PaperMod` | Tells Hugo which theme to use |
| `defaultTheme: auto` | Follows the user's system dark/light preference |
| `outputs.home` includes `JSON` | Enables the client-side search feature |
| `ShowCodeCopyButtons: true` | Adds a copy button to code blocks |
| `enableRobotsTXT: true` | Generates `robots.txt` for SEO |

## Step 5: Create Essential Pages

PaperMod needs a couple of special pages for Archive and Search to work.

### Archive page

Create `content/archives.md`:

```markdown
---
title: "Archive"
layout: "archives"
url: "/archives/"
summary: archives
---
```

### Search page

Create `content/search.md`:

```markdown
---
title: "Search"
layout: "search"
placeholder: "Search posts..."
summary: search
---
```

## Step 6: Write Your First Post

```bash
hugo new content posts/my-first-post.md
```

This creates a file using the archetype template. Edit `content/posts/my-first-post.md`:

```markdown
---
title: "My First Post"
date: 2026-02-22T10:00:00+07:00
draft: false
tags: ["intro", "blog"]
categories: ["General"]
author: "Your Name"
showToc: true
TocOpen: false
description: "This is my first blog post."
---

## Hello World!

This is my first post. Here's what I'll be writing about...

### Code example

Hugo makes it easy to include code with syntax highlighting:

\```python
def hello():
    print("Hello from Hugo!")
\```

### An image

Place images in `static/images/` and reference them:

![Alt text](/images/my-image.png)

### A blockquote

> Hugo is the world's fastest framework for building websites.
```

### Front matter explained

| Field | Purpose |
|---|---|
| `title` | The post title |
| `date` | Publication date (used for sorting) |
| `draft: false` | Set to `true` to hide from production builds |
| `tags` | Tags for the post (creates taxonomy pages) |
| `categories` | Categories for the post |
| `showToc` | Show table of contents for this post |
| `description` | SEO meta description |

## Step 7: Preview Locally

```bash
hugo server --buildDrafts
```

Open **http://localhost:1313/** in your browser. Hugo watches for file changes and **hot-reloads** automatically — just save and the browser refreshes instantly.

```
                  │ EN
──────────────────┼────
 Pages            │ 21
 Paginator pages  │  0
 Non-page files   │  0
 Static files     │  0
 Processed images │  0
 Aliases          │  5
 Cleaned          │  0

Built in 7 ms   ← Yes, 7 milliseconds!
```

> **💡 Tip:** Use `--buildDrafts` to preview posts with `draft: true`. Without this flag, drafts are hidden.

## Step 8: Deploy to GitHub Pages

### 8.1 — Create a GitHub repository

Go to [github.com/new](https://github.com/new) and create a new repository (public is free for GitHub Pages).

### 8.2 — Enable GitHub Pages

1. Go to your repo **Settings** → **Pages**
2. Under **Source**, select **GitHub Actions**
3. Save

### 8.3 — Create the GitHub Actions workflow

Create the file `.github/workflows/hugo.yaml`:

```yaml
name: Build and deploy

on:
  push:
    branches:
      - main
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: pages
  cancel-in-progress: false

defaults:
  run:
    shell: bash

jobs:
  build:
    runs-on: ubuntu-latest
    env:
      HUGO_VERSION: 0.156.0
    steps:
      - name: Checkout
        uses: actions/checkout@v6
        with:
          submodules: recursive
          fetch-depth: 0

      - name: Setup Pages
        id: pages
        uses: actions/configure-pages@v5

      - name: Install Hugo
        run: |
          curl -sLJO "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_linux-amd64.tar.gz"
          mkdir -p "${HOME}/.local/hugo"
          tar -C "${HOME}/.local/hugo" -xf "hugo_extended_${HUGO_VERSION}_linux-amd64.tar.gz"
          rm "hugo_extended_${HUGO_VERSION}_linux-amd64.tar.gz"
          echo "${HOME}/.local/hugo" >> "${GITHUB_PATH}"

      - name: Build the site
        run: |
          hugo build \
            --gc \
            --minify \
            --baseURL "${{ steps.pages.outputs.base_url }}/" \
            --cacheDir "${{ runner.temp }}/hugo_cache"

      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: ./public

  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

### 8.4 — Push and deploy

```bash
git add -A
git commit -m "Initial blog setup"
git branch -M main
git remote add origin git@github.com:yourusername/your-repo.git
git push -u origin main
```

Within a minute or two, your site will be live! 🎉

### 8.5 — Verify deployment

Go to your repo → **Actions** tab. You should see the workflow running. Once the green checkmark appears, your blog is live at:

```
https://yourusername.github.io/your-repo/
```

## Day-to-Day Workflow

Once everything is set up, your daily workflow is simple:

```bash
# 1. Create a new post
hugo new content posts/my-new-article.md

# 2. Write in your favorite editor (the file is in content/posts/)

# 3. Preview locally
hugo server --buildDrafts

# 4. When ready, set draft: false in the front matter

# 5. Commit and push — GitHub Actions handles the rest
git add content/posts/my-new-article.md
git commit -m "Add: my new article"
git push
```

## Useful Hugo Commands

| Command | Purpose |
|---|---|
| `hugo new content posts/slug.md` | Create a new post |
| `hugo server` | Start local dev server |
| `hugo server --buildDrafts` | Dev server including draft posts |
| `hugo build` | Build the site to `public/` |
| `hugo build --minify` | Build with minified output |
| `hugo list drafts` | List all draft posts |

## Tips and Best Practices

### 1. Organize posts with page bundles

Instead of putting images in `static/`, co-locate them with your post:

```
content/posts/my-post/
├── index.md        # The post content
├── cover.jpg       # Cover image
└── diagram.png     # Inline image
```

Reference images with relative paths:

```markdown
![Diagram](diagram.png)
```

### 2. Create a custom archetype

Create `archetypes/post.md` to set default front matter for new posts:

```yaml
---
title: "{{ replace .File.ContentBaseName "-" " " | title }}"
date: {{ .Date }}
draft: true
tags: []
categories: []
author: "Your Name"
showToc: true
TocOpen: false
description: ""
---
```

Now `hugo new content posts/my-post.md` will use this template.

### 3. Use a custom domain

If you own a domain, add a `static/CNAME` file:

```
yourdomain.com
```

Then update `baseURL` in `hugo.yaml`:

```yaml
baseURL: "https://yourdomain.com/"
```

Configure DNS with your domain provider to point to GitHub Pages. See [GitHub's custom domain docs](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site).

### 4. Add comments with Giscus

[Giscus](https://giscus.app/) uses GitHub Discussions for comments — free and ad-free. PaperMod has built-in support. Add to `hugo.yaml`:

```yaml
params:
  comments: true
```

Then create `layouts/partials/comments.html`:

```html
<script src="https://giscus.app/client.js"
        data-repo="yourusername/your-repo"
        data-repo-id="YOUR_REPO_ID"
        data-category="Comments"
        data-category-id="YOUR_CATEGORY_ID"
        data-mapping="pathname"
        data-strict="0"
        data-reactions-enabled="1"
        data-emit-metadata="0"
        data-input-position="bottom"
        data-theme="preferred_color_scheme"
        data-lang="en"
        crossorigin="anonymous"
        async>
</script>
```

### 5. Analytics (privacy-friendly)

Instead of Google Analytics, consider [Umami](https://umami.is/) or [Plausible](https://plausible.io/) — both are lightweight and privacy-friendly.

## Summary

Here's what we covered:

| Step | What we did |
|---|---|
| 1 | Installed Hugo v0.156.0 (extended) |
| 2 | Created a new Hugo site |
| 3 | Added PaperMod theme via git submodule |
| 4 | Configured the site (`hugo.yaml`) |
| 5 | Created Archive and Search pages |
| 6 | Wrote a first blog post |
| 7 | Previewed locally with `hugo server` |
| 8 | Deployed to GitHub Pages via GitHub Actions |

The entire stack is **free**, **fast**, and **maintenance-free**. Hugo generates pure static HTML — no databases, no servers, no security patches. Just write Markdown and push.

Happy blogging! 🚀

---

*Found this helpful? Check out the [Hugo documentation](https://gohugo.io/documentation/) and the [PaperMod wiki](https://github.com/adityatelange/hugo-PaperMod/wiki) for more advanced features.*
