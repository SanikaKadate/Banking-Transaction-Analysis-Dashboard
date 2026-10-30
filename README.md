# 🏦 Banking Transaction Analysis using SQL Server and Power BI

## 📌 Project Overview

The **Banking Transaction Analysis** project analyzes banking transactions using Microsoft SQL Server and Microsoft Power BI. It helps understand transaction performance, successful transaction values, transaction statuses, monthly trends, banking channels, and branch-level performance through an interactive dashboard.

The project combines SQL-based data management and analysis with Power BI visualizations to present banking data in an easy-to-understand format.

## 🎯 Project Objectives

- Analyze total banking transactions and transaction values.
- Monitor successful and failed transactions.
- Analyze monthly transaction trends.
- Compare transaction performance across banking channels.
- Identify transaction types contributing to successful transaction value.
- Compare branch-wise transaction performance.
- Analyze transactions by account type.
- Enable interactive filtering using dashboard slicers.

## 🛠️ Tools and Technologies

| Tool | Purpose |
|---|---|
| Microsoft SQL Server | Database creation and data storage |
| SQL | Data querying, analysis, validation, and aggregation |
| Microsoft Power BI Desktop | Interactive dashboard development |
| DAX | Measures and KPI calculations |
| Power Query | Data preparation and transformation |
| GitHub | Project documentation and version control |

## 🗄️ Database Design

The project uses a SQL Server database named `BankingAnalysisDB`.

It contains three main tables:

### 1. Branches

Stores banking branch information.

**Columns:**
- `BranchID` — Primary key
- `BranchName` — Name of the branch
- `City` — Branch city
- `State` — Branch state

### 2. Accounts

Stores bank account information.

**Columns:**
- `AccountID` — Primary key
- `AccountType` — Type of bank account
- `BranchID` — Foreign key referencing the Branches table
- `OpenDate` — Account opening date

**Account types:** Savings, Current, Business, Fixed Deposit.

### 3. Transactions

Stores banking transaction records.

**Columns:**
- `TransactionID` — Primary key
- `AccountID` — Foreign key referencing the Accounts table
- `TransactionDate` — Transaction date and time
- `TransactionType` — Type of transaction
- `Amount` — Transaction amount
- `Status` — Transaction status
- `Channel` — Transaction channel

**Transaction types:** Deposit, Withdrawal, Transfer, Payment.

**Transaction statuses:** Successful, Pending, Failed.

**Transaction channels:** ATM, Online, Branch, Mobile.

### Database Relationships

The database uses the following relationships:

- `Branches[BranchID]` → `Accounts[BranchID]`
- `Accounts[AccountID]` → `Transactions[AccountID]`

These relationships connect branches, accounts, and transactions for analysis.

## 📊 Power BI Dashboard

The interactive dashboard is titled **BANKING TRANSACTION ANALYSIS**, with a focus on transaction performance, branches, and channels.

### Dashboard KPIs

The dashboard includes the following key performance indicators:

- **Total Transactions:** Total number of transactions.
- **Successful Value:** Total monetary value of successful transactions.
- **Failed Transactions:** Number of failed transactions.
- **Success Rate:** Percentage of transactions completed successfully.

### Dashboard Visualizations

#### 1. Channel Comparison
Compares transaction counts across:
- Branch
- Online
- Mobile
- ATM

#### 2. Monthly Trends
Displays successful transaction value by month to identify changes in transaction performance over time.

#### 3. Transaction Status
Shows transaction status distribution and total transaction counts.

#### 4. Transaction Type Analysis
Compares successful transaction values across:
- Deposit
- Withdrawal
- Transfer
- Payment

#### 5. Branch Comparison
Compares successful transaction values across:
- Mumbai Central Branch
- Nashik Branch
- Kolhapur Branch
- Pune Main Branch

### Interactive Slicers

The dashboard includes six slicers for interactive analysis:

1. Transaction Date
2. Transaction Type
3. Status
4. Account Type
5. Branch Name
6. Channel

Users can select different filter values to explore transaction performance across specific periods, transaction categories, statuses, accounts, branches, and channels.

## 🧮 SQL Analysis

The SQL script includes queries for database creation, data insertion, data validation, and transaction analysis.

### Key SQL Operations

- Create the `BankingAnalysisDB` database.
- Create tables with primary keys and foreign key relationships.
- Insert sample branches, accounts, and transactions.
- Check transaction counts and summary statistics.
- Identify duplicate transaction IDs.
- Check missing transaction values.
- Validate account references.
- Analyze transaction status counts.
- Calculate total, average, minimum, and maximum transaction amounts.
- Analyze monthly transaction values.
- Compare transaction performance by account type.
- Compare successful transaction values by branch.
- Analyze transaction counts and values by channel.

