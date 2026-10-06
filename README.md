
# Fraud Detection Data Engineering Project

## 📌 Project Overview

This project is an end-to-end **Fraud Detection Data Engineering pipeline** built using **SQL Server, SQL Server Management Studio (SSMS), SQL Server Integration Services (SSIS), and Visual Studio 2022**.

The project processes customer and transaction data from CSV files, loads the data into SQL Server staging tables using SSIS, combines and transforms the data using SQL, identifies potentially fraudulent transactions using defined business rules, and loads the flagged transactions into a data warehouse for analysis.

The project also demonstrates the use of **stored procedures, views, and SQL Server Agent Jobs** to support reusable SQL logic, data access, and ETL automation.

---

## 🎯 Project Objectives

The main objectives of this project were to:

- Extract customer and transaction data from CSV files.
- Load raw data into SQL Server staging tables using SSIS.
- Combine customer and transaction data using SQL JOINs.
- Apply business rules to identify potentially fraudulent transactions.
- Load flagged transactions into a data warehouse.
- Create reusable stored procedures.
- Create SQL views for easier analysis.
- Use SQL Server Agent Jobs for ETL automation and scheduling.
- Analyse the flagged transactions using SQL.
- Document the complete data engineering workflow.

---

## 🛠️ Tools and Technologies

- SQL Server 2022
- SQL Server Management Studio (SSMS)
- SQL Server Integration Services (SSIS)
- Visual Studio 2022
- T-SQL
- GitHub
- CSV
- Data Warehousing
- ETL

---

# 🔄 ETL Pipeline

```text
Customers.csv
      │
      ▼
Transactions.csv
      │
      ▼
   SSIS ETL
      │
      ▼
Fraud_staging
      │
      ├── Customer_fraud_stg
      │
      └── Transaction_fraud_stg
                │
                ▼
          SQL JOIN
                │
                ▼
       Fraud Detection Rules
                │
                ▼
      Fraud_DataWarehouse
                │
                ▼
       FlaggedTransactions
                │
        ┌───────┼────────┐
        ▼       ▼        ▼
      Views   Stored   Analysis
             Procedures
                │
                ▼
       SQL Server Agent
           Automation
