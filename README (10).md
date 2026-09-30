# Day 14 – SQL CTE Analysis

## Project Overview

This project analyzes the **Northwind database** using **Common Table Expressions (CTEs)** in SQL Server.

The objective is to understand how CTEs can break complex SQL analysis into smaller, readable steps and support business-focused analysis.

## Tools Used

- SQL Server Management Studio (SSMS)
- SQL Server
- Northwind Database

## Analysis Performed

The project contains 10 SQL analyses:

1. Customers with more than 5 orders
2. Total sales per product
3. Customers with more than 10 orders
4. Total sales per employee
5. Total sales per category
6. Monthly sales analysis
7. Customer sales ranking
8. Customers with sales above the average
9. Products with sales above the average
10. Employee performance compared with average sales

## Key Findings

- SAVEA had the highest number of orders among the analyzed customers, with 31 orders.
- Product ID 38 generated the highest total sales at approximately 141,396.74.
- Margaret Peacock recorded the highest employee sales at approximately 232,890.85.
- Beverages was the highest-selling category at approximately 267,868.18.
- Among the months shown in the analysis, January 1997 had the highest sales at approximately 61,258.07.
- QUICK-Stop ranked first in total customer sales at approximately 110,277.30.
- Average sales per customer were approximately 14,222.39.
- Average sales per product were approximately 16,438.87.
- Average employee sales were approximately 140,643.67.

## SQL Concepts Used

- Common Table Expressions (CTEs)
- Multiple CTEs
- `SUM()`
- `COUNT()`
- `AVG()`
- `GROUP BY`
- `WHERE`
- `ORDER BY`
- `JOIN`
- `CROSS JOIN`
- `CASE`
- `RANK()` window function
- Multi-step SQL analysis

## Project Structure

```text
SQL-CTE-Analysis/
│
├── SQL_CTE_Analysis.sql
├── Day_14_SQL_CTE_Analysis_Findings.docx
└── README.md
```

## Conclusion

This project demonstrates how CTEs can make SQL queries easier to understand and organize. The analysis identified customer activity, product and category sales, employee performance, customer rankings, and sales trends.

The project also strengthened practical SQL skills including joins, aggregations, window functions, filtering, and multi-step CTE analysis.
