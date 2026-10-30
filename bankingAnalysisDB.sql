CREATE DATABASE BankingAnalysisDB;
GO

USE BankingAnalysisDB;
GO

CREATE TABLE dbo.Branches
(
    BranchID INT PRIMARY KEY,
    BranchName VARCHAR(100) NOT NULL,
    City VARCHAR(100) NOT NULL,
    State VARCHAR(100) NOT NULL
);
GO

CREATE TABLE dbo.Accounts
(
    AccountID INT PRIMARY KEY,
    AccountType VARCHAR(30) NOT NULL,
    BranchID INT NOT NULL,
    OpenDate DATE NOT NULL,

    CONSTRAINT FK_Accounts_Branches
        FOREIGN KEY (BranchID)
        REFERENCES dbo.Branches(BranchID),

    CONSTRAINT CK_Accounts_Type
        CHECK (AccountType IN
        ('Savings', 'Current', 'Business', 'Fixed Deposit'))
);
GO

CREATE TABLE dbo.Transactions
(
    TransactionID INT PRIMARY KEY,
    AccountID INT NOT NULL,
    TransactionDate DATETIME2 NOT NULL,
    TransactionType VARCHAR(30) NOT NULL,
    Amount DECIMAL(12,2) NOT NULL,
    Status VARCHAR(20) NOT NULL,
    Channel VARCHAR(30) NOT NULL,

    CONSTRAINT FK_Transactions_Accounts
        FOREIGN KEY (AccountID)
        REFERENCES dbo.Accounts(AccountID),

    CONSTRAINT CK_Transactions_Amount
        CHECK (Amount > 0),

    CONSTRAINT CK_Transactions_Type
        CHECK (TransactionType IN
        ('Deposit', 'Withdrawal', 'Transfer', 'Payment')),

    CONSTRAINT CK_Transactions_Status
        CHECK (Status IN
        ('Successful', 'Pending', 'Failed')),

    CONSTRAINT CK_Transactions_Channel
        CHECK (Channel IN
        ('ATM', 'Online', 'Branch', 'Mobile'))
);
GO

INSERT INTO dbo.Branches
    (BranchID, BranchName, City, State)
VALUES
    (1, 'Pune Main Branch', 'Pune', 'Maharashtra'),
    (2, 'Mumbai Central Branch', 'Mumbai', 'Maharashtra'),
    (3, 'Nashik Branch', 'Nashik', 'Maharashtra'),
    (4, 'Kolhapur Branch', 'Kolhapur', 'Maharashtra');
GO

INSERT INTO dbo.Accounts
    (AccountID, AccountType, BranchID, OpenDate)
VALUES
    (1001, 'Savings', 1, '2024-01-15'),
    (1002, 'Current', 1, '2024-02-20'),
    (1003, 'Savings', 2, '2024-03-10'),
    (1004, 'Business', 2, '2024-04-05'),
    (1005, 'Fixed Deposit', 3, '2024-05-12'),
    (1006, 'Savings', 3, '2024-06-18'),
    (1007, 'Current', 4, '2024-07-22'),
    (1008, 'Business', 4, '2024-08-01');
GO

