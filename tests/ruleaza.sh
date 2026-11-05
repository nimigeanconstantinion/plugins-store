#!/usr/bin/env bash
cd "$(dirname "$0")/.."
schema="$(cat verdict.schema.json)"
picate=0

while read -r diff plugin asteptat; do
  primit=$(claude -p "/$plugin:diff" --plugin-dir "plugins/$plugin" \
    --disallowedTools Bash Read Edit Write Glob Grep WebFetch WebSearch NotebookEdit Agent \
    --model haiku --output-format json --json-schema "$schema" \
    < "tests/$diff.diff" | jq -r '.structured_output.blocant')
  if [ "$primit" = "$asteptat" ]; then
    echo "OK    $diff / $plugin: blocant=$primit"
  else
    echo "PICAT $diff / $plugin: asteptat $asteptat, primit $primit"
    picate=$((picate + 1))
  fi
done < <(grep -v '^#' tests/asteptat.txt)

echo "picate: $picate"
exit "$picate"
