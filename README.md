# repo — Sileo APT Repository

A minimal, personal APT repository for Sileo. This repository contains real package files you add; it does not generate or invent `.deb` downloads.

## Add to Sileo

After GitHub Pages is enabled and the site is published, add this source in Sileo:

`https://beans-jusfine.github.io/repo/`

Use the trailing slash. GitHub Pages must be enabled for the URL to work.

## Repository layout

- `index.html` — minimal repository landing page
- `Packages` and `Packages.gz` — APT package indexes
- `Release` — repository release metadata and checksums
- `debs/` — real `.deb` packages
- `scripts/build-repo.sh` — generates package and release metadata
- `.github/workflows/update-apt.yml` — automatically rebuilds metadata when packages change

## Publish on GitHub Pages

Open **Settings → Pages** and choose **Deploy from a branch**, branch `main`, folder `/(root)`. Save and wait for the deployment to complete.

## Package metadata updates

When a `.deb` is added to `debs/`, GitHub Actions installs the Debian package tools, scans the actual package control metadata, regenerates `Packages`, `Packages.gz`, and `Release`, then commits the updated indexes. This requires GitHub Actions to be enabled and the workflow to have write access to repository contents.

You can also build locally on Debian/Ubuntu:

```sh
sudo apt-get update
sudo apt-get install -y dpkg-dev gzip
sh scripts/build-repo.sh
```

The script stops if no `.deb` files are present. It does not create fake package entries.

## Notes

- Only distribute packages you built or have permission to redistribute.
- Test a package on a compatible device and iOS version before installing it.
- GitHub Pages is a static host; GitHub Actions builds the metadata, not the package itself.
