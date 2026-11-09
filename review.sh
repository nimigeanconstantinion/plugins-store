#!/usr/bin/env bash
set -e
branch=$1
plugin=$2
store=$(cd "$(dirname "$0")" && pwd)

git diff "main...$branch" > /tmp/pr.diff

claude -p "/$plugin:diff" \
  --plugin-dir "$store/plugins/$plugin" \
  --model haiku \
  --disallowedTools Bash Read Edit Write Glob Grep \
                    WebFetch WebSearch NotebookEdit Agent \
  --output-format json \
  --json-schema "$(cat "$store/verdict.schema.json")" \
  < /tmp/pr.diff > /tmp/verdict.json

jq '.structured_output' /tmp/verdict.json

jq -r --arg p "$plugin" '.structured_output
  | "### \($p): \(if .blocant then "❌ blocant" else "✅ trece" end)",
    (.motive[] | "- `\(.fisier):\(.linie)` \(.mesaj)")' \
  /tmp/verdict.json > "/tmp/verdict-$plugin.md"
if [ -n "$GITHUB_STEP_SUMMARY" ]; then
  cat "/tmp/verdict-$plugin.md" >> "$GITHUB_STEP_SUMMARY"
fi

jq -e '.structured_output.blocant == false' /tmp/verdict.json > /dev/null
