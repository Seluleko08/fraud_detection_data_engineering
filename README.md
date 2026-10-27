# Fraud Detection Data Engineering Project

This project is a SQL Server and SSIS-based fraud detection ETL solution. It demonstrates how raw customer and transaction data can be loaded from CSV files, transformed through staging tables, joined using SQL, and checked against fraud rules before being written to a data warehouse for reporting and analysis.

## Project Overview

This repository combines:

- SSIS for ETL orchestration and file loading
- SQL Server for staging and warehouse storage
- T-SQL for transformation logic, joins, business rules, and reporting

The solution models a realistic data engineering workflow commonly used in financial data projects.

## ETL Flow

```text
Customers.csv
      |
      v
Transactions.csv
      |
      v
SSIS Data Flow Tasks
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
Fraud detection business rules
      |
      v
Fraud_DataWarehouse database
      |
      +--> FlaggedTransactions
      |
      v
SQL analysis and reporting
```

## Fraud Detection Rules

Transactions are flagged when one or more of the following conditions are true:

- Account status is Suspended
- Transaction amount exceeds 5000
- Transaction location differs from the customer country
- A combination of the above rules applies

## Tools and Technologies

- SQL Server
- SSMS
- SSIS
- Visual Studio 2022
- T-SQL
- CSV files
- GitHub

## Repository Structure

- `README.md` — project overview and usage guide
- `create_fraud_databases.sql` — creates the staging and warehouse databases
- `create_flagged_transactions.sql` — creates the warehouse output table
- `fraud_detection_join_insert.sql` — joins source data and inserts flagged rows
- `usp_load_flagged_transactions.sql` — reusable stored procedure for fraud detection
- `testing_join_and_fraud_rules.sql` — validation and test queries
- `fraud_analysis.sql` — reporting and summary queries
- `complete_project_setup.sql` — full setup script for the project
- `Data/Customers.csv` — sample customer records
- `Data/Transactions.csv` — sample transaction records
- `Package.dtsx` and `Load_transaction.dtsx` — SSIS package files
- `FraudDetection_ETL.sln` — SSIS solution file
- `FraudDetection_ETL.dtproj` — SSIS project file
- `fraud_detection_star_schema.jpeg` — star schema diagram

## SSIS Component

This project is not only T-SQL; the SSIS layer is an important part of the architecture.

The SSIS process handles:

- reading source CSV files
- loading staging tables
- triggering SQL logic for fraud detection
- enabling ETL orchestration and automation

GitHub stores the SSIS package files and project structure, while the actual execution is performed in Visual Studio + SQL Server Integration Services on a local or server environment.

## Setup Instructions

1. Open SQL Server Management Studio.
2. Run `complete_project_setup.sql` to create the required databases and objects.
3. Open the SSIS project in Visual Studio.
4. Configure the CSV connection managers for the files in the `Data` folder.
5. Load the customer and transaction CSV files into the staging tables.
6. Execute the fraud detection procedure:

```sql
USE Fraud_DataWarehouse;
GO

EXEC dbo.usp_LoadFlaggedTransactions;
GO
```

7. Run the summary and analysis queries in `fraud_analysis.sql`.

## Project Status

This project is structured as a complete SSIS + SQL Server ETL solution and is suitable for portfolio demonstration. It reflects a realistic data engineering workflow and is near completion for GitHub presentation and academic submission.

## Expected Output

The final warehouse table `Fraud_DataWarehouse.dbo.FlaggedTransactions` includes:

- TransactionID
- CustomerID
- Amount
- TransactionDate
- Location
- Country
- AccountStatus
- FraudReason

## Future Improvements

- Add more fraud rules and risk scoring
- Improve data-quality validation routines
- Add SSIS logging and error handling
- Automate execution using SQL Server Agent
- Add dashboards or Power BI reporting

## Final Note

This repository is designed to show both SSIS-based ETL and T-SQL-based rules processing, which is why it is presented as a full fraud detection data engineering project rather than a SQL-only solution.
