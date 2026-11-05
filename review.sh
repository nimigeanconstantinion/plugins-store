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
jq -e '.structured_output.blocant == false' /tmp/verdict.json > /dev/null
