CREATE TABLE dbo.FlaggedTransactions
(
    TransactionID VARCHAR(50),
    CustomerID VARCHAR(50),
    Amount DECIMAL(18,2),
    TransactionDate DATE,
    Location VARCHAR(100),
    Country VARCHAR(100),
    AccountStatus VARCHAR(50),
    FraudReason VARCHAR(200)
);