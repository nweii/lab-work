#!/usr/bin/env bash
# ABOUTME: Publishes a GitHub release for the plugin's version when that version has none yet.
# With --check it only verifies the version and prints the release notes.
set -euo pipefail

cd "$(dirname "$0")/.."

version=$(jq -r .version plugin.json)
tag="v$version"

fail() {
  echo "release: $1" >&2
  exit 1
}

check_version() {
  local found=$1 where=$2
  [ "$found" = "$version" ] || fail "$where has version $found, and plugin.json has $version"
}

check_version "$(jq -r .version .claude-plugin/plugin.json)" ".claude-plugin/plugin.json"
check_version "$(jq -r .version .codex-plugin/plugin.json)" ".codex-plugin/plugin.json"
check_version "$(jq -r '.plugins[0].version' .claude-plugin/marketplace.json)" ".claude-plugin/marketplace.json"
for skill in skills/*/SKILL.md; do
  check_version "$(sed -n 's/^  version: "\(.*\)"$/\1/p' "$skill")" "$skill"
done

# The notes are the changelog section for this version, without its heading.
notes=$(awk -v heading="## $version " '
  index($0, heading) == 1 { found = 1; next }
  found && /^## / { exit }
  found { print }
' CHANGELOG.md)
[ -n "${notes//[[:space:]]/}" ] || fail "CHANGELOG.md has no section for $version"

if [ "${1:-}" = "--check" ]; then
  echo "$tag"
  echo "$notes"
  exit 0
fi

if gh release view "$tag" >/dev/null 2>&1; then
  echo "release: $tag is already released"
  exit 0
fi

gh release create "$tag" --target "$GITHUB_SHA" --title "$tag" --notes "$notes"
