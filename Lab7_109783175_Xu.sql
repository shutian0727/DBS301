-- ***********************
-- Name: Shutian XU
-- ID: 109783175
-- Date: NOV 1ST 2018
-- Purpose: Lab 7 DBS301 SAB
-- ***********************

--Q1
--The HR department needs a list of Department IDs for departments that do not conbtain the job ID of ST_CLERK> 
--Use a set operator to create this report.
--SOLUTION:
SELECT DISTINCT DEPARTMENT_ID FROM DEPARTMENTS
MINUS
SELECT DISTINCT DEPARTMENT_ID FROM EMPLOYEES
WHERE UPPER(JOB_ID) LIKE 'ST_CLERK'
ORDER BY DEPARTMENT_ID;

--Q2
--Same department requests a list of countries that have no departments located in them. 
--Display country ID and the country name. Use SET operators.
--SOLUTION:
SELECT COUNTRY_ID, COUNTRY_NAME FROM 
(SELECT DISTINCT COUNTRY_ID FROM COUNTRIES
MINUS
SELECT COUNTRY_ID FROM LOCATIONS) JOIN COUNTRIES USING (COUNTRY_ID);


--Q3
--The Vice President needs very quickly a list of departments 10, 50, 20 in that order. 
--job and department ID are to be displayed.
--SOLUTION:
SELECT JOB_ID, DEPARTMENT_ID FROM EMPLOYEES WHERE DEPARTMENT_ID = 10
UNION
SELECT JOB_ID, DEPARTMENT_ID FROM EMPLOYEES WHERE DEPARTMENT_ID = 50
UNION ALL
SELECT JOB_ID, DEPARTMENT_ID FROM EMPLOYEES WHERE DEPARTMENT_ID = 20;

--Q4
--Create a statement that lists the employeeIDs and JobIDs of those employees 
--who currently have a job title that is the same as their job title 
--when they were initially hired by the company
--that is, they changed jobs but have now gone back to doing their original job).
--SOLUTION:
SELECT EMPLOYEE_ID, JOB_ID FROM EMPLOYEES
INTERSECT
SELECT EMPLOYEE_ID, JOB_ID FROM(
SELECT EMPLOYEE_ID, MIN(START_DATE)
FROM JOB_HISTORY
GROUP BY EMPLOYEE_ID) JOIN JOB_HISTORY USING (EMPLOYEE_ID);


--Q5
--The HR department needs a SINGLE report with the following specifications:
--a.Last name and department ID of all employees regardless of whether they belong to a department or not.
--b.Department ID and department name of all departments regardless of whether they have employees in them or not.
--SOLUTION:
SELECT LAST_NAME,DEPARTMENT_ID,NULL AS DEPARTMENT_NAME FROM EMPLOYEES
UNION
SELECT NULL AS LAST_NAME, DEPARTMENT_ID, DEPARTMENT_NAME FROM DEPARTMENTS;









