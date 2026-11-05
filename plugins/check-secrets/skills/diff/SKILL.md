---
name: diff
description: Review pe un diff primit pe stdin. Blocant daca are markeri de conflict sau secrete in clar.
---

Primesti un diff pe stdin. Te uiti doar la liniile adaugate (cele care incep cu `+`). Nu citi alte fisiere.

Blocant daca o linie adaugata:
- e un marker de conflict (`<<<<<<<`, `=======`, `>>>>>>>`);
- contine o parola, un token sau o cheie scrise in clar.

O referinta la o variabila (`${DB_PASSWORD}`, `secrets.X`) nu e secret in clar.

Te ocupi DOAR de aceste doua lucruri. Orice alta problema (build, Dockerfile, logica) o ignori, chiar daca ti se pare grava: o verifica alt plugin.

In `motive`, pentru fiecare problema: `fisier` = calea din diff, `linie` = linia din fisierul nou, `mesaj` = in romana, ce e gresit. Daca nu e blocant, `motive` e gol.