### SQL Views

The project creates three views to support reporting and analysis.

| View | Purpose |
|---|---|
| `vw_TransactionDetails` | Combines transaction, account, and branch information |
| `vw_MonthlyTransactions` | Summarizes monthly transactions, successful values, and transaction statuses |
| `vw_TransactionTypeSummary` | Summarizes transactions and successful values by transaction type |

These views provide structured datasets that can be used for reporting and visualization.

## 📁 Project Structure

```text
Banking-Transaction-Analysis/
│
├── README.md
│
├── bankingAnalysisDB.sql
│
└── bankingAnalysisDashboard.pdf
```

**File descriptions:**

- `README.md` — Project overview, database details, and dashboard documentation.
- `bankingAnalysisDB.sql` — SQL script for database creation, sample data insertion, data validation, analytical queries, and views.
- `bankingAnalysisDashboard.pdf` — PDF version of the Power BI dashboard for viewing the project output.

## 🚀 How to Run the Project

### Step 1: Clone the Repository

Open a terminal and execute:

```bash
git clone <your-github-repository-url>
```

Navigate to the project directory:

```bash
cd Banking-Transaction-Analysis
```

### Step 2: Create the Database

1. Open SQL Server Management Studio (SSMS).
2. Connect to your SQL Server instance.
3. Open `bankingAnalysisDB.sql`.
4. Execute the script.
5. Refresh the Databases folder and verify that `BankingAnalysisDB` has been created.

**Note:** The script creates the database and tables, inserts sample records, performs validation and analysis queries, and creates SQL views.

### Step 3: Verify the Data

Execute the following queries:

```sql
USE BankingAnalysisDB;
GO

SELECT * FROM dbo.Branches;

SELECT * FROM dbo.Accounts;

SELECT * FROM dbo.Transactions;

SELECT * FROM dbo.vw_TransactionDetails;

SELECT * FROM dbo.vw_MonthlyTransactions;

SELECT * FROM dbo.vw_TransactionTypeSummary;
```

### Step 4: Connect Power BI to SQL Server

1. Open Microsoft Power BI Desktop.
2. Select **Home → Get Data → SQL Server**.
3. Enter your SQL Server instance name.
4. Enter `BankingAnalysisDB` as the database name.
5. Choose Import or DirectQuery, depending on your requirements.
6. Select the tables or SQL views needed for the dashboard.
7. Load the data into Power BI.

### Step 5: Build the Dashboard

Create the KPI cards, charts, and slicers described in the Dashboard section.

Configure the visuals to use the appropriate transaction measures and fields. Verify that selecting a slicer updates the relevant charts and KPI cards.

### Step 6: Publish to GitHub

Add the SQL script, dashboard PDF, and README file to your GitHub repository.

Commit and push the files using Git or upload them through the GitHub website.

## 🔍 Data Validation

The SQL script includes checks for:

- Duplicate transaction IDs.
- Missing required transaction values.
- Transactions referencing nonexistent accounts.
- Transaction status distribution.
- Transaction totals and summary statistics.

These checks help verify the integrity of the sample data before analysis.

## 📈 Key Learning Outcomes

Through this project, I practiced:

- Designing a relational database using SQL Server.
- Creating tables with primary keys, foreign keys, and CHECK constraints.
- Writing SQL queries using joins, aggregations, conditional expressions, and grouping.
- Creating SQL views for analytical reporting.
- Connecting SQL Server to Power BI.
- Developing KPI cards, charts, and interactive slicers.
- Analyzing transaction performance across time, branches, transaction types, and channels.
- Presenting data through an interactive business intelligence dashboard.

## 🔮 Future Enhancements

Potential improvements include:

- Adding a larger, more realistic banking transaction dataset.
- Introducing additional transaction performance KPIs.
- Adding year-over-year and month-over-month comparisons.
- Improving fraud detection analysis with suspicious transaction indicators.
- Adding customer-level analysis.
- Implementing scheduled data refresh.
- Publishing the dashboard to Power BI Service.
- Adding role-level security for branch-specific reporting.

## 👨‍💻 Project Information

**Project Name:** Banking Transaction Analysis

**Domain:** Banking and Financial Analytics

**Database:** BankingAnalysisDB

**Database Technology:** Microsoft SQL Server

**Visualization Tool:** Microsoft Power BI Desktop

**Programming Language:** SQL and DAX

**Project Type:** Data Analytics and Business Intelligence

---

⭐ If you find this project useful, consider giving the repository a star.

**Thank you for visiting my project!**