INSERT INTO dbo.Transactions
(
    TransactionID,
    AccountID,
    TransactionDate,
    TransactionType,
    Amount,
    Status,
    Channel
)
VALUES
(1, 1001, '2026-01-05 09:10', 'Deposit',    15000, 'Successful', 'Branch'),
(2, 1001, '2026-01-08 11:20', 'Withdrawal',  3000, 'Successful', 'ATM'),
(3, 1002, '2026-01-12 12:30', 'Payment',     4500, 'Successful', 'Online'),
(4, 1003, '2026-01-15 14:10', 'Transfer',    8000, 'Successful', 'Mobile'),
(5, 1004, '2026-01-19 10:15', 'Deposit',    25000, 'Successful', 'Branch'),
(6, 1005, '2026-01-22 16:20', 'Deposit',    50000, 'Successful', 'Branch'),
(7, 1006, '2026-02-02 09:00', 'Withdrawal',  2000, 'Successful', 'ATM'),
(8, 1007, '2026-02-06 10:40', 'Payment',     6500, 'Pending',    'Online'),
(9, 1008, '2026-02-10 13:15', 'Transfer',   12000, 'Successful', 'Mobile'),
(10,1001, '2026-02-14 15:00', 'Deposit',     9000, 'Successful', 'Mobile'),
(11,1002, '2026-02-18 11:10', 'Withdrawal',  4000, 'Successful', 'Branch'),
(12,1003, '2026-02-23 17:30', 'Payment',     3200, 'Failed',     'Online'),
(13,1004, '2026-03-03 10:20', 'Deposit',    30000, 'Successful', 'Branch'),
(14,1005, '2026-03-07 12:10', 'Transfer',   15000, 'Successful', 'Online'),
(15,1006, '2026-03-11 14:40', 'Payment',     5200, 'Successful', 'Mobile'),
(16,1007, '2026-03-15 09:30', 'Withdrawal',  7500, 'Successful', 'ATM'),
(17,1008, '2026-03-19 16:15', 'Deposit',    18000, 'Successful', 'Branch'),
(18,1001, '2026-04-02 10:10', 'Payment',     2100, 'Successful', 'Online'),
(19,1002, '2026-04-06 11:25', 'Transfer',   11000, 'Pending',    'Mobile'),
(20,1003, '2026-04-10 13:50', 'Deposit',    22000, 'Successful', 'Branch'),
(21,1004, '2026-04-14 15:20', 'Withdrawal',  6000, 'Successful', 'ATM'),
(22,1005, '2026-04-18 12:35', 'Payment',     8500, 'Failed',     'Online'),
(23,1006, '2026-04-22 09:45', 'Deposit',    14000, 'Successful', 'Mobile'),
(24,1007, '2026-04-26 17:05', 'Transfer',    9500, 'Successful', 'Online');
GO

SELECT COUNT(*) AS TotalBranches
FROM dbo.Branches;

SELECT COUNT(*) AS TotalAccounts
FROM dbo.Accounts;

SELECT COUNT(*) AS TotalTransactions
FROM dbo.Transactions;

SELECT TOP 10 *
FROM dbo.Transactions
ORDER BY TransactionDate;

-- Check duplicate transaction IDs
SELECT TransactionID, COUNT(*) AS RecordCount
FROM dbo.Transactions
GROUP BY TransactionID
HAVING COUNT(*) > 1;

-- Check missing required values
SELECT *
FROM dbo.Transactions
WHERE AccountID IS NULL
   OR TransactionDate IS NULL
   OR Amount IS NULL
   OR Status IS NULL;

-- Check account references without matching accounts
SELECT t.*
FROM dbo.Transactions AS t
LEFT JOIN dbo.Accounts AS a
    ON t.AccountID = a.AccountID
WHERE a.AccountID IS NULL;

-- Check transaction status counts
SELECT Status, COUNT(*) AS TotalTransactions
FROM dbo.Transactions
GROUP BY Status;

SELECT
    COUNT(*) AS TotalTransactions,
    SUM(Amount) AS TotalTransactionValue,
    AVG(Amount) AS AverageTransactionAmount,
    MIN(Amount) AS MinimumTransactionAmount,
    MAX(Amount) AS MaximumTransactionAmount
FROM dbo.Transactions;

SELECT
    TransactionType,
    COUNT(*) AS TransactionCount,
    SUM(Amount) AS TotalAmount
FROM dbo.Transactions
WHERE Status = 'Successful'
  AND TransactionType IN ('Deposit', 'Withdrawal')
GROUP BY TransactionType;

SELECT
    YEAR(TransactionDate) AS SalesYear,
    MONTH(TransactionDate) AS SalesMonth,
    COUNT(*) AS TotalTransactions,
    SUM(CASE
        WHEN Status = 'Successful' THEN Amount
        ELSE 0
    END) AS SuccessfulTransactionValue
