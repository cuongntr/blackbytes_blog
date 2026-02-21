.PHONY: serve build new clean update-theme

# Start local dev server with drafts
serve:
	hugo server --buildDrafts

# Build production site
build:
	hugo build --gc --minify

# Create a new post: make new POST=my-new-post
new:
	hugo new content posts/$(POST).md

# Remove generated files
clean:
	rm -rf public resources/_gen

# Update PaperMod theme to latest
update-theme:
	git submodule update --remote --merge
