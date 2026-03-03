# Test Cases

| TC_ID | Requirement | Query/Check | Expected Result | Actual Result | Status |
|---|---|---|---|---|---|
| TC_01 | Revenue reconciliation | Confronto SUM(amount) source vs SUM(total_revenue) report | Valori uguali | Diversi per presenza customer_id non censito | FAIL |
| TC_02 | Duplicati ordini | Duplicati su order_id | Nessun duplicato | Nessun duplicato su chiave order_id | PASS |
| TC_03 | Integrità referenziale clienti | Ordini con customer_id non presente in source_customers | 0 record | Presente order ORD005 con customer_id=6 | FAIL |
| TC_04 | Regola business High Value | amount > 1000 => order_category='High Value' | Tutti conformi | Conforme in staging | PASS |
| TC_05 | Clienti senza ordini | LEFT JOIN customers-orders con o.order_id IS NULL | 0 clienti | 1 cliente senza ordini (Marco Blu) | FAIL |
