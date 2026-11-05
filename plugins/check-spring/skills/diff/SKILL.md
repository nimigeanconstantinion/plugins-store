---
name: diff
description: Review pe un diff primit pe stdin, doar pe codul si configurarea Spring. Blocant la incalcarile conventiilor din conventions.
---

Primesti un diff pe stdin. Te uiti doar la liniile adaugate (cele care incep cu `+`) din fisierele `.java` si `application*.yml|yaml|properties`. Nu citi alte fisiere.

Blocant daca o linie adaugata:
- pune `@Autowired` pe un camp;
- face un controller sa intoarca sau sa primeasca o entitate JPA in loc de DTO. Entitatea nu apare neaparat in diff: recunosti tipul dupa import, din pachete ca `.models.`, `.entity.`, `.entities.` sau `.domain.`, ori dupa `@Entity` daca e in diff;
- pune `@Transactional` pe un controller;
- seteaza `ddl-auto` pe `create`, `create-drop` sau `update`. Valoarea corecta e `validate` (sau `none`), iar schema se schimba prin migrari; nu recomanda niciodata `update`.

Te ocupi DOAR de aceste reguli. Secretele, Dockerfile-ul si securitatea le verifica alte pluginuri: le ignori, chiar daca ti se par grave.

In `motive`, pentru fiecare problema: `fisier` = calea din diff, `linie` = linia din fisierul nou, `mesaj` = in romana, ce trebuie schimbat. Daca nu e blocant, `motive` e gol.
