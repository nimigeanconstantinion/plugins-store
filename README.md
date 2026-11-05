# plugins-store

Marketplace de pluginuri Claude Code: review pe diff in CI si garzi locale.

| Plugin | Ce face | Cum il folosesti |
|---|---|---|
| `check-secrets` | markeri de conflict si secrete in clar | `/check-secrets:diff` |
| `check-spring` | conventiile Spring Boot | `/check-spring:diff`, `/check-spring:conventions` |
| `git-guard` | blocheaza `.env` in git, `push --force`, push pe main, `rm -rf` larg, commit cu secrete | hook, porneste singur |

## Teste

`tests/ruleaza.sh` ruleaza fiecare diff din `tests/` prin fiecare plugin `check-*` si compara cu `tests/asteptat.txt`.
