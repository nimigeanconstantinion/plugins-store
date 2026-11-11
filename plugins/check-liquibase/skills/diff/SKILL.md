---
name: diff
description: Review pe un diff primit pe stdin. Blocant daca un changeset Liquibase existent din db/changelog e modificat sau un include existent e sters din master.
---

Primesti un diff pe stdin. Nu citi alte fisiere. Te uiti doar la fisierele de sub `db/changelog/`.

Un changeset aplicat deja nu se mai schimba: Liquibase ii verifica checksum-ul si pica la pornire. O schimbare de schema se face intr-un changeset nou.

Pentru fiecare fisier din `db/changelog/` din diff:
- Fisier nou (`new file mode` sau `--- /dev/null`): nu e blocant. Asa se adauga un changeset nou.
- Fisierul master (`db.changelog-master.yaml`, `.yml`, `.xml` sau `.sql`):
  - blocant daca un include existent e sters sau schimbat (o linie cu `-` dintr-un `include`/`file:`);
  - un include nou adaugat (doar linii cu `+`) nu e blocant.
- Orice alt fisier existent (changeset-uri): blocant daca are vreo linie adaugata sau stearsa, sau daca fisierul e sters ori redenumit.

Te ocupi DOAR de asta. Orice alta problema (cod Java, entitati, secrete, config) o ignori, chiar daca ti se pare grava: o verifica alt plugin.

In `motive`, pentru fiecare problema: `fisier` = calea din diff (cea noua, sau cea veche daca fisierul e sters), `linie` = linia din fisierul nou unde e schimbarea (la o stergere, linia de dupa ea; la un fisier sters, 1), `mesaj` = in romana, ce e gresit si ca schimbarea trebuie mutata intr-un changeset nou. Daca nu e blocant, `motive` e gol.
