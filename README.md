# Fraud Detection Data Engineering Project

This project demonstrates an end-to-end fraud detection ETL pipeline using SQL Server, SSIS, and T-SQL. It loads customer and transaction data from CSV files, stages the data in SQL Server, applies fraud detection rules, and writes suspicious transactions to a data warehouse for reporting and analysis.

## Project Overview

The solution is designed to model a practical data engineering workflow:

1. Load raw CSV data into staging tables
2. Validate and transform the data
3. Join customer and transaction records by CustomerID
4. Apply business rules for fraud detection
5. Save suspicious records into a warehouse table
6. Run analysis queries to summarize fraud findings
7. Automate the pipeline using SSIS and SQL Server Agent

## Business Rules Implemented

The project flags transactions when any of the following conditions are met:

- Account status is Suspended
- Transaction amount is greater than 5000
- Transaction location does not match the customer country
- A combination of the above conditions occurs together

## Tools and Technologies

- SQL Server
- SQL Server Management Studio (SSMS)
- SQL Server Integration Services (SSIS)
- Visual Studio 2022
- T-SQL
- CSV data files
- GitHub

## Repository Structure

- `README.md` — project overview and setup instructions
- `create_fraud_databases.sql` — creates the staging and warehouse databases
- `create_flagged_transactions.sql` — creates the final flagged transactions table
- `fraud_detection_join_insert.sql` — joins customer and transaction data and inserts flagged rows
- `usp_load_flagged_transactions.sql` — reusable stored procedure for fraud detection loads
- `testing_join_and_fraud_rules.sql` — SQL tests for validation
- `fraud_analysis.sql` — analysis queries for reporting
- `complete_project_setup.sql` — full setup script for the project
- `Data/Customers.csv` — sample customer data
- `Data/Transactions.csv` — sample transaction data
- `Package.dtsx` and `Load_transaction.dtsx` — SSIS package files
- `fraud_detection_star_schema.jpeg` — star schema reference image

## ETL Flow

```text
Customers.csv
      |
      v
Transactions.csv
      |
      v
SSIS ETL packages
      |
      v
Fraud_staging database
      |
      +--> Customer_fraud_stg
      +--> Transaction_fraud_stg
      |
      v
SQL JOIN on CustomerID
      |
      v
Fraud detection rules
      |
      v
Fraud_DataWarehouse database
      |
      +--> FlaggedTransactions
      |
      v
Analysis and reporting queries
```

## Setup Instructions

1. Open SQL Server Management Studio.
2. Run `create_fraud_databases.sql`.
3. Run `create_flagged_transactions.sql`.
4. Run `usp_load_flagged_transactions.sql`.
5. Load the sample CSV files into the staging tables using SSIS.
6. Execute the stored procedure:

```sql
EXEC Fraud_DataWarehouse.dbo.usp_LoadFlaggedTransactions;
```

7. Run `fraud_analysis.sql` to review flagged transactions.

## Sample Data

The repository includes sample CSV files in the `Data` folder so the project can be tested quickly and easily.

## Expected Output

The warehouse table `Fraud_DataWarehouse.dbo.FlaggedTransactions` stores:

- TransactionID
- CustomerID
- Amount
- TransactionDate
- Location
- Country
- AccountStatus
- FraudReason

## Future Enhancements

- Add more fraud rules and scoring logic
- Add robust SSIS logging and error handling
- Schedule the package via SQL Server Agent
- Add Power BI dashboard reporting
- Improve data quality validation and auditing

## Notes

This project is designed for portfolio, learning, and demonstration purposes. It is structured to show a realistic ETL and fraud detection workflow from source data to warehouse reporting.
