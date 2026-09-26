-- ============================================================
-- LENDING CLUB LOAN ANALYSIS
-- SQL DATA ANALYST PORTFOLIO PROJECT
-- ============================================================
-- Objective:
-- Analyze loan performance, borrower characteristics,
-- interest rates, and credit risk using MySQL.
--
-- Dataset:
-- Lending Club Loan Data
--
-- Database: MySQL
-- ============================================================

USE lending_club; 
-- ============================================================
-- 1. INITIAL DATA EXPLORATION
-- ============================================================
-- Check dataset size, sample records, and basic loan status
-- distribution before performing detailed analysis.
-- ============================================================


SELECT COUNT(*) AS total_rows
FROM lending_club.loan_raw;

SELECT
    id,
    member_id,
    loan_amnt,
    funded_amnt,
    funded_amnt_inv,
    term,
    int_rate,
    grade,
    sub_grade,
    emp_length,
    home_ownership,
    annual_inc,
    loan_status,
    purpose,
    addr_state,
    dti
FROM lending_club.loan_raw
LIMIT 10;

SELECT loan_status, COUNT(*) AS number_of_loans FROM lending_club.loan_raw GROUP BY loan_status ORDER BY number_of_loans DESC;

-- ============================================================
-- 2. LOAN STATUS ANALYSIS
-- ============================================================
-- Examine the distribution of loan outcomes and identify
-- the proportion of loans in each repayment status.
-- ============================================================
SELECT
    loan_status,
    COUNT(*) AS number_of_loans,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM lending_club.loan_raw),
        2
    ) AS percentage
FROM lending_club.loan_raw
GROUP BY loan_status
ORDER BY COUNT(*) DESC; 


SELECT
    loan_amnt,
    funded_amnt,
    funded_amnt_inv,
    int_rate,
    installment,
    annual_inc,
    dti,
    delinq_2yrs,
    inq_last_6mths,
    open_acc,
    pub_rec,
    revol_bal,
    revol_util,
    total_acc
FROM lending_club.loan_raw
LIMIT 10;


SELECT
    int_rate,
    COUNT(*) AS number_of_rows
FROM lending_club.loan_raw
GROUP BY int_rate
ORDER BY number_of_rows DESC
LIMIT 20;


CREATE TABLE lending_club.loans_clean (
    loan_key BIGINT AUTO_INCREMENT PRIMARY KEY,

    loan_amnt DECIMAL(12,2),
    funded_amnt DECIMAL(12,2),
    funded_amnt_inv DECIMAL(12,2),

    term VARCHAR(20),
    int_rate DECIMAL(6,2),
    installment DECIMAL(12,2),

    grade VARCHAR(5),
    sub_grade VARCHAR(5),

    emp_title TEXT,
    emp_length VARCHAR(20),

    home_ownership VARCHAR(30),
    annual_inc DECIMAL(15,2),

    verification_status VARCHAR(50),
    issue_d VARCHAR(20),
    loan_status VARCHAR(100),

    purpose VARCHAR(50),
    title VARCHAR(255),
    addr_state VARCHAR(10),

    dti DECIMAL(8,2),

    delinq_2yrs INT,
    inq_last_6mths INT,
    open_acc INT,
    pub_rec INT,
    revol_bal DECIMAL(15,2),
    revol_util DECIMAL(8,2),
    total_acc INT,

    recoveries DECIMAL(12,2),
    collection_recovery_fee DECIMAL(12,2),
    last_pymnt_d VARCHAR(20)
);



SELECT COUNT(*) AS clean_rows
FROM lending_club.loans_clean;

SELECT COUNT(*) AS clean_rows
FROM lending_club.loans_clean;

TRUNCATE TABLE lending_club.loans_clean;



