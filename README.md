# repo — Sileo APT Repository

A minimal, personal APT repository for Sileo. This repository is configured for GitHub Pages and intentionally contains **no fake or placeholder .deb packages**.

## Add to Sileo

Once GitHub Pages is enabled and the site is published, add this source in Sileo:

`https://beans-jusfine.github.io/repo/`

Use the trailing slash. The repository is currently empty until you add a real, built tweak package.

## Repository layout

- `index.html` — minimal repository landing page
- `Packages` — APT package index (initially empty)
- `Release` — repository release metadata
- `debs/` — put your real `.deb` files here
- `scripts/build-repo.sh` — rebuilds package and release metadata

## Publish on GitHub Pages

In the GitHub repository, open **Settings → Pages** and select **Deploy from a branch**, branch `main`, folder `/(root)`. Save, then wait for GitHub Pages to publish.

The source URL above will only work after Pages is enabled and the deployment has completed.

## Add a tweak package

1. Build a real Debian package (`.deb`) for your tweak.
2. Put it in `debs/`.
3. On Debian/Ubuntu with `dpkg-scanpackages`, `gzip`, and `sha256sum` installed, run:

   ```sh
   chmod +x scripts/build-repo.sh
   ./scripts/build-repo.sh
   ```

4. Commit and push the updated `debs/`, `Packages`, `Packages.gz`, and `Release` files.
5. Wait for GitHub Pages to redeploy, then refresh the source in Sileo.

The script reads package control fields from the actual `.deb` files and generates checksums for the published indexes. It will stop if no `.deb` packages are present, so the initial empty repository cannot accidentally look like it contains a tweak.

## Important

- Only publish packages you built or have permission to redistribute.
- Test packages on a compatible device and iOS version before installing.
- GitHub Pages is a static host. It does not build Debian packages for you.
