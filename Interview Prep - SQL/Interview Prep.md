# 💳 SQL Challenge: Customers with More Than 3 Failed Transactions

![SQL Server](https://img.shields.io/badge/SQL%20Server-T--SQL-CC2927?style=for-the-badge&logo=microsoftsqlserver&logoColor=white)
![Difficulty](https://img.shields.io/badge/Difficulty-Intermediate-orange?style=for-the-badge)
![Domain](https://img.shields.io/badge/Domain-Banking%20Analytics-blue?style=for-the-badge)

## 🎯 Problem Statement

Write an SQL query to identify customers who have experienced **more than 3 failed transactions in the last 30 days**.

The output should display:
- Customer ID
- Total number of failed transactions

## 🗄️ 1. Create the Table

```sql
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY,
    customer_id VARCHAR(10),
    transaction_amount DECIMAL(10,2),
    transaction_status VARCHAR(20),
    transaction_date DATETIME
);
```

## 📥 2. Insert Sample Data

The following script creates test data for four customers, including failed transactions, successful transactions, and records older than 30 days.

```sql
INSERT INTO transactions (
    transaction_id,
    customer_id,
    transaction_amount,
    transaction_status,
    transaction_date
)
VALUES
-- C101: 4 failed transactions within 30 days
(1, 'C101', 500.00, 'Failed', DATEADD(DAY, -2, GETDATE())),
(2, 'C101', 700.00, 'Failed', DATEADD(DAY, -5, GETDATE())),
(3, 'C101', 300.00, 'Failed', DATEADD(DAY, -10, GETDATE())),
(4, 'C101', 900.00, 'Failed', DATEADD(DAY, -15, GETDATE())),

-- C102: Only 3 failed transactions
(5, 'C102', 200.00, 'Failed', DATEADD(DAY, -3, GETDATE())),
(6, 'C102', 400.00, 'Failed', DATEADD(DAY, -8, GETDATE())),
(7, 'C102', 600.00, 'Failed', DATEADD(DAY, -12, GETDATE())),

-- C103: 4 recent failures and 1 older failure
(8, 'C103', 100.00, 'Failed', DATEADD(DAY, -1, GETDATE())),
(9, 'C103', 200.00, 'Failed', DATEADD(DAY, -4, GETDATE())),
(10, 'C103', 300.00, 'Failed', DATEADD(DAY, -7, GETDATE())),
(11, 'C103', 400.00, 'Failed', DATEADD(DAY, -20, GETDATE())),
(12, 'C103', 500.00, 'Failed', DATEADD(DAY, -40, GETDATE())),

-- C104: 4 failed transactions and 1 successful transaction
(13, 'C104', 1000.00, 'Failed', DATEADD(DAY, -2, GETDATE())),
(14, 'C104', 1200.00, 'Failed', DATEADD(DAY, -6, GETDATE())),
(15, 'C104', 800.00, 'Failed', DATEADD(DAY, -9, GETDATE())),
(16, 'C104', 600.00, 'Failed', DATEADD(DAY, -18, GETDATE())),
(17, 'C104', 500.00, 'Success', DATEADD(DAY, -20, GETDATE()));
```

## 🔍 3. SQL Solution

```sql
SELECT
    customer_id,
    COUNT(*) AS failed_transaction_count
FROM transactions
WHERE transaction_status = 'Failed'
  AND transaction_date >= DATEADD(DAY, -30, GETDATE())
  AND transaction_date <= GETDATE()
GROUP BY customer_id
HAVING COUNT(*) > 3
ORDER BY failed_transaction_count DESC;
```


**Challenge:** Modify the query to identify customers with more than 3 failed transactions in the last 30 days **and a total failed transaction amount exceeding ₹5,000**.