INSERT INTO lending_club.loans_clean (
    loan_amnt,
    funded_amnt,
    funded_amnt_inv,
    term,
    int_rate,
    installment,
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    annual_inc,
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    dti,
    delinq_2yrs,
    inq_last_6mths,
    open_acc,
    pub_rec,
    revol_bal,
    revol_util,
    total_acc,
    recoveries,
    collection_recovery_fee,
    last_pymnt_d
)
SELECT
    CAST(NULLIF(TRIM(loan_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt_inv), '') AS DECIMAL(12,2)),

    term,
    CAST(NULLIF(TRIM(int_rate), '') AS DECIMAL(6,2)),
    CAST(NULLIF(TRIM(installment), '') AS DECIMAL(12,2)),

    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,

    CAST(NULLIF(TRIM(annual_inc), '') AS DECIMAL(15,2)),

    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,

    CAST(NULLIF(TRIM(dti), '') AS DECIMAL(8,2)),

    CAST(NULLIF(TRIM(delinq_2yrs), '') AS SIGNED),
    CAST(NULLIF(TRIM(inq_last_6mths), '') AS SIGNED),
    CAST(NULLIF(TRIM(open_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(pub_rec), '') AS SIGNED),

    CAST(NULLIF(TRIM(revol_bal), '') AS DECIMAL(15,2)),
    CAST(NULLIF(TRIM(revol_util), '') AS DECIMAL(8,2)),

    CAST(NULLIF(TRIM(total_acc), '') AS SIGNED),

    CAST(NULLIF(TRIM(recoveries), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(collection_recovery_fee), '') AS DECIMAL(12,2)),

    last_pymnt_d

FROM lending_club.loan_raw;

TRUNCATE TABLE lending_club.loans_clean;





ALTER TABLE lending_club.loan_raw
ADD COLUMN raw_row_id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
ADD PRIMARY KEY (raw_row_id);




INSERT INTO lending_club.loans_clean (
    loan_amnt,
    funded_amnt,
    funded_amnt_inv,
    term,
    int_rate,
    installment,
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    annual_inc,
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    dti,
    delinq_2yrs,
    inq_last_6mths,
    open_acc,
    pub_rec,
    revol_bal,
    revol_util,
    total_acc,
    recoveries,
    collection_recovery_fee,
    last_pymnt_d
)
SELECT
    CAST(NULLIF(TRIM(loan_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt_inv), '') AS DECIMAL(12,2)),
    term,
    CAST(NULLIF(TRIM(int_rate), '') AS DECIMAL(6,2)),
    CAST(NULLIF(TRIM(installment), '') AS DECIMAL(12,2)),
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    CAST(NULLIF(TRIM(annual_inc), '') AS DECIMAL(15,2)),
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    CAST(NULLIF(TRIM(dti), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(delinq_2yrs), '') AS SIGNED),
    CAST(NULLIF(TRIM(inq_last_6mths), '') AS SIGNED),
    CAST(NULLIF(TRIM(open_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(pub_rec), '') AS SIGNED),
    CAST(NULLIF(TRIM(revol_bal), '') AS DECIMAL(15,2)),
    CAST(NULLIF(TRIM(revol_util), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(total_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(recoveries), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(collection_recovery_fee), '') AS DECIMAL(12,2)),
    last_pymnt_d
FROM lending_club.loan_raw
WHERE raw_row_id BETWEEN 1 AND 100000;




INSERT INTO lending_club.loans_clean (
    loan_amnt,
    funded_amnt,
    funded_amnt_inv,
    term,
    int_rate,
    installment,
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    annual_inc,
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    dti,
    delinq_2yrs,
    inq_last_6mths,
    open_acc,
    pub_rec,
    revol_bal,
    revol_util,
    total_acc,
    recoveries,
    collection_recovery_fee,
    last_pymnt_d
)
SELECT
    CAST(NULLIF(TRIM(loan_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt_inv), '') AS DECIMAL(12,2)),
    term,
    CAST(NULLIF(TRIM(int_rate), '') AS DECIMAL(6,2)),
    CAST(NULLIF(TRIM(installment), '') AS DECIMAL(12,2)),
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    CAST(NULLIF(TRIM(annual_inc), '') AS DECIMAL(15,2)),
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    CAST(NULLIF(TRIM(dti), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(delinq_2yrs), '') AS SIGNED),
    CAST(NULLIF(TRIM(inq_last_6mths), '') AS SIGNED),
    CAST(NULLIF(TRIM(open_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(pub_rec), '') AS SIGNED),
    CAST(NULLIF(TRIM(revol_bal), '') AS DECIMAL(15,2)),
    CAST(NULLIF(TRIM(revol_util), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(total_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(recoveries), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(collection_recovery_fee), '') AS DECIMAL(12,2)),
    last_pymnt_d
FROM lending_club.loan_raw
WHERE raw_row_id BETWEEN 100001 AND 200000;

SELECT COUNT(*) AS clean_rows
FROM lending_club.loans_clean;

INSERT INTO lending_club.loans_clean (
    loan_amnt,
    funded_amnt,
    funded_amnt_inv,
    term,
    int_rate,
    installment,
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    annual_inc,
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    dti,
    delinq_2yrs,
    inq_last_6mths,
    open_acc,
    pub_rec,
    revol_bal,
    revol_util,
    total_acc,
    recoveries,
    collection_recovery_fee,
    last_pymnt_d
)
SELECT
    CAST(NULLIF(TRIM(loan_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt_inv), '') AS DECIMAL(12,2)),
    term,
    CAST(NULLIF(TRIM(int_rate), '') AS DECIMAL(6,2)),
    CAST(NULLIF(TRIM(installment), '') AS DECIMAL(12,2)),
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    CAST(NULLIF(TRIM(annual_inc), '') AS DECIMAL(15,2)),
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    CAST(NULLIF(TRIM(dti), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(delinq_2yrs), '') AS SIGNED),
    CAST(NULLIF(TRIM(inq_last_6mths), '') AS SIGNED),
    CAST(NULLIF(TRIM(open_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(pub_rec), '') AS SIGNED),
    CAST(NULLIF(TRIM(revol_bal), '') AS DECIMAL(15,2)),
    CAST(NULLIF(TRIM(revol_util), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(total_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(recoveries), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(collection_recovery_fee), '') AS DECIMAL(12,2)),
    last_pymnt_d
FROM lending_club.loan_raw
WHERE raw_row_id BETWEEN 200001 AND 300000;




INSERT INTO lending_club.loans_clean (
    loan_amnt,
    funded_amnt,
    funded_amnt_inv,
    term,
    int_rate,
    installment,
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    annual_inc,
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    dti,
    delinq_2yrs,
    inq_last_6mths,
    open_acc,
    pub_rec,
    revol_bal,
    revol_util,
    total_acc,
    recoveries,
    collection_recovery_fee,
    last_pymnt_d
)
SELECT
    CAST(NULLIF(TRIM(loan_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt_inv), '') AS DECIMAL(12,2)),
    term,
    CAST(NULLIF(TRIM(int_rate), '') AS DECIMAL(6,2)),
    CAST(NULLIF(TRIM(installment), '') AS DECIMAL(12,2)),
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    CAST(NULLIF(TRIM(annual_inc), '') AS DECIMAL(15,2)),
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    CAST(NULLIF(TRIM(dti), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(delinq_2yrs), '') AS SIGNED),
    CAST(NULLIF(TRIM(inq_last_6mths), '') AS SIGNED),
    CAST(NULLIF(TRIM(open_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(pub_rec), '') AS SIGNED),
    CAST(NULLIF(TRIM(revol_bal), '') AS DECIMAL(15,2)),
    CAST(NULLIF(TRIM(revol_util), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(total_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(recoveries), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(collection_recovery_fee), '') AS DECIMAL(12,2)),
    last_pymnt_d
FROM lending_club.loan_raw
WHERE raw_row_id BETWEEN 300001 AND 400000;



SELECT COUNT(*) AS clean_rows
FROM lending_club.loans_clean;



INSERT INTO lending_club.loans_clean (
    loan_amnt,
    funded_amnt,
    funded_amnt_inv,
    term,
    int_rate,
    installment,
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    annual_inc,
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    dti,
    delinq_2yrs,
    inq_last_6mths,
    open_acc,
    pub_rec,
    revol_bal,
    revol_util,
    total_acc,
    recoveries,
    collection_recovery_fee,
    last_pymnt_d
)
SELECT
    CAST(NULLIF(TRIM(loan_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt_inv), '') AS DECIMAL(12,2)),
    term,
    CAST(NULLIF(TRIM(int_rate), '') AS DECIMAL(6,2)),
    CAST(NULLIF(TRIM(installment), '') AS DECIMAL(12,2)),
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    CAST(NULLIF(TRIM(annual_inc), '') AS DECIMAL(15,2)),
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    CAST(NULLIF(TRIM(dti), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(delinq_2yrs), '') AS SIGNED),
    CAST(NULLIF(TRIM(inq_last_6mths), '') AS SIGNED),
    CAST(NULLIF(TRIM(open_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(pub_rec), '') AS SIGNED),
    CAST(NULLIF(TRIM(revol_bal), '') AS DECIMAL(15,2)),
    CAST(NULLIF(TRIM(revol_util), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(total_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(recoveries), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(collection_recovery_fee), '') AS DECIMAL(12,2)),
    last_pymnt_d
FROM lending_club.loan_raw
WHERE raw_row_id BETWEEN 300001 AND 400000;


INSERT INTO lending_club.loans_clean (
    loan_amnt,
    funded_amnt,
    funded_amnt_inv,
    term,
    int_rate,
    installment,
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    annual_inc,
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    dti,
    delinq_2yrs,
    inq_last_6mths,
    open_acc,
    pub_rec,
    revol_bal,
    revol_util,
    total_acc,
    recoveries,
    collection_recovery_fee,
    last_pymnt_d
)
SELECT
    CAST(NULLIF(TRIM(loan_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt_inv), '') AS DECIMAL(12,2)),
    term,
    CAST(NULLIF(TRIM(int_rate), '') AS DECIMAL(6,2)),
    CAST(NULLIF(TRIM(installment), '') AS DECIMAL(12,2)),
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    CAST(NULLIF(TRIM(annual_inc), '') AS DECIMAL(15,2)),
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    CAST(NULLIF(TRIM(dti), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(delinq_2yrs), '') AS SIGNED),
    CAST(NULLIF(TRIM(inq_last_6mths), '') AS SIGNED),
    CAST(NULLIF(TRIM(open_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(pub_rec), '') AS SIGNED),
    CAST(NULLIF(TRIM(revol_bal), '') AS DECIMAL(15,2)),
    CAST(NULLIF(TRIM(revol_util), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(total_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(recoveries), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(collection_recovery_fee), '') AS DECIMAL(12,2)),
    last_pymnt_d
FROM lending_club.loan_raw
WHERE raw_row_id BETWEEN 500001 AND 600000;

SELECT COUNT(*) AS clean_rows
FROM lending_club.loans_clean;

INSERT INTO lending_club.loans_clean (
    loan_amnt,
    funded_amnt,
    funded_amnt_inv,
    term,
    int_rate,
    installment,
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    annual_inc,
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    dti,
    delinq_2yrs,
    inq_last_6mths,
    open_acc,
    pub_rec,
    revol_bal,
    revol_util,
    total_acc,
    recoveries,
    collection_recovery_fee,
    last_pymnt_d
)
SELECT
    CAST(NULLIF(TRIM(loan_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt_inv), '') AS DECIMAL(12,2)),
    term,
    CAST(NULLIF(TRIM(int_rate), '') AS DECIMAL(6,2)),
    CAST(NULLIF(TRIM(installment), '') AS DECIMAL(12,2)),
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    CAST(NULLIF(TRIM(annual_inc), '') AS DECIMAL(15,2)),
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    CAST(NULLIF(TRIM(dti), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(delinq_2yrs), '') AS SIGNED),
    CAST(NULLIF(TRIM(inq_last_6mths), '') AS SIGNED),
    CAST(NULLIF(TRIM(open_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(pub_rec), '') AS SIGNED),
    CAST(NULLIF(TRIM(revol_bal), '') AS DECIMAL(15,2)),
    CAST(NULLIF(TRIM(revol_util), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(total_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(recoveries), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(collection_recovery_fee), '') AS DECIMAL(12,2)),
    last_pymnt_d
FROM lending_club.loan_raw
WHERE raw_row_id BETWEEN 600001 AND 700000;

SELECT COUNT(*) AS clean_rows
FROM lending_club.loans_clean;

INSERT INTO lending_club.loans_clean (
    loan_amnt,
    funded_amnt,
    funded_amnt_inv,
    term,
    int_rate,
    installment,
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    annual_inc,
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    dti,
    delinq_2yrs,
    inq_last_6mths,
    open_acc,
    pub_rec,
    revol_bal,
    revol_util,
    total_acc,
    recoveries,
    collection_recovery_fee,
    last_pymnt_d
)
SELECT
    CAST(NULLIF(TRIM(loan_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt_inv), '') AS DECIMAL(12,2)),
    term,
    CAST(NULLIF(TRIM(int_rate), '') AS DECIMAL(6,2)),
    CAST(NULLIF(TRIM(installment), '') AS DECIMAL(12,2)),
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    CAST(NULLIF(TRIM(annual_inc), '') AS DECIMAL(15,2)),
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    CAST(NULLIF(TRIM(dti), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(delinq_2yrs), '') AS SIGNED),
    CAST(NULLIF(TRIM(inq_last_6mths), '') AS SIGNED),
    CAST(NULLIF(TRIM(open_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(pub_rec), '') AS SIGNED),
    CAST(NULLIF(TRIM(revol_bal), '') AS DECIMAL(15,2)),
    CAST(NULLIF(TRIM(revol_util), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(total_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(recoveries), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(collection_recovery_fee), '') AS DECIMAL(12,2)),
    last_pymnt_d
FROM lending_club.loan_raw
WHERE raw_row_id BETWEEN 700001 AND 800000;

SELECT COUNT(*) AS clean_rows
FROM lending_club.loans_clean;

SELECT COUNT(*) AS clean_rows
FROM lending_club.loans_clean;

INSERT INTO lending_club.loans_clean (
    loan_amnt,
    funded_amnt,
    funded_amnt_inv,
    term,
    int_rate,
    installment,
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    annual_inc,
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    dti,
    delinq_2yrs,
    inq_last_6mths,
    open_acc,
    pub_rec,
    revol_bal,
    revol_util,
    total_acc,
    recoveries,
    collection_recovery_fee,
    last_pymnt_d
)
SELECT
    CAST(NULLIF(TRIM(loan_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt_inv), '') AS DECIMAL(12,2)),
    term,
    CAST(NULLIF(TRIM(int_rate), '') AS DECIMAL(6,2)),
    CAST(NULLIF(TRIM(installment), '') AS DECIMAL(12,2)),
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    CAST(NULLIF(TRIM(annual_inc), '') AS DECIMAL(15,2)),
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    CAST(NULLIF(TRIM(dti), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(delinq_2yrs), '') AS SIGNED),
    CAST(NULLIF(TRIM(inq_last_6mths), '') AS SIGNED),
    CAST(NULLIF(TRIM(open_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(pub_rec), '') AS SIGNED),
    CAST(NULLIF(TRIM(revol_bal), '') AS DECIMAL(15,2)),
    CAST(NULLIF(TRIM(revol_util), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(total_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(recoveries), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(collection_recovery_fee), '') AS DECIMAL(12,2)),
    last_pymnt_d
FROM lending_club.loan_raw
WHERE raw_row_id BETWEEN 800001 AND 900000;


SELECT COUNT(*) AS clean_rows
FROM lending_club.loans_clean;


INSERT INTO lending_club.loans_clean (
    loan_amnt,
    funded_amnt,
    funded_amnt_inv,
    term,
    int_rate,
    installment,
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    annual_inc,
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    dti,
    delinq_2yrs,
    inq_last_6mths,
    open_acc,
    pub_rec,
    revol_bal,
    revol_util,
    total_acc,
    recoveries,
    collection_recovery_fee,
    last_pymnt_d
)
SELECT
    CAST(NULLIF(TRIM(loan_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt_inv), '') AS DECIMAL(12,2)),
    term,
    CAST(NULLIF(TRIM(int_rate), '') AS DECIMAL(6,2)),
    CAST(NULLIF(TRIM(installment), '') AS DECIMAL(12,2)),
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    CAST(NULLIF(TRIM(annual_inc), '') AS DECIMAL(15,2)),
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    CAST(NULLIF(TRIM(dti), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(delinq_2yrs), '') AS SIGNED),
    CAST(NULLIF(TRIM(inq_last_6mths), '') AS SIGNED),
    CAST(NULLIF(TRIM(open_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(pub_rec), '') AS SIGNED),
    CAST(NULLIF(TRIM(revol_bal), '') AS DECIMAL(15,2)),
    CAST(NULLIF(TRIM(revol_util), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(total_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(recoveries), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(collection_recovery_fee), '') AS DECIMAL(12,2)),
    last_pymnt_d
FROM lending_club.loan_raw
WHERE raw_row_id BETWEEN 900001 AND 1000000; 

SELECT COUNT(*) AS clean_rows
FROM lending_club.loans_clean;

SELECT COUNT(*) AS clean_rows
FROM lending_club.loans_clean;



INSERT INTO lending_club.loans_clean (
    loan_amnt,
    funded_amnt,
    funded_amnt_inv,
    term,
    int_rate,
    installment,
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    annual_inc,
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    dti,
    delinq_2yrs,
    inq_last_6mths,
    open_acc,
    pub_rec,
    revol_bal,
    revol_util,
    total_acc,
    recoveries,
    collection_recovery_fee,
    last_pymnt_d
)
SELECT
    CAST(NULLIF(TRIM(loan_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt_inv), '') AS DECIMAL(12,2)),
    term,
    CAST(NULLIF(TRIM(int_rate), '') AS DECIMAL(6,2)),
    CAST(NULLIF(TRIM(installment), '') AS DECIMAL(12,2)),
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    CAST(NULLIF(TRIM(annual_inc), '') AS DECIMAL(15,2)),
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    CAST(NULLIF(TRIM(dti), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(delinq_2yrs), '') AS SIGNED),
    CAST(NULLIF(TRIM(inq_last_6mths), '') AS SIGNED),
    CAST(NULLIF(TRIM(open_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(pub_rec), '') AS SIGNED),
    CAST(NULLIF(TRIM(revol_bal), '') AS DECIMAL(15,2)),
    CAST(NULLIF(TRIM(revol_util), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(total_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(recoveries), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(collection_recovery_fee), '') AS DECIMAL(12,2)),
    last_pymnt_d
FROM lending_club.loan_raw
WHERE raw_row_id BETWEEN 1000001 AND 1100000; 


INSERT INTO lending_club.loans_clean (
    loan_amnt,
    funded_amnt,
    funded_amnt_inv,
    term,
    int_rate,
    installment,
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    annual_inc,
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    dti,
    delinq_2yrs,
    inq_last_6mths,
    open_acc,
    pub_rec,
    revol_bal,
    revol_util,
    total_acc,
    recoveries,
    collection_recovery_fee,
    last_pymnt_d
)
SELECT
    CAST(NULLIF(TRIM(loan_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt_inv), '') AS DECIMAL(12,2)),
    term,
    CAST(NULLIF(TRIM(int_rate), '') AS DECIMAL(6,2)),
    CAST(NULLIF(TRIM(installment), '') AS DECIMAL(12,2)),
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    CAST(NULLIF(TRIM(annual_inc), '') AS DECIMAL(15,2)),
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    CAST(NULLIF(TRIM(dti), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(delinq_2yrs), '') AS SIGNED),
    CAST(NULLIF(TRIM(inq_last_6mths), '') AS SIGNED),
    CAST(NULLIF(TRIM(open_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(pub_rec), '') AS SIGNED),
    CAST(NULLIF(TRIM(revol_bal), '') AS DECIMAL(15,2)),
    CAST(NULLIF(TRIM(revol_util), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(total_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(recoveries), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(collection_recovery_fee), '') AS DECIMAL(12,2)),
    last_pymnt_d
FROM lending_club.loan_raw
WHERE raw_row_id BETWEEN 1300001 AND 1400000; 



SELECT COUNT(*) AS clean_rows
FROM lending_club.loans_clean;



INSERT INTO lending_club.loans_clean (
    loan_amnt,
    funded_amnt,
    funded_amnt_inv,
    term,
    int_rate,
    installment,
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    annual_inc,
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    dti,
    delinq_2yrs,
    inq_last_6mths,
    open_acc,
    pub_rec,
    revol_bal,
    revol_util,
    total_acc,
    recoveries,
    collection_recovery_fee,
    last_pymnt_d
)
SELECT
    CAST(NULLIF(TRIM(loan_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt_inv), '') AS DECIMAL(12,2)),
    term,
    CAST(NULLIF(TRIM(int_rate), '') AS DECIMAL(6,2)),
    CAST(NULLIF(TRIM(installment), '') AS DECIMAL(12,2)),
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    CAST(NULLIF(TRIM(annual_inc), '') AS DECIMAL(15,2)),
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    CAST(NULLIF(TRIM(dti), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(delinq_2yrs), '') AS SIGNED),
    CAST(NULLIF(TRIM(inq_last_6mths), '') AS SIGNED),
    CAST(NULLIF(TRIM(open_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(pub_rec), '') AS SIGNED),
    CAST(NULLIF(TRIM(revol_bal), '') AS DECIMAL(15,2)),
    CAST(NULLIF(TRIM(revol_util), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(total_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(recoveries), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(collection_recovery_fee), '') AS DECIMAL(12,2)),
    last_pymnt_d
FROM lending_club.loan_raw
WHERE raw_row_id BETWEEN 1600001 AND 1700000;




INSERT INTO lending_club.loans_clean (
    loan_amnt,
    funded_amnt,
    funded_amnt_inv,
    term,
    int_rate,
    installment,
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    annual_inc,
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    dti,
    delinq_2yrs,
    inq_last_6mths,
    open_acc,
    pub_rec,
    revol_bal,
    revol_util,
    total_acc,
    recoveries,
    collection_recovery_fee,
    last_pymnt_d
)
SELECT
    CAST(NULLIF(TRIM(loan_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt_inv), '') AS DECIMAL(12,2)),
    term,
    CAST(NULLIF(TRIM(int_rate), '') AS DECIMAL(6,2)),
    CAST(NULLIF(TRIM(installment), '') AS DECIMAL(12,2)),
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    CAST(NULLIF(TRIM(annual_inc), '') AS DECIMAL(15,2)),
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    CAST(NULLIF(TRIM(dti), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(delinq_2yrs), '') AS SIGNED),
    CAST(NULLIF(TRIM(inq_last_6mths), '') AS SIGNED),
    CAST(NULLIF(TRIM(open_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(pub_rec), '') AS SIGNED),
    CAST(NULLIF(TRIM(revol_bal), '') AS DECIMAL(15,2)),
    CAST(NULLIF(TRIM(revol_util), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(total_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(recoveries), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(collection_recovery_fee), '') AS DECIMAL(12,2)),
    last_pymnt_d
FROM lending_club.loan_raw
WHERE raw_row_id BETWEEN 1700001 AND 1800000;

SELECT COUNT(*) AS clean_rows
FROM lending_club.loans_clean;

INSERT INTO lending_club.loans_clean (
    loan_amnt,
    funded_amnt,
    funded_amnt_inv,
    term,
    int_rate,
    installment,
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    annual_inc,
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    dti,
    delinq_2yrs,
    inq_last_6mths,
    open_acc,
    pub_rec,
    revol_bal,
    revol_util,
    total_acc,
    recoveries,
    collection_recovery_fee,
    last_pymnt_d
)
SELECT
    CAST(NULLIF(TRIM(loan_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt_inv), '') AS DECIMAL(12,2)),
    term,
    CAST(NULLIF(TRIM(int_rate), '') AS DECIMAL(6,2)),
    CAST(NULLIF(TRIM(installment), '') AS DECIMAL(12,2)),
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    CAST(NULLIF(TRIM(annual_inc), '') AS DECIMAL(15,2)),
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    CAST(NULLIF(TRIM(dti), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(delinq_2yrs), '') AS SIGNED),
    CAST(NULLIF(TRIM(inq_last_6mths), '') AS SIGNED),
    CAST(NULLIF(TRIM(open_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(pub_rec), '') AS SIGNED),
    CAST(NULLIF(TRIM(revol_bal), '') AS DECIMAL(15,2)),
    CAST(NULLIF(TRIM(revol_util), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(total_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(recoveries), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(collection_recovery_fee), '') AS DECIMAL(12,2)),
    last_pymnt_d
FROM lending_club.loan_raw
WHERE raw_row_id BETWEEN 1900001 AND 2000000;


SELECT COUNT(*) AS clean_rows
FROM lending_club.loans_clean;

INSERT INTO lending_club.loans_clean (
    loan_amnt,
    funded_amnt,
    funded_amnt_inv,
    term,
    int_rate,
    installment,
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    annual_inc,
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    dti,
    delinq_2yrs,
    inq_last_6mths,
    open_acc,
    pub_rec,
    revol_bal,
    revol_util,
    total_acc,
    recoveries,
    collection_recovery_fee,
    last_pymnt_d
)
SELECT
    CAST(NULLIF(TRIM(loan_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt_inv), '') AS DECIMAL(12,2)),
    term,
    CAST(NULLIF(TRIM(int_rate), '') AS DECIMAL(6,2)),
    CAST(NULLIF(TRIM(installment), '') AS DECIMAL(12,2)),
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    CAST(NULLIF(TRIM(annual_inc), '') AS DECIMAL(15,2)),
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    CAST(NULLIF(TRIM(dti), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(delinq_2yrs), '') AS SIGNED),
    CAST(NULLIF(TRIM(inq_last_6mths), '') AS SIGNED),
    CAST(NULLIF(TRIM(open_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(pub_rec), '') AS SIGNED),
    CAST(NULLIF(TRIM(revol_bal), '') AS DECIMAL(15,2)),
    CAST(NULLIF(TRIM(revol_util), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(total_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(recoveries), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(collection_recovery_fee), '') AS DECIMAL(12,2)),
    last_pymnt_d
FROM lending_club.loan_raw
WHERE raw_row_id BETWEEN 2000001 AND 2100000;

SELECT COUNT(*) AS clean_rows
FROM lending_club.loans_clean;


INSERT INTO lending_club.loans_clean (
    loan_amnt,
    funded_amnt,
    funded_amnt_inv,
    term,
    int_rate,
    installment,
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    annual_inc,
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    dti,
    delinq_2yrs,
    inq_last_6mths,
    open_acc,
    pub_rec,
    revol_bal,
    revol_util,
    total_acc,
    recoveries,
    collection_recovery_fee,
    last_pymnt_d
)
SELECT
    CAST(NULLIF(TRIM(loan_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt_inv), '') AS DECIMAL(12,2)),
    term,
    CAST(NULLIF(TRIM(int_rate), '') AS DECIMAL(6,2)),
    CAST(NULLIF(TRIM(installment), '') AS DECIMAL(12,2)),
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    CAST(NULLIF(TRIM(annual_inc), '') AS DECIMAL(15,2)),
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    CAST(NULLIF(TRIM(dti), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(delinq_2yrs), '') AS SIGNED),
    CAST(NULLIF(TRIM(inq_last_6mths), '') AS SIGNED),
    CAST(NULLIF(TRIM(open_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(pub_rec), '') AS SIGNED),
    CAST(NULLIF(TRIM(revol_bal), '') AS DECIMAL(15,2)),
    CAST(NULLIF(TRIM(revol_util), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(total_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(recoveries), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(collection_recovery_fee), '') AS DECIMAL(12,2)),
    last_pymnt_d
FROM lending_club.loan_raw
WHERE raw_row_id BETWEEN 2200001 AND 2260668;


SELECT COUNT(*) AS clean_rows
FROM lending_club.loans_clean;




INSERT INTO lending_club.loans_clean (
    loan_amnt,
    funded_amnt,
    funded_amnt_inv,
    term,
    int_rate,
    installment,
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    annual_inc,
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    dti,
    delinq_2yrs,
    inq_last_6mths,
    open_acc,
    pub_rec,
    revol_bal,
    revol_util,
    total_acc,
    recoveries,
    collection_recovery_fee,
    last_pymnt_d
)
SELECT
    CAST(NULLIF(TRIM(loan_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(funded_amnt_inv), '') AS DECIMAL(12,2)),
    term,
    CAST(NULLIF(TRIM(int_rate), '') AS DECIMAL(6,2)),
    CAST(NULLIF(TRIM(installment), '') AS DECIMAL(12,2)),
    grade,
    sub_grade,
    emp_title,
    emp_length,
    home_ownership,
    CAST(NULLIF(TRIM(annual_inc), '') AS DECIMAL(15,2)),
    verification_status,
    issue_d,
    loan_status,
    purpose,
    title,
    addr_state,
    CAST(NULLIF(TRIM(dti), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(delinq_2yrs), '') AS SIGNED),
    CAST(NULLIF(TRIM(inq_last_6mths), '') AS SIGNED),
    CAST(NULLIF(TRIM(open_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(pub_rec), '') AS SIGNED),
    CAST(NULLIF(TRIM(revol_bal), '') AS DECIMAL(15,2)),
    CAST(NULLIF(TRIM(revol_util), '') AS DECIMAL(8,2)),
    CAST(NULLIF(TRIM(total_acc), '') AS SIGNED),
    CAST(NULLIF(TRIM(recoveries), '') AS DECIMAL(12,2)),
    CAST(NULLIF(TRIM(collection_recovery_fee), '') AS DECIMAL(12,2)),
    last_pymnt_d
FROM lending_club.loan_raw
WHERE raw_row_id BETWEEN 2100001 AND 2200000;





SELECT *
FROM lending_club.loans_clean
LIMIT 10;



SELECT COUNT(*) AS clean_rows
FROM lending_club.loans_clean;

SELECT COUNT(*) AS clean_rows
FROM lending_club.loans_clean;

 SELECT
    loan_status,
    COUNT(*) AS total_loans,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM lending_club.loans_clean),
        2
    ) AS percentage
FROM lending_club.loans_clean
GROUP BY loan_status
ORDER BY total_loans DESC;


SELECT
    loan_status,
    COUNT(*) AS total_loans,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM lending_club.loans_clean),
        2
    ) AS percentage
FROM lending_club.loans_clean
GROUP BY loan_status
ORDER BY total_loans DESC;



SELECT
    grade,
    COUNT(*) AS total_loans,
    ROUND(AVG(loan_amnt), 2) AS avg_loan_amount,
    ROUND(AVG(int_rate), 2) AS avg_interest_rate
FROM lending_club.loans_clean
GROUP BY grade
ORDER BY grade;


SELECT
    grade,
    COUNT(*) AS total_loans,
    SUM(CASE
        WHEN loan_status IN (
            'Charged Off',
            'Default',
            'Does not meet the credit policy. Status:Charged Off'
        )
        THEN 1 ELSE 0
    END) AS charged_off_loans,
    ROUND(
        SUM(CASE
            WHEN loan_status IN (
                'Charged Off',
                'Default',
                'Does not meet the credit policy. Status:Charged Off'
            )
            THEN 1 ELSE 0
        END) * 100.0 / COUNT(*),
        2
    ) AS charge_off_rate
FROM lending_club.loans_clean
GROUP BY grade
ORDER BY grade;

SELECT
    purpose,
    COUNT(*) AS total_loans,
    ROUND(AVG(loan_amnt), 2) AS avg_loan_amount,
    ROUND(AVG(int_rate), 2) AS avg_interest_rate,
    SUM(
        CASE
            WHEN loan_status IN (
                'Charged Off',
                'Default',
                'Does not meet the credit policy. Status:Charged Off'
            )
            THEN 1
            ELSE 0
        END
    ) AS charged_off_loans,
    ROUND(
        SUM(
            CASE
                WHEN loan_status IN (
                    'Charged Off',
                    'Default',
                    'Does not meet the credit policy. Status:Charged Off'
                )
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS charge_off_rate
FROM lending_club.loans_clean
GROUP BY purpose
ORDER BY total_loans DESC;
-- ============================================================
-- 6. DTI & CREDIT RISK ANALYSIS
-- ============================================================
-- Segment borrowers by debt-to-income ratio to examine
-- differences in loan characteristics and observed
-- charge-off rates across DTI groups.
-- ============================================================
SELECT
    CASE
        WHEN dti < 10 THEN 'Below 10'
        WHEN dti < 20 THEN '10-20'
        WHEN dti < 30 THEN '20-30'
        WHEN dti < 40 THEN '30-40'
        ELSE '40+'
    END AS dti_band,

    COUNT(*) AS total_loans,

    ROUND(AVG(annual_inc), 2) AS avg_income,

    ROUND(AVG(int_rate), 2) AS avg_interest_rate,

    SUM(
        CASE
            WHEN loan_status IN (
                'Charged Off',
                'Default',
                'Does not meet the credit policy. Status:Charged Off'
            )
            THEN 1
            ELSE 0
        END
    ) AS charged_off_loans,

    ROUND(
        SUM(
            CASE
                WHEN loan_status IN (
                    'Charged Off',
                    'Default',
                    'Does not meet the credit policy. Status:Charged Off'
                )
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS charge_off_rate

FROM lending_club.loans_clean

WHERE dti IS NOT NULL

GROUP BY dti_band

ORDER BY
    CASE dti_band
        WHEN 'Below 10' THEN 1
        WHEN '10-20' THEN 2
        WHEN '20-30' THEN 3
        WHEN '30-40' THEN 4
        WHEN '40+' THEN 5
    END;
    
    SELECT
    CASE
        WHEN annual_inc < 30000 THEN 'Below 30K'
        WHEN annual_inc < 50000 THEN '30K-50K'
        WHEN annual_inc < 75000 THEN '50K-75K'
        WHEN annual_inc < 100000 THEN '75K-100K'
        WHEN annual_inc < 150000 THEN '100K-150K'
        ELSE '150K+'
    END AS income_band,

    COUNT(*) AS total_loans,

    ROUND(AVG(loan_amnt), 2) AS avg_loan_amount,

    ROUND(AVG(int_rate), 2) AS avg_interest_rate,

    ROUND(AVG(dti), 2) AS avg_dti,

    SUM(
        CASE
            WHEN loan_status IN (
                'Charged Off',
                'Default',
                'Does not meet the credit policy. Status:Charged Off'
            )
            THEN 1
            ELSE 0
        END
    ) AS charged_off_loans,

    ROUND(
        SUM(
            CASE
                WHEN loan_status IN (
                    'Charged Off',
                    'Default',
                    'Does not meet the credit policy. Status:Charged Off'
                )
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS charge_off_rate

FROM lending_club.loans_clean

WHERE annual_inc IS NOT NULL

GROUP BY income_band

ORDER BY
    CASE income_band
        WHEN 'Below 30K' THEN 1
        WHEN '30K-50K' THEN 2
        WHEN '50K-75K' THEN 3
        WHEN '75K-100K' THEN 4
        WHEN '100K-150K' THEN 5
        WHEN '150K+' THEN 6
    END;



SELECT
    grade,

    CASE
        WHEN dti < 10 THEN 'Below 10'
        WHEN dti < 20 THEN '10-20'
        WHEN dti < 30 THEN '20-30'
        WHEN dti < 40 THEN '30-40'
        ELSE '40+'
    END AS dti_band,

    COUNT(*) AS total_loans,

    SUM(
        CASE
            WHEN loan_status IN (
                'Charged Off',
                'Default',
                'Does not meet the credit policy. Status:Charged Off'
            )
            THEN 1
            ELSE 0
        END
    ) AS charged_off_loans,

    ROUND(
        SUM(
            CASE
                WHEN loan_status IN (
                    'Charged Off',
                    'Default',
                    'Does not meet the credit policy. Status:Charged Off'
                )
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS charge_off_rate

FROM lending_club.loans_clean

WHERE dti IS NOT NULL

GROUP BY
    grade,
    dti_band

ORDER BY
    grade,
    CASE dti_band
        WHEN 'Below 10' THEN 1
        WHEN '10-20' THEN 2
        WHEN '20-30' THEN 3
        WHEN '30-40' THEN 4
        WHEN '40+' THEN 5
    END;
    
    
    
    
    SELECT
    addr_state AS state,
    COUNT(*) AS total_loans,
    ROUND(AVG(loan_amnt), 2) AS avg_loan_amount,
    ROUND(AVG(int_rate), 2) AS avg_interest_rate,

    SUM(
        CASE
            WHEN loan_status IN (
                'Charged Off',
                'Default',
                'Does not meet the credit policy. Status:Charged Off'
            )
            THEN 1
            ELSE 0
        END
    ) AS charged_off_loans,

    ROUND(
        SUM(
            CASE
                WHEN loan_status IN (
                    'Charged Off',
                    'Default',
                    'Does not meet the credit policy. Status:Charged Off'
                )
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS charge_off_rate

FROM lending_club.loans_clean

WHERE addr_state IS NOT NULL
  AND addr_state <> ''

GROUP BY addr_state

HAVING COUNT(*) >= 1000

ORDER BY charge_off_rate DESC;

SELECT
    YEAR(STR_TO_DATE(issue_d, '%b-%Y')) AS issue_year,
    COUNT(*) AS total_loans,
    ROUND(AVG(loan_amnt), 2) AS avg_loan_amount,
    ROUND(AVG(int_rate), 2) AS avg_interest_rate,
    ROUND(SUM(funded_amnt), 2) AS total_funded_amount
FROM lending_club.loans_clean
WHERE issue_d IS NOT NULL
  AND issue_d <> ''
GROUP BY issue_year
ORDER BY issue_year;





SELECT
    issue_d,
    COUNT(*) AS number_of_loans
FROM lending_club.loans_clean
GROUP BY issue_d
ORDER BY number_of_loans DESC
LIMIT 20;



SELECT
    issue_d,
    STR_TO_DATE(issue_d, '%b-%Y') AS converted_date,
    YEAR(STR_TO_DATE(issue_d, '%b-%Y')) AS issue_year
FROM lending_club.loans_clean
WHERE issue_d IS NOT NULL
  AND issue_d <> ''
LIMIT 10;

SELECT
    issue_d,
    STR_TO_DATE(
        CONCAT('01-', TRIM(issue_d)),
        '%d-%b-%Y'
    ) AS converted_date,
    YEAR(
        STR_TO_DATE(
            CONCAT('01-', TRIM(issue_d)),
            '%d-%b-%Y'
        )
    ) AS issue_year
FROM lending_club.loans_clean
WHERE issue_d IS NOT NULL
  AND TRIM(issue_d) <> ''
LIMIT 10;



SELECT
    YEAR(
        STR_TO_DATE(
            CONCAT('01-', TRIM(issue_d)),
            '%d-%b-%Y'
        )
    ) AS issue_year,
    COUNT(*) AS total_loans,
    ROUND(AVG(loan_amnt), 2) AS avg_loan_amount,
    ROUND(AVG(int_rate), 2) AS avg_interest_rate,
    ROUND(SUM(funded_amnt), 2) AS total_funded_amount
FROM lending_club.loans_clean
WHERE issue_d IS NOT NULL
  AND TRIM(issue_d) <> ''
GROUP BY issue_year
ORDER BY issue_year;




SELECT
    YEAR(
        STR_TO_DATE(
            CONCAT('01-', TRIM(issue_d)),
            '%d-%b-%Y'
        )
    ) AS issue_year,

    COUNT(*) AS total_loans,

    SUM(
        CASE
            WHEN loan_status IN (
                'Charged Off',
                'Default',
                'Does not meet the credit policy. Status:Charged Off'
            )
            THEN 1
            ELSE 0
        END
    ) AS charged_off_loans,

    ROUND(
        SUM(
            CASE
                WHEN loan_status IN (
                    'Charged Off',
                    'Default',
                    'Does not meet the credit policy. Status:Charged Off'
                )
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS charge_off_rate

FROM lending_club.loans_clean

WHERE issue_d IS NOT NULL
  AND TRIM(issue_d) <> ''

GROUP BY issue_year
ORDER BY issue_year;


-- ============================================================
-- 7. EMPLOYMENT ANALYSIS
-- ============================================================
-- Analyze loan characteristics and observed charge-off rates
-- across borrower employment-length categories.
-- ============================================================


SELECT
    emp_length,
    COUNT(*) AS total_loans,
    ROUND(AVG(loan_amnt), 2) AS avg_loan_amount,
    ROUND(AVG(int_rate), 2) AS avg_interest_rate,

    SUM(
        CASE
            WHEN loan_status IN (
                'Charged Off',
                'Default',
                'Does not meet the credit policy. Status:Charged Off'
            )
            THEN 1
            ELSE 0
        END
    ) AS charged_off_loans,

    ROUND(
        SUM(
            CASE
                WHEN loan_status IN (
                    'Charged Off',
                    'Default',
                    'Does not meet the credit policy. Status:Charged Off'
                )
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS charge_off_rate

FROM lending_club.loans_clean

WHERE emp_length IS NOT NULL
  AND TRIM(emp_length) <> ''

GROUP BY emp_length
ORDER BY total_loans DESC;


SELECT
    emp_length,
    COUNT(*) AS total_loans,
    ROUND(AVG(loan_amnt), 2) AS avg_loan_amount,
    ROUND(AVG(int_rate), 2) AS avg_interest_rate,

    SUM(
        CASE
            WHEN loan_status IN (
                'Charged Off',
                'Default',
                'Does not meet the credit policy. Status:Charged Off'
            )
            THEN 1
            ELSE 0
        END
    ) AS charged_off_loans,

    ROUND(
        SUM(
            CASE
                WHEN loan_status IN (
                    'Charged Off',
                    'Default',
                    'Does not meet the credit policy. Status:Charged Off'
                )
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS charge_off_rate

FROM lending_club.loans_clean

WHERE emp_length IS NOT NULL
  AND TRIM(emp_length) <> ''

GROUP BY emp_length
ORDER BY total_loans DESC;


USE lending_club;

SELECT 1;


SET GLOBAL net_read_timeout = 120;
SET GLOBAL net_write_timeout = 120;




USE lending_club;

SELECT 1;


SELECT
    emp_length,
    COUNT(*) AS total_loans,
    ROUND(AVG(loan_amnt), 2) AS avg_loan_amount,
    ROUND(AVG(int_rate), 2) AS avg_interest_rate,
    SUM(
        CASE
            WHEN loan_status IN (
                'Charged Off',
                'Default',
                'Does not meet the credit policy. Status:Charged Off'
            )
            THEN 1
            ELSE 0
        END
    ) AS charged_off_loans,
    ROUND(
        SUM(
            CASE
                WHEN loan_status IN (
                    'Charged Off',
                    'Default',
                    'Does not meet the credit policy. Status:Charged Off'
                )
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS charge_off_rate
FROM lending_club.loans_clean
WHERE emp_length IS NOT NULL
  AND TRIM(emp_length) <> ''
GROUP BY emp_length;





SELECT
    verification_status,
    COUNT(*) AS total_loans,
    ROUND(AVG(loan_amnt), 2) AS avg_loan_amount,
    ROUND(AVG(int_rate), 2) AS avg_interest_rate,
    SUM(
        CASE
            WHEN loan_status IN (
                'Charged Off',
                'Default',
                'Does not meet the credit policy. Status:Charged Off'
            )
            THEN 1
            ELSE 0
        END
    ) AS charged_off_loans,
    ROUND(
        SUM(
            CASE
                WHEN loan_status IN (
                    'Charged Off',
                    'Default',
                    'Does not meet the credit policy. Status:Charged Off'
                )
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS charge_off_rate
FROM lending_club.loans_clean
WHERE verification_status IS NOT NULL
  AND TRIM(verification_status) <> ''
GROUP BY verification_status;

SELECT COUNT(*) AS total_clean_rows
FROM lending_club.loans_clean;

-- ============================================================
-- 3. PORTFOLIO OVERVIEW
-- ============================================================
-- Calculate key portfolio-level metrics including loan volume,
-- funded amount, average loan size, interest rate, and
-- observed charge-off rate.
-- ============================================================
SELECT
    COUNT(*) AS total_loans,

    ROUND(SUM(funded_amnt), 2) AS total_funded_amount,

    ROUND(AVG(loan_amnt), 2) AS avg_loan_amount,

    ROUND(AVG(int_rate), 2) AS avg_interest_rate,

    SUM(
        CASE
            WHEN loan_status IN (
                'Charged Off',
                'Default',
                'Does not meet the credit policy. Status:Charged Off'
            )
            THEN 1
            ELSE 0
        END
    ) AS charged_off_loans,

    ROUND(
        SUM(
            CASE
                WHEN loan_status IN (
                    'Charged Off',
                    'Default',
                    'Does not meet the credit policy. Status:Charged Off'
                )
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS overall_charge_off_rate

FROM lending_club.loans_clean;


-- ============================================================
-- 4. CREDIT GRADE & RISK ANALYSIS
-- ============================================================
-- Analyze loan volume, average loan size, interest rates,
-- and observed charge-off rates across credit grades.
-- ============================================================


SELECT
    grade,
    CASE
        WHEN annual_inc < 30000 THEN 'Below 30K'
        WHEN annual_inc < 50000 THEN '30K-50K'
        WHEN annual_inc < 75000 THEN '50K-75K'
        WHEN annual_inc < 100000 THEN '75K-100K'
        WHEN annual_inc < 150000 THEN '100K-150K'
        ELSE '150K+'
    END AS income_band,

    COUNT(*) AS total_loans,

    ROUND(AVG(loan_amnt), 2) AS avg_loan_amount,

    ROUND(AVG(int_rate), 2) AS avg_interest_rate,

    SUM(
        CASE
            WHEN loan_status IN (
                'Charged Off',
                'Default',
                'Does not meet the credit policy. Status:Charged Off'
            )
            THEN 1
            ELSE 0
        END
    ) AS charged_off_loans,

    ROUND(
        SUM(
            CASE
                WHEN loan_status IN (
                    'Charged Off',
                    'Default',
                    'Does not meet the credit policy. Status:Charged Off'
                )
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS charge_off_rate

FROM lending_club.loans_clean

WHERE annual_inc IS NOT NULL
  AND annual_inc > 0
  AND grade IS NOT NULL

GROUP BY
    grade,
    CASE
        WHEN annual_inc < 30000 THEN 'Below 30K'
        WHEN annual_inc < 50000 THEN '30K-50K'
        WHEN annual_inc < 75000 THEN '50K-75K'
        WHEN annual_inc < 100000 THEN '75K-100K'
        WHEN annual_inc < 150000 THEN '100K-150K'
        ELSE '150K+'
    END;
    
   -- ============================================================
-- 5. BORROWER INCOME ANALYSIS
-- ============================================================
-- Segment borrowers by annual income to examine differences
-- in loan size, interest rates, DTI, and observed charge-off
-- rates across income groups.
-- ============================================================ 
    
    
    WITH risk_segments AS (
    SELECT
        grade,
        CASE
            WHEN annual_inc < 30000 THEN 'Below 30K'
            WHEN annual_inc < 50000 THEN '30K-50K'
            WHEN annual_inc < 75000 THEN '50K-75K'
            WHEN annual_inc < 100000 THEN '75K-100K'
            WHEN annual_inc < 150000 THEN '100K-150K'
            ELSE '150K+'
        END AS income_band,
        COUNT(*) AS total_loans,
        SUM(
            CASE
                WHEN loan_status IN (
                    'Charged Off',
                    'Default',
                    'Does not meet the credit policy. Status:Charged Off'
                )
                THEN 1
                ELSE 0
            END
        ) AS charged_off_loans
    FROM lending_club.loans_clean
    WHERE annual_inc IS NOT NULL
      AND annual_inc > 0
      AND grade IS NOT NULL
    GROUP BY
        grade,
        CASE
            WHEN annual_inc < 30000 THEN 'Below 30K'
            WHEN annual_inc < 50000 THEN '30K-50K'
            WHEN annual_inc < 75000 THEN '50K-75K'
            WHEN annual_inc < 100000 THEN '75K-100K'
            WHEN annual_inc < 150000 THEN '100K-150K'
            ELSE '150K+'
        END
)

SELECT
    grade,
    income_band,
    total_loans,
    charged_off_loans,
    ROUND(charged_off_loans * 100.0 / total_loans, 2) AS charge_off_rate
FROM risk_segments
WHERE total_loans >= 1000
ORDER BY charge_off_rate DESC
LIMIT 10;

SELECT
    term,
    grade,
    COUNT(*) AS total_loans,
    ROUND(AVG(loan_amnt), 2) AS avg_loan_amount,
    ROUND(AVG(int_rate), 2) AS avg_interest_rate,

    SUM(
        CASE
            WHEN loan_status IN (
                'Charged Off',
                'Default',
                'Does not meet the credit policy. Status:Charged Off'
            )
            THEN 1
            ELSE 0
        END
    ) AS charged_off_loans,

    ROUND(
        SUM(
            CASE
                WHEN loan_status IN (
                    'Charged Off',
                    'Default',
                    'Does not meet the credit policy. Status:Charged Off'
                )
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS charge_off_rate

FROM lending_club.loans_clean

WHERE term IS NOT NULL
  AND TRIM(term) <> ''
  AND grade IS NOT NULL

GROUP BY term, grade;
    
    SELECT
    COUNT(*) AS total_rows,

    SUM(CASE WHEN loan_amnt IS NULL THEN 1 ELSE 0 END) AS missing_loan_amount,
    SUM(CASE WHEN funded_amnt IS NULL THEN 1 ELSE 0 END) AS missing_funded_amount,
    SUM(CASE WHEN int_rate IS NULL THEN 1 ELSE 0 END) AS missing_interest_rate,
    SUM(CASE WHEN grade IS NULL OR TRIM(grade) = '' THEN 1 ELSE 0 END) AS missing_grade,
    SUM(CASE WHEN annual_inc IS NULL THEN 1 ELSE 0 END) AS missing_income,
    SUM(CASE WHEN dti IS NULL THEN 1 ELSE 0 END) AS missing_dti,
    SUM(CASE WHEN loan_status IS NULL OR TRIM(loan_status) = '' THEN 1 ELSE 0 END) AS missing_loan_status,
    SUM(CASE WHEN issue_d IS NULL OR TRIM(issue_d) = '' THEN 1 ELSE 0 END) AS missing_issue_date,
    SUM(CASE WHEN home_ownership IS NULL OR TRIM(home_ownership) = '' THEN 1 ELSE 0 END) AS missing_home_ownership,
    SUM(CASE WHEN verification_status IS NULL OR TRIM(verification_status) = '' THEN 1 ELSE 0 END) AS missing_verification

FROM lending_club.loans_clean;


-- ============================================================
-- 8. HOME OWNERSHIP ANALYSIS
-- ============================================================
-- Analyze loan characteristics and observed charge-off rates
-- across borrower home ownership categories.
-- ============================================================

SELECT
    home_ownership,
    COUNT(*) AS total_loans,
    ROUND(AVG(loan_amnt), 2) AS avg_loan_amount,
    ROUND(AVG(int_rate), 2) AS avg_interest_rate,
    SUM(
        CASE
            WHEN loan_status IN (
                'Charged Off',
                'Default',
                'Does not meet the credit policy. Status:Charged Off'
            )
            THEN 1
            ELSE 0
        END
    ) AS charged_off_loans,
    ROUND(
        100.0 * SUM(
            CASE
                WHEN loan_status IN (
                    'Charged Off',
                    'Default',
                    'Does not meet the credit policy. Status:Charged Off'
                )
                THEN 1
                ELSE 0
            END
        ) / COUNT(*),
        2
    ) AS observed_charge_off_rate
FROM loans_clean
GROUP BY home_ownership
ORDER BY observed_charge_off_rate DESC;
