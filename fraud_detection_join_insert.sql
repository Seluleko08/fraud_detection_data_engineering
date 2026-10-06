INSERT INTO Fraud_DataWarehouse.dbo.FlaggedTransactions
(
    TransactionID,
    CustomerID,
    Amount,
    TransactionDate,
    Location,
    Country,
    AccountStatus,
    FraudReason
)
SELECT
    t.TransactionID,
    t.CustomerID,
    t.Amount,
    t.TransactionDate,
    t.Location,
    c.Country,
    c.AccountStatus,

    CASE
        WHEN c.AccountStatus = 'Suspended'
             AND t.Amount > 5000
             AND t.Location <> c.Country
            THEN 'Suspended Account; Amount > 5000; Location Mismatch'

        WHEN c.AccountStatus = 'Suspended'
             AND t.Amount > 5000
            THEN 'Suspended Account; Amount > 5000'

        WHEN c.AccountStatus = 'Suspended'
             AND t.Location <> c.Country
            THEN 'Suspended Account; Location Mismatch'

        WHEN t.Amount > 5000
             AND t.Location <> c.Country
            THEN 'Amount > 5000; Location Mismatch'

        WHEN c.AccountStatus = 'Suspended'
            THEN 'Suspended Account'

        WHEN t.Amount > 5000
            THEN 'Amount > 5000'

        WHEN t.Location <> c.Country
            THEN 'Location Mismatch'
    END AS FraudReason

FROM Fraud_staging.dbo.Transaction_fraud_stg AS t

INNER JOIN Fraud_staging.dbo.Customer_fraud_stg AS c
    ON t.CustomerID = c.CustomerID

WHERE
    c.AccountStatus = 'Suspended'
    OR t.Amount > 5000
    OR t.Location <> c.Country;