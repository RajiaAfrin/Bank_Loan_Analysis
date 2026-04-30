--Total Loan Application
SELECT COUNT(id) AS Total_Loan_Application
FROM bank_loan_data

--Month to Date Loan Application
SELECT COUNT(id) AS MTD_Total_Loan_Application
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12
  AND EXTRACT(YEAR FROM issue_date) = 2021;
  
--Month on Month Loan Application ((MTD-PMTD)/PMTD = MoM)
SELECT COUNT(id) AS PMTD_Total_Loan_Application
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11
  AND EXTRACT(YEAR FROM issue_date) = 2021;
  
--Total Funded Amount
SELECT SUM(loan_amount) As MTD_Total_Funded_Amount FROM bank_loan_data

--Month to Date Funded Amount
SELECT SUM(loan_amount) As MTD_Total_Funded_Amount FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12
  AND EXTRACT(YEAR FROM issue_date) = 2021;
  
--Month on Month Funded Amount((MTD-PMTD)/PMTD = MoM)
SELECT SUM(loan_amount) As PMTD_Total_Funded_Amount FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11
  AND EXTRACT(YEAR FROM issue_date) = 2021;
  
--Total Amount Received
SELECT SUM(total_payment) As Total_Amount_received FROM bank_loan_data

--Month to Date Amount Recieved
SELECT SUM(total_payment) As MTD_Total_Amount_received FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12
  AND EXTRACT(YEAR FROM issue_date) = 2021;

--Month on month Amount Recieved((MTD-PMTD)/PMTD = MoM)
SELECT SUM(total_payment) As PMTD_Total_Amount_received FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11
  AND EXTRACT(YEAR FROM issue_date) = 2021;
  
--Average interest rate
SELECT ROUND (AVG(int_rate) , 4) * 100 AS Avg_Interest_Rate FROM bank_loan_data

--Month to Date Average interest rate
SELECT ROUND (AVG(int_rate) , 4) * 100 AS MTD_Avg_Interest_Rate FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12
  AND EXTRACT(YEAR FROM issue_date) = 2021;
  
--Month on Month Average interest rate((MTD-PMTD)/PMTD = MoM)
SELECT ROUND (AVG(int_rate) , 4) * 100 AS PMTD_Avg_Interest_Rate FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11
  AND EXTRACT(YEAR FROM issue_date) = 2021;
  
--Average DTI
SELECT ROUND (AVG(dti),4) * 100 AS Avg_DTI FROM bank_loan_data

--Month to Date Average DTI
SELECT ROUND (AVG(dti),4) * 100 AS MTD_Avg_DTI FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12
  AND EXTRACT(YEAR FROM issue_date) = 2021;
  
--Month on Month Average DTI ((MTD-PMTD)/PMTD = MoM)
SELECT ROUND (AVG(dti),4) * 100 AS MTD_Avg_DTI FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 11
  AND EXTRACT(YEAR FROM issue_date) = 2021;
  
--Loan Status
SELECT loan_status FROM bank_loan_data

--Good Loan
SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0)
	/
	COUNT(id) AS Good_Loan_Data
From bank_loan_data

--Good Loan Application
SELECT COUNT(id) From bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status ='Current'

--Good Loan  Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_funded_amount FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status ='Current'

--Good Loan Recieved Amount
SELECT SUM(total_payment) AS Good_Loan_recieved_amount FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status ='Current'

--Bad Loan
SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0)
	/
	COUNT(id) AS Bad_Loan_Data
From bank_loan_data

--Bad Loan Application
SELECT COUNT(id) From bank_loan_data
WHERE loan_status = 'Charged Off'

--Bad Loan  Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_funded_amount FROM bank_loan_data
WHERE loan_status = 'Charged Off'

--Bad Loan Recieved Amount
SELECT SUM(total_payment) AS Bad_Loan_recieved_amount FROM bank_loan_data
WHERE loan_status = 'Charged Off'

--Loan Status Grid View
SELECT
     loan_status,
     COUNT (id) AS Total_Loan_Applications,
     SUM(total_payment) AS Total_Amount_Received,
     SUM(loan_amount) AS Total_Funded_Amount,
     AVG (int_rate * 100) As Interest_Rate,
     AVG (dti * 100) AS DTI
FROM
     bank_loan_data
GROUP BY
     loan_status
	 
--Month to Date
SELECT loan_status,
      SUM (total_payment) AS MTD_Total_Amount_Received,
      SUM (loan_amount) AS MTD_Total_Funded_Amount
FROM bank_loan_data
WHERE EXTRACT(MONTH FROM issue_date) = 12
GROUP BY loan_status 

--Monthly Trends by Issue Date
SELECT
    EXTRACT(MONTH FROM issue_date) AS month_number,
    TO_CHAR(issue_date, 'Month') AS month_name,
    COUNT(id) AS total_loan_application,
    SUM(loan_amount) AS total_funded_amount,
    SUM(total_payment) AS total_received_amount
FROM bank_loan_data
GROUP BY
    EXTRACT(MONTH FROM issue_date),
    TO_CHAR(issue_date, 'Month')
ORDER BY
    EXTRACT(MONTH FROM issue_date);
	
--Regional analysis by state
SELECT
    address_state,
    COUNT(id) AS total_loan_application,
    SUM(loan_amount) AS total_funded_amount,
    SUM(total_payment) AS total_received_amount
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state

--Loan Term Analysis
SELECT
    term,
    COUNT(id) AS total_loan_application,
    SUM(loan_amount) AS total_funded_amount,
    SUM(total_payment) AS total_received_amount
FROM bank_loan_data
GROUP BY term
ORDER BY term

--Employee Length Analysis
SELECT
    emp_length,
    COUNT(id) AS total_loan_application,
    SUM(loan_amount) AS total_funded_amount,
    SUM(total_payment) AS total_received_amount
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length

-- Loan Purpose Breakdown
SELECT
    purpose,
    COUNT(id) AS total_loan_application,
    SUM(loan_amount) AS total_funded_amount,
    SUM(total_payment) AS total_received_amount
FROM bank_loan_data
GROUP BY purpose
ORDER BY COUNT(id) DESC

--Home ownership Analysis
SELECT
    home_ownership,
    COUNT(id) AS total_loan_application,
    SUM(loan_amount) AS total_funded_amount,
    SUM(total_payment) AS total_received_amount
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY COUNT(id) DESC



