SELECT *
FROM Fraud_DataWarehouse.dbo.FlaggedTransactions;

SELECT COUNT(*) AS TotalFlaggedTransactions
FROM Fraud_DataWarehouse.dbo.FlaggedTransactions;

SELECT
    FraudReason,
    COUNT(*) AS NumberOfTransactions
FROM Fraud_DataWarehouse.dbo.FlaggedTransactions
GROUP BY FraudReason
ORDER BY NumberOfTransactions DESC;