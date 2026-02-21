# BackBytes

A personal blog built with [Hugo](https://gohugo.io/) v0.156.0 and the [PaperMod](https://github.com/adityatelange/hugo-PaperMod) theme, deployed on GitHub Pages.

## Quick Start

```bash
# Clone with submodules
git clone --recurse-submodules https://github.com/cuongntr/blackbytes_blog.git
cd blackbytes_blog

# Start local dev server
make serve
```

## Usage

| Command | Description |
|---|---|
| `make serve` | Start dev server with drafts at http://localhost:1313 |
| `make build` | Build production site to `public/` |
| `make new POST=my-post` | Create a new blog post |
| `make clean` | Remove generated files |
| `make update-theme` | Update PaperMod to latest version |

## Deployment

Pushes to `main` automatically trigger a GitHub Actions workflow that builds and deploys the site to GitHub Pages.

## License

Content © Cuong NT. Theme: [PaperMod](https://github.com/adityatelange/hugo-PaperMod) (MIT).
