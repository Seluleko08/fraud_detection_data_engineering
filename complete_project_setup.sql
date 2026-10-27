USE master;
GO

IF DB_ID('Fraud_staging') IS NOT NULL
BEGIN
    ALTER DATABASE Fraud_staging SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Fraud_staging;
END
GO

IF DB_ID('Fraud_DataWarehouse') IS NOT NULL
BEGIN
    ALTER DATABASE Fraud_DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Fraud_DataWarehouse;
END
GO

CREATE DATABASE Fraud_staging;
GO

CREATE DATABASE Fraud_DataWarehouse;
GO

USE Fraud_staging;
GO

CREATE TABLE dbo.Customer_fraud_stg
(
    CustomerID VARCHAR(50),
    CustomerName VARCHAR(100),
    Country VARCHAR(100),
    AccountStatus VARCHAR(50)
);

CREATE TABLE dbo.Transaction_fraud_stg
(
    TransactionID VARCHAR(50),
    CustomerID VARCHAR(50),
    Amount DECIMAL(18,2),
    TransactionDate DATE,
    Location VARCHAR(100)
);
GO

USE Fraud_DataWarehouse;
GO

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
GO

CREATE OR ALTER PROCEDURE dbo.usp_LoadFlaggedTransactions
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.FlaggedTransactions
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

    RETURN @@ROWCOUNT;
END;
GO

SELECT 'Database setup complete.' AS Status;
GO
