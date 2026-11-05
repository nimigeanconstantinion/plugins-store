#!/usr/bin/env bash
comanda=$(jq -r '.tool_input.command // ""')

blocheaza() {
  echo "Blocat de git-guard: $1" >&2
  exit 2
}

if grep -Eq 'git +add .*\.env\b' <<<"$comanda"; then
  blocheaza ".env nu intra in git. Pune variabila in .env.example, fara valoare."
fi

if grep -Eq 'git +push .*(--force|-f\b)' <<<"$comanda"; then
  blocheaza "push --force rescrie istoria de pe remote. Fa un commit nou in loc."
fi

if grep -Eq 'git +push +[^ ]+ +(main|master)\b' <<<"$comanda"; then
  blocheaza "push direct pe main/master. Lucreaza pe un branch si deschide un PR."
fi

if grep -Eq 'rm +-[a-zA-Z]*r[a-zA-Z]*f?[a-zA-Z]* +(/|~|\.|\*|\$HOME)( |$)' <<<"$comanda"; then
  blocheaza "rm -rf pe un folder intreg (/, ~, ., *). Sterge fisierele pe nume."
fi

if grep -Eq 'git +commit' <<<"$comanda"; then
  if git diff --cached -U0 2>/dev/null | grep -E '^\+' | grep -Eiq '(password|passwd|secret|token|api[_-]?key) *[:=] *["'"'"']?[A-Za-z0-9!@#%^&*_+=-]{8,}'; then
    blocheaza "in stage e o linie cu o parola sau un token in clar. Muta valoarea intr-o variabila de mediu."
  fi
fi

exit 0
