# SQL Data Analytics Portfolio

A collection of SQL projects focused on business-oriented data analysis
using Google BigQuery.

The projects demonstrate practical skills in data transformation,
aggregation, customer analysis, email campaign analytics, revenue
analysis and analytical SQL.

## Projects

### 01. Email Campaign Performance

**Business question:**  
How does email campaign performance differ across operating systems?

The analysis compares email engagement across different operating systems
and calculates the number of sent, opened and visited emails.

Key metrics:
- Sent messages
- Open Rate
- Click Rate
- Click-to-Open Rate (CTOR)

**SQL skills:** JOIN, LEFT JOIN, CTE, COUNT(DISTINCT), GROUP BY,
SAFE_DIVIDE, calculated metrics.

---

### 02. Sales Performance by Country and Device

**Business question:**  
Which countries and devices generate the most revenue?

The analysis evaluates sales performance across countries and device types.
It calculates purchase sessions, total revenue, average revenue per purchase
session and revenue share.

The results are ranked by revenue to identify the strongest
country-device segments.

**SQL skills:** JOIN, GROUP BY, SUM, COUNT(DISTINCT), CTE,
SAFE_DIVIDE, window functions, RANK.

---

### 03. Customer Email Engagement Analysis

**Business question:**  
How engaged are customers with email campaigns?

Customers are analyzed based on their email interactions. An engagement
score is calculated using Open Rate and Click Rate, after which customers
are divided into three engagement segments:

- High engagement
- Medium engagement
- Low engagement

The final output compares the size and average email performance of
each segment.

**SQL skills:** JOIN, LEFT JOIN, CTE, COUNT(DISTINCT), CASE WHEN,
NTILE, window functions, aggregation and customer segmentation.

---

### 04. Country Performance Ranking

**Business question:**  
Which countries are leaders in account creation and email activity?

The analysis combines account and email metrics, calculates country-level
totals and ranks countries by the number of accounts and sent emails.

The final result contains countries that rank in the TOP-10 by at least
one of these metrics.

**SQL skills:** CTE, JOIN, UNION ALL, aggregate functions,
window functions, SUM() OVER, PARTITION BY, DENSE_RANK.

---

## SQL Skills

- Data aggregation
- JOIN / LEFT JOIN
- GROUP BY
- COUNT(DISTINCT)
- SUM / AVG
- CASE WHEN
- CTEs
- UNION ALL
- Window functions
- RANK / DENSE_RANK
- NTILE
- PARTITION BY
- Calculated metrics
- Customer segmentation
- Revenue analysis
- Email campaign analytics

## Tools

- Google BigQuery
- SQL
- GitHub
