# Defects Log

| Defect ID | Title | Severity | Description | Evidence | Status |
|---|---|---|---|---|---|
| DEF_01 | Customer missing in master data | High | L'ordine ORD005 referenzia customer_id=6 assente in source_customers. | Query 6 in `validation_queries.sql` | Open |
| DEF_02 | Null customer_name in staging | Medium | L'ordine con cliente mancante genera `customer_name` nullo in staging. | Query 24 in `validation_queries.sql` | Open |
| DEF_03 | Revenue mismatch source vs report | High | Il report filtra customer_name null causando differenza con revenue totale source. | Query 3 e logica report | Open |
| DEF_04 | Cliente senza ordini | Low | `Marco Blu` presente in anagrafica ma senza ordini associati. | Query 2 in `validation_queries.sql` | Open |
