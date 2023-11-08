--Employee Count
SELECT COUNT(emp_no)
FROM hrdata
WHERE education ILIKE 'High school';

--Attrition count
SELECT COUNT(attrition)
FROM hrdata
WHERE attrition ILIKE 'yes';

--Let's identify the different departments in the organization.
--We can later analyze attrition in each department
SELECT DISTINCT department
FROM hrdata;
--Output: HR, Sales, R&D.

--Attrition count in HR
SELECT COUNT(department)
FROM hrdata
WHERE department ILIKE 'HR';
--Total number of Hr employees 63
SELECT SUM(employee_count)
FROM hrdata
WHERE department ILIKE 'hr'AND attrition ILIKE 'yes';
--Total number of attrition employees in Hr 12

--Attrition count in Sales department
SELECT COUNT(department)
FROM hrdata
WHERE department ILIKE 'sales';
--Total number of employees in sales 446
SELECT SUM(employee_count)
FROM hrdata
WHERE department ILIKE 'sales'AND attrition ILIKE 'yes';
--Attrition count in sales is 92

--Attrition count in R&D department
SELECT COUNT(department)
FROM hrdata
WHERE department ILIKE 'r&d';
--Total number of employees in R&D 961
SELECT SUM(employee_count)
FROM hrdata
WHERE department ILIKE 'r&d'AND attrition ILIKE 'yes';
--Attrition count in r&d is 133
--Or as below
SELECT department, COUNT(attrition) attrition_number
FROM hrdata
WHERE attrition ILIKE 'yes'
GROUP BY department
ORDER BY attrition_number DESC;

--Overall Employee Attrition Rate
SELECT ROUND((SELECT COUNT(attrition) 
		FROM hrdata 
		WHERE attrition ILIKE 'yes') / 
		SUM(employee_count) * 100, 2) AS attrition_rate
		FROM hrdata;
--Attrition rate is 16.22%

--Attrition Rate in the Sales Department
SELECT ROUND((SELECT COUNT(attrition) 
		FROM hrdata 
		WHERE attrition ILIKE 'yes' AND department ILIKE 'sales') / 
		SUM(employee_count) * 100, 2) AS attrition_rate
		FROM hrdata
WHERE department ILIKE 'sales';
--Attrition rate in the sales department is at 20.63%

--Attrition rate in the R&D department
SELECT ROUND((SELECT COUNT(attrition) 
		FROM hrdata 
		WHERE attrition ILIKE 'yes' AND department ILIKE 'r&d') / 
		SUM(employee_count) * 100, 2) AS attrition_rate
		FROM hrdata
WHERE department ILIKE 'r&d';
--Attrition rate in the r&d department is at 13.84%

--Attrition rate in the HR department
SELECT ROUND((SELECT COUNT(attrition) 
		FROM hrdata 
		WHERE attrition ILIKE 'yes' AND department ILIKE 'hr') / 
		SUM(employee_count) * 100, 2) AS attrition_rate
		FROM hrdata
WHERE department ILIKE 'hr';
--Attrition rate in the hr department is at 19.05%

--Active Employees
SELECT COUNT(attrition_label)
FROM hrdata
WHERE attrition_label ILIKE 'current%';
--Total Current Employees is 1233
--This can also be calculated as sum of employees subtract total attrition count below
SELECT SUM(employee_count) -
		(SELECT COUNT(attrition)
		FROM hrdata
		WHERE attrition ILIKE 'yes'
		)
FROM hrdata;

--Average Age
SELECT ROUND(AVG(age), 0)
FROM hrdata;
--The average age is 37

--Attrition by Gender
SELECT gender, COUNT(attrition) total_count
FROM hrdata
WHERE attrition ILIKE 'yes'
GROUP BY gender
ORDER BY total_count DESC;
--Male are highest at 150 and female at 87

--Attrition by education
SELECT education, COUNT(attrition) AS total_count
FROM hrdata
WHERE attrition ILIKE 'yes'
GROUP BY education
ORDER BY total_count DESC;

