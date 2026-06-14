# 🛍️ Retail Sales Analysis using SQL

![SQL](https://img.shields.io/badge/SQL-Advanced-blue?style=for-the-badge)
![MySQL](https://img.shields.io/badge/MySQL-Database-orange?style=for-the-badge)
![Data%20Analysis](https://img.shields.io/badge/Data-Analytics-green?style=for-the-badge)
![GitHub](https://img.shields.io/badge/Portfolio-Project-black?style=for-the-badge)

---

# 📌 Project Overview

This project analyzes **retail sales transaction data using SQL** to uncover customer purchasing behavior, product performance, revenue patterns, and operational insights.

The analysis transforms raw transactional records into business-driven insights through **data cleaning, exploratory data analysis (EDA), aggregations, Common Table Expressions (CTEs), and Window Functions**.

This project simulates real-world reporting tasks commonly performed by **Data Analysts** and demonstrates practical SQL techniques used in retail analytics.

---

# 🎯 Business Problem

Retail businesses generate large volumes of transactional data every day.

Without structured analysis, valuable insights remain hidden:

* Which categories generate the highest revenue?
* Which customers contribute most to sales?
* Which months perform best?
* How does purchasing vary across categories?
* During which shift are most orders placed?

This project answers these questions using SQL.

---

# 🛠 Tech Stack

| Tool            | Purpose                  |
| --------------- | ------------------------ |
| SQL             | Data Cleaning & Analysis |
| MySQL           | Database Management      |
| MySQL Workbench | Query Execution          |
| GitHub          | Portfolio Showcase       |

---

# 📂 Dataset Overview

The dataset contains retail transaction records.

| Column          | Description           |
| --------------- | --------------------- |
| transactions_id | Unique transaction ID |
| sale_date       | Transaction Date      |
| sale_time       | Transaction Time      |
| customer_id     | Customer Identifier   |
| gender          | Customer Gender       |
| age             | Customer Age          |
| category        | Product Category      |
| quantity        | Quantity Purchased    |
| price_per_unit  | Product Price         |
| cogs            | Cost of Goods Sold    |
| total_sale      | Transaction Value     |

---

# 🏗 Database Schema

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
```

---

# 🧹 Data Cleaning

Dataset quality checks performed:

✔ Missing value detection
✔ Null record removal
✔ Data validation
✔ Category verification

### Null Check

```sql
SELECT *
FROM retail_sales
WHERE
sale_date IS NULL
OR sale_time IS NULL
OR customer_id IS NULL
OR gender IS NULL
OR age IS NULL
OR category IS NULL
OR quantity IS NULL
OR price_per_unit IS NULL
OR cogs IS NULL;
```

---

# 📊 Exploratory Data Analysis

### Total Transactions

```sql
SELECT COUNT(*) AS total_transactions
FROM retail_sales;
```

### Result

📌 **Total Transactions: 1,987**

---

### Unique Customers

```sql
SELECT COUNT(DISTINCT customer_id)
FROM retail_sales;
```

---

### Categories

```sql
SELECT DISTINCT category
FROM retail_sales;
```

Output:

* Clothing
* Beauty
* Electronics

---

# 📈 Business Analysis

---

# 1️⃣ Sales on 05-Nov-2022

Retrieve all transactions completed on a specific day.

```sql
SELECT *
FROM retail_sales
WHERE sale_date='2022-11-05';
```

### Insight

Transactions occurred across multiple categories indicating healthy product diversity.

```md
/screenshots/sales_on_date.png
```

---

# 2️⃣ Clothing Transaction Analysis

Retrieve Clothing purchases during November 2022.

```sql
SELECT *
FROM retail_sales
WHERE category='Clothing'
AND quantity > 4
AND sale_date BETWEEN '2022-11-01'
AND '2022-11-30';
```

> Note: Re-run and update the screenshot if previous output does not match query conditions.

### Business Insight

Used to identify high-volume clothing purchases and seasonal demand.

```md
/screenshots/clothing_sales.png
```

---

# 3️⃣ Category Performance Analysis

```sql
SELECT
category,
SUM(total_sale) AS total_sales,
COUNT(*) AS orders
FROM retail_sales
GROUP BY category;
```

## Verified Results

| Category    | Revenue | Orders |
| ----------- | ------: | -----: |
| Electronics | 311,445 |    678 |
| Clothing    | 309,995 |    698 |
| Beauty      | 286,790 |    611 |

### Insight

* Electronics generated the highest revenue.
* Clothing recorded the highest order volume.

```md
/screenshots/category_performance.png
```

---

# 4️⃣ Average Age of Beauty Customers

```sql
SELECT
ROUND(AVG(age),2)
FROM retail_sales
WHERE category='Beauty';
```

### Insight

Beauty customers average approximately **40 years old**, indicating strong engagement among middle-aged consumers.

---

# 5️⃣ High Value Transactions

```sql
SELECT *
FROM retail_sales
WHERE total_sale > 1000;
```

### Insight

High-value purchases reveal premium customer segments.

```md
/screenshots/high_value_sales.png
```

---

# 6️⃣ Gender vs Category Analysis

```sql
SELECT
category,
gender,
COUNT(*) total_transactions
FROM retail_sales
GROUP BY category,gender;
```

### Insight

Evaluates purchasing patterns across customer groups.

```md
/screenshots/gender_category.png
```

---

# 7️⃣ Best Selling Month Analysis ⭐

### Featured SQL Skill → Window Functions

```sql
SELECT *
FROM (
SELECT
YEAR(sale_date) year,
MONTH(sale_date) month,
AVG(total_sale) avg_sale,
RANK() OVER(
PARTITION BY YEAR(sale_date)
ORDER BY AVG(total_sale) DESC
) ranking
FROM retail_sales
GROUP BY 1,2
)t
WHERE ranking=1;
```

### SQL Concepts

✔ Window Functions
✔ Ranking
✔ Aggregations

```md
/screenshots/best_month.png
```

---

# 8️⃣ Top 5 Customers

```sql
SELECT
customer_id,
SUM(total_sale) total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;
```

### Insight

Identifies customers contributing most revenue.

```md
/screenshots/top_customers.png
```

---

# 9️⃣ Unique Customers per Category

```sql
SELECT
category,
COUNT(DISTINCT customer_id)
FROM retail_sales
GROUP BY category;
```

### Insight

Measures customer reach by category.

```md
/screenshots/unique_customers.png
```

---

# 🔟 Shift Analysis using CTE ⭐

### Featured SQL Skill → Common Table Expressions

```sql
WITH hourly_sales AS
(
SELECT *,
CASE
WHEN HOUR(sale_time)<12 THEN 'Morning'
WHEN HOUR(sale_time) BETWEEN 12 AND 17
THEN 'Afternoon'
ELSE 'Evening'
END shift
FROM retail_sales
)

SELECT
shift,
COUNT(*) total_orders
FROM hourly_sales
GROUP BY shift;
```

### Business Insight

Order timing analysis helps understand customer activity periods.

```md
/screenshots/shift_analysis.png
```

---

# 📚 SQL Skills Demonstrated

✅ Data Cleaning
✅ Filtering & Conditional Logic
✅ Aggregate Functions
✅ GROUP BY
✅ DISTINCT
✅ ORDER BY
✅ Date Functions
✅ CASE Statements
✅ Common Table Expressions (CTEs)
✅ Window Functions
✅ Ranking Functions
✅ Business Reporting Queries

---

# 💡 Key Insights

* Total **1,987 retail transactions** analyzed.
* Electronics generated the highest revenue.
* Clothing achieved the highest transaction volume.
* Customer behavior differs across categories.
* Premium purchases indicate high-value customer groups.
* Sales vary by month and time of day.

---

# 🚀 Learning Outcomes

Through this project I strengthened my ability to:

* Design relational databases
* Perform SQL-based exploratory analysis
* Build business reporting queries
* Apply CTEs and Window Functions
* Convert raw data into actionable insights

---

# 📁 Project Structure

```plaintext
Retail-Sales-Analysis/
│
├── screenshots/
├── RetailSalesAnalysis.sql
├── README.md
└── dataset.csv
```

---

# 👩‍💻 Author

**Mansi Sharma**
Aspiring Data Analyst | SQL | Python | Cybersecurity Enthusiast

If you found this project useful, consider giving it a ⭐ on GitHub.

---

### Repository Setup

```bash
git clone <your-repo-link>
cd Retail-Sales-Analysis
```

Run the SQL script and start exploring insights.