FROM dbo.Transactions
GROUP BY
    YEAR(TransactionDate),
    MONTH(TransactionDate)
ORDER BY SalesYear, SalesMonth;

SELECT
    a.AccountType,
    COUNT(t.TransactionID) AS TotalTransactions,
    SUM(CASE
        WHEN t.Status = 'Successful' THEN t.Amount
        ELSE 0
    END) AS SuccessfulValue
FROM dbo.Accounts AS a
LEFT JOIN dbo.Transactions AS t
    ON a.AccountID = t.AccountID
GROUP BY a.AccountType
ORDER BY SuccessfulValue DESC;

SELECT
    b.BranchName,
    b.City,
    COUNT(t.TransactionID) AS TotalTransactions,
    SUM(CASE
        WHEN t.Status = 'Successful' THEN t.Amount
        ELSE 0
    END) AS SuccessfulValue
FROM dbo.Branches AS b
LEFT JOIN dbo.Accounts AS a
    ON b.BranchID = a.BranchID
LEFT JOIN dbo.Transactions AS t
    ON a.AccountID = t.AccountID
GROUP BY b.BranchName, b.City
ORDER BY SuccessfulValue DESC;

SELECT
    Channel,
    COUNT(DISTINCT TransactionID) AS TotalTransactions,
    SUM(Amount) AS TotalAmount,
    SUM(
        CASE
            WHEN Status = 'Successful' THEN Amount
            ELSE 0
        END
    ) AS SuccessfulValue
FROM dbo.Transactions
GROUP BY Channel
ORDER BY Channel;
GO

CREATE VIEW dbo.vw_TransactionDetails
AS
SELECT
    t.TransactionID,
    t.TransactionDate,
    t.TransactionType,
    t.Amount,
    t.Status,
    t.Channel,
    a.AccountID,
    a.AccountType,
    b.BranchID,
    b.BranchName,
    b.City,
    b.State,
    CASE
        WHEN t.Status = 'Successful'
        THEN t.Amount
        ELSE 0
    END AS SuccessfulAmount
FROM dbo.Transactions AS t
INNER JOIN dbo.Accounts AS a
    ON t.AccountID = a.AccountID
INNER JOIN dbo.Branches AS b
    ON a.BranchID = b.BranchID;
GO

CREATE VIEW dbo.vw_MonthlyTransactions
AS
SELECT
    DATEFROMPARTS(
        YEAR(TransactionDate),
        MONTH(TransactionDate),
        1
    ) AS TransactionMonth,

    COUNT(*) AS TotalTransactions,

    SUM(CASE
        WHEN Status = 'Successful' THEN Amount
        ELSE 0
    END) AS SuccessfulValue,

    SUM(CASE
        WHEN Status = 'Failed' THEN 1
        ELSE 0
    END) AS FailedTransactions,

    SUM(CASE
        WHEN Status = 'Pending' THEN 1
        ELSE 0
    END) AS PendingTransactions

FROM dbo.Transactions
GROUP BY
    YEAR(TransactionDate),
    MONTH(TransactionDate);
GO

CREATE VIEW dbo.vw_TransactionTypeSummary
AS
SELECT
    TransactionType,
    COUNT(*) AS TotalTransactions,

    SUM(CASE
        WHEN Status = 'Successful' THEN Amount
        ELSE 0
    END) AS SuccessfulValue,

    SUM(CASE
        WHEN Status = 'Successful' THEN 1
        ELSE 0
    END) AS SuccessfulCount

FROM dbo.Transactions
GROUP BY TransactionType;
GO

SELECT * FROM dbo.vw_TransactionDetails;

SELECT * FROM dbo.vw_MonthlyTransactions
ORDER BY TransactionMonth;

SELECT * FROM dbo.vw_TransactionTypeSummary
ORDER BY SuccessfulValue DESC;