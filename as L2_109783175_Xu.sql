-- ***********************
-- Name: Shutian Xu
-- ID: 109783175
-- Date: 13 Sep 2018
-- Purpose: Lab 2 DBS301 
-- ***********************
-- Q1. Display the employee_id, last name and salary of employees earning in the range of $9,000 to $11,000.  Sort the output by top salaries first and then by last name.
-- Q1 SOLUTION --
SELECT employee_id, last_name, salary
FROM employees
WHERE salary BETWEEN 9000 and 15000
ORDER BY salary DESC, last_name;

-- Q2. Modify previous query (#1) so that additional condition is to display only if they work as Programmers or Sales Representatives. 
-- Use same sorting as before
-- Q2 SOLUTION --
SELECT employee_id, last_name, salary
FROM employees
WHERE job_id in ('IT_PROG', 'SA_REP') AND salary BETWEEN 9000 AND 15000
ORDER BY salary DESC, last_name;

-- Q3.The Human Resources department wants to find high salary and low salary employees. 
-- Modify previous query (#2) so that it displays the same job titles but for people who earn outside the given salary range from question 1.
-- Use same sorting as before.
-- Q3 SOLUTION --
SELECT employee_id, last_name, salary
FROM employees
WHERE job_id in ('IT_PROG', 'SA_REP') AND salary NOT BETWEEN 9000 AND 15000
ORDER BY salary DESC, last_name;

-- Q4.The company needs a list of long term employees, in order to give them a thank you dinner. 
-- Display the last name, job_id and salary of employees hired before 1998. 
-- List the most recently hired employees first.
-- Q4 SOLUTION --
SELECT LAST_NAME, JOB_ID, TO_CHAR(SALARY, '$999,999.99') AS SALARY
FROM EMPLOYEES
WHERE HIRE_DATE < TO_DATE('01011998','ddmmyyyy')
ORDER BY HIRE_DATE DESC;

-- Q5.Modify previous query (#4) so that it displays only employees earning more than $10,000. 
-- List the output by job title alphabetically and then by highest paid employees.
-- Q5 SOLUTION --
SELECT LAST_NAME, JOB_ID, TO_CHAR(SALARY, '$999,999.99') AS SALARY
FROM EMPLOYEES
WHERE HIRE_DATE < TO_DATE('01011998','ddmmyyyy') AND SALARY > 10000
ORDER BY HIRE_DATE DESC;

-- Q6.Display the job titles and full names of employees whose first name contains an ‘e’ or ‘E’ anywhere. 
-- Q6 Results:
--Display the job titles and full names of employees whose first name contains an ‘e’ or ‘E’ anywhere. The output should look like:
--Job Title	Full name
--------------------------------------
--AD_VP	Neena 	Kochhar
--	    … more rows
-- Q6 SOLUTION --
SELECT job_id AS "Job Title", first_name||' '||last_name AS "Full name"
FROM employees
WHERE first_name LIKE '%e%'
OR first_name LIKE 'E%';

-- Q7.Create a report to display last name, salary, and commission percent for all employees that earn a commission
-- Q7 SOLUTION --
SELECT last_name, salary, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL;

-- Q8.Do the same as question 7, but put the report in order of descending salaries
-- Q8 SOLUTION --
SELECT last_name, salary, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY SALARY DESC;

-- Q9.Do the same as 8, but use a numeric value instead of a column name to do the sorting.
-- Q9 SOLUTION --
SELECT last_name, salary, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY 2 DESC;





