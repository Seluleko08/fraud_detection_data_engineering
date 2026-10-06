-- Test 1: Test the JOIN

SELECT
    t.TransactionID,
    t.CustomerID,
    t.Amount,
    t.TransactionDate,
    t.Location,
    c.Country,
    c.AccountStatus
FROM Fraud_staging.dbo.Transaction_fraud_stg AS t
INNER JOIN Fraud_staging.dbo.Customer_fraud_stg AS c
    ON t.CustomerID = c.CustomerID;


-- Test 2: Test the JOIN with fraud rules

SELECT
    t.TransactionID,
    t.CustomerID,
    t.Amount,
    t.TransactionDate,
    t.Location,
    c.Country,
    c.AccountStatus
FROM Fraud_staging.dbo.Transaction_fraud_stg AS t
INNER JOIN Fraud_staging.dbo.Customer_fraud_stg AS c
    ON t.CustomerID = c.CustomerID
WHERE
    c.AccountStatus = 'Suspended'
    OR t.Amount > 5000
    OR t.Location <> c.Country;