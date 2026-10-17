#!/usr/bin/env sh
set -eu
cd "$(dirname "$0")/.."

if ! command -v dpkg-scanpackages >/dev/null 2>&1; then
  echo "Missing dpkg-scanpackages. Install dpkg-dev first." >&2
  exit 1
fi
if ! command -v gzip >/dev/null 2>&1 || ! command -v sha256sum >/dev/null 2>&1; then
  echo "This script requires gzip and sha256sum." >&2
  exit 1
fi
if ! find debs -maxdepth 1 -type f -name '*.deb' -print -quit | grep -q .; then
  echo "No .deb files found in debs/. Add a real package before building the index." >&2
  exit 1
fi

dpkg-scanpackages -m debs /dev/null > Packages
gzip -9n -c Packages > Packages.gz

{
  echo "Origin: repo"
  echo "Label: repo"
  echo "Suite: stable"
  echo "Version: 1.0"
  echo "Codename: repo"
  echo "Architectures: iphoneos-arm iphoneos-arm64"
  echo "Components: main"
  echo "Description: Personal Sileo APT repository"
  echo "Date: $(LC_ALL=C date -Ru)"
  echo "MD5Sum:"
  for file in Packages Packages.gz; do
    printf " %s %s %s\n" "$(md5sum "$file" | cut -d ' ' -f 1)" "$(wc -c < "$file" | tr -d ' ')" "$file"
  done
  echo "SHA256:"
  for file in Packages Packages.gz; do
    printf " %s %s %s\n" "$(sha256sum "$file" | cut -d ' ' -f 1)" "$(wc -c < "$file" | tr -d ' ')" "$file"
  done
} > Release

echo "Generated Packages, Packages.gz, and Release."
