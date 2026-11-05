---
name: conventions
description: Conventiile Spring Boot ale proiectului. Foloseste-le cand scrii sau modifici cod Java/Spring, configurari application.yaml sau teste.
---

- Configurarea vine din variabile de mediu: `${DB_PASSWORD}`, fara valori reale in `application.yaml`.
- Injectarea prin constructor, cu campuri `final`. Fara `@Autowired` pe campuri.
- Controller-ul primeste si intoarce DTO-uri (`record`), niciodata entitati JPA.
- `@Transactional` sta pe service, nu pe controller.
- Erorile trec prin `GlobalExceptionHandler`; controller-ul nu prinde exceptii ca sa intoarca coduri HTTP.
- `ddl-auto` ramane `validate` sau `none` in afara testelor; schema se schimba prin migrari.
- Testele urmeaza `// Arrange`, `// Act`, `// Assert`, cate un comportament pe test.
