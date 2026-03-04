# Defects Log

**D001 - Revenue Mismatch tra source e staging**  
Descrizione: Source revenue (SAP) = 4640.49 vs Staging revenue = 7791.98 (differenza +3151.49)  
Severity: Critical (impone errore in ETL o dati corrotti)  
Rilevato: Query TC01 (SUM(amount) cross-layer)  
Risoluzione proposta: Investigare valori negativi, cliente inesistente (ID 11), duplicati non puliti  
Output: notebook cella [4]

**D002 - Clienti orfani multipli**  
Descrizione: 4 clienti in CRM senza ordini in SAP/staging (Marco Blu, Sara Rosa, Antonio Verde, Laura Arancione)  
Severity: Medium (possibili clienti inattivi o dati incompleti)  
Rilevato: Query TC02 (LEFT JOIN)  
Risoluzione proposta: Accettato come dato reale o validare upstream  
Output: notebook cella [4]

**D003 - Valore negativo in amount**  
Descrizione: order_id 1009 amount = -50.00 (dato invalido)  
Severity: High (rompe totali e business logic)  
Rilevato: Manual check in staging  
Risoluzione proposta: Filtrare o correggere in ETL reale
Output: notebook cella [4]

**D004 - Cliente inesistente in CRM**  
Descrizione: order_id 1011 con customer_id 11 non presente in crm_customers  
Severity: Medium (causa NULL in join)  
Rilevato: LEFT JOIN → NULL in customer_name  
Risoluzione proposta: Validare dati upstream
Output: notebook cella [5]

**D005 - Email inesistente in Marketo**  
Descrizione: CAMP011 con unknown@email.com non in CRM  
Severity: Low  
Rilevato: JOIN LEFT → NULL in join
Output: notebook cella [6]
