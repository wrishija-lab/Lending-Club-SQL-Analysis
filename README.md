# Lending Club SQL Analysis

## Project Overview

This project analyzes Lending Club loan data using MySQL to understand
loan performance, borrower characteristics, interest rates, and credit
risk.

## Dataset

-   Source: Lending Club Loan Data, Kaggle
-   Records: 2,260,668 loans
-   Raw columns: 145
-   Raw CSV is not included because of its large file size.

## Tools

-   MySQL
-   MySQL Workbench
-   SQL
-   GitHub

## Business Questions

-   How are loans distributed across repayment statuses?
-   How do credit grades relate to observed charge-off rates?
-   How do income and debt-to-income (DTI) levels relate to loan
    characteristics and observed charge-offs?
-   How do employment, loan purpose, geography, verification status, and
    issue year differ across the portfolio?
-   Which borrower and loan segments show higher observed credit risk?

## Data Preparation

1.  Imported the raw CSV into a staging table, `loan_raw`.
2.  Created a typed analysis table, `loans_clean`.
3.  Converted key financial and borrower fields to numeric types.
4.  Loaded all 2,260,668 records into the cleaned table.
5.  Performed missing-value and data-quality checks.

## Analysis Performed

-   Initial data exploration
-   Loan status distribution
-   Portfolio KPIs
-   Credit grade and risk analysis
-   Borrower income segmentation
-   DTI and credit-risk analysis
-   Employment analysis
-   Loan purpose analysis
-   State-level analysis
-   Issue-year/cohort analysis
-   Grade × income risk segments
-   Term × grade analysis
-   Data-quality validation

## Key Findings

-   The portfolio contains 2.26 million+ loans and approximately \$34.12
    billion in funded amount.
-   Overall observed charge-off rate is approximately 11.88%.
-   Observed charge-off rates vary substantially by credit grade, from
    approximately 3.17% for Grade A to 39.46% for Grade G.
-   Lower-income segments show higher observed charge-off rates than
    higher-income segments in this dataset.
-   DTI segmentation shows differences in observed charge-off rates
    across borrower groups.
-   Verification-status groups also show different observed charge-off
    rates; these are descriptive associations, not causal effects.

## Analytical Caveats

This project uses **observed charge-off rate** rather than interpreting
the measure as lifetime default probability. Loan cohorts have different
maturity periods, so newer issue years have had less time to experience
charge-off. Small groups should also be interpreted cautiously.

## SQL Skills Demonstrated

-   SELECT, WHERE, GROUP BY, ORDER BY
-   COUNT, SUM, AVG
-   CASE WHEN
-   Conditional aggregation
-   ROUND and type conversion
-   Date parsing and year extraction
-   Segmentation and banding
-   Multi-dimensional grouping
-   Data-quality checks
-   Large-data staging and loading
-   Portfolio KPI calculation

## Project Structure

``` text
Lending-Club-SQL-Analysis/
├── README.md
├── documentation/
├── screenshots/
└── SQL/
    └── lending_club_analysis.sql
```

## Portfolio Purpose

This project demonstrates practical SQL, data cleaning, exploratory
analysis, segmentation, and credit-risk analysis using a large
real-world lending dataset.
