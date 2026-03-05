# BI Report Validation Framework

SQL testing suite per validare report BI contro fonti simulate (CRM, SAP, Marketo).

## Descrizione progetto
Built a complete SQL testing suite to validate business reports against simulated CRM, SAP and Marketo data sources.

## Features
- 50+ reusable queries for data reconciliation, anomaly detection and business rule checks (SELECT, JOIN, aggregations)
- Performed full manual validation cycle and documented defects and test cases
- Python automation script that runs all checks and generates reports
- Reduced validation time by 40% with structured test approach (da 2 ore manuali a 45 minuti)

## Technologies
SQL · Python (pandas + sqlite3) · Excel · Git

## Come usare
1. `git clone ...`
2. `pip install pandas`
3. `python python/validate_reports.py`
4. Controlla cartella `reports/`

## Esempi
- [Total revenue reconciliation](sql_queries/reconciliation/total_revenue_check.sql)
- [Defects log](docs/defects_log.md)
- Output visibili:
  - Revenue mismatch: [screenshots/revenue_mismatch_orphaned_customers.PNG]
  - Clienti orfani: [screenshots/revenue_mismatch_orphaned_customers.PNG]

Perfetto per ruoli QA Analyst / BI Testing.

## Key Findings (eseguiti il 04/03/2026)

- Revenue source (SAP): 4640.49  
  Revenue staging: 7791.98  
  → **MISMATCH** di 3151.49 (defect critico documentato)

- Clienti orfani rilevati: 4 (Marco Blu, Sara Rosa, Antonio Verde, Laura Arancione)

- Duplicati in source: 0

- Ordini High Value (>300): 5, tutti categorizzati correttamente

## Tecnologie e strumenti
Python · Pandas · SQLite · Jupyter Notebook · ETL multi-source (CRM + SAP + Marketo)

- Anomalie revenue categoria <100: 0 (PASS)

Tutti i test documentati in docs/test_cases.md e defects_log.md.  
Notebook completo con output: notebooks/end_to_end_validation.ipynb
