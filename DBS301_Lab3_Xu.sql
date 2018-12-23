-------------------------------------------------------
-- Lab 3 Week 3 Solution files
-- Created by: Clint MacDonald
-- May 18, 2017
-- Purpose: Lab 3 - Week 3 DBS301
-- Description: To learn advanced use of the SELECT statement in Oracle SQL
-----------------------------------------------------------------

-- BASIC SELECT IN ORDER TO SEE THE DATA TO UNDERSTAND WHAT IT LOOKS LIKE
SELECT * FROM employees;
-----------------------------------------------------------------

-----------------------------------------------------------------
-- Question 1
-- Write a query to display the tomorrow�s date in the following format:
--     September 28th of year 2016
--     Your result will depend on the day when you RUN/EXECUTE this query.
--     Label the column Tomorrow.
SELECT to_char(sysdate + 1,'Month') || to_char(sysdate + 1,'DD') || 'th of the year ' || to_char(sysdate + 1, 'YYYY') AS "Tomorrow" FROM dual;
-- OR 
SELECT to_char(sysdate , 'Month ddth "of year" yyyy') AS "Tomorrow" FROM dual;
SELECT to_char(sysdate + 1, 'fmMonth ddth "of year" yyyy') AS "Tomorrow" FROM dual;
-- Advanced
DEFINE tomorrow datetime = sysdate + 1;
SELECT to_char(&tomorrow,'Month') || to_char(&tomorrow,'D') || 'th of the year ' || to_char(&tomorrow, 'YYYY') AS "Tomorrow" FROM dual;
UNDEFINE tomorrow;


-----------------------------------------------------------------
-- Question 2
-- For each employee in departments 20, 50 and 60 display last name, first name, salary, and salary increased by 5% and expressed as a whole number. 
-- Label the column Good Salary. 
-- Also add a column that subtracts the old salary from the new salary and multiplies by 12. 
-- Label the column "Annual Pay Increase".

SELECT  last_name AS "Last Name",
        first_name AS "First Name",
        to_char(salary,'$999,999') AS "Salary",
        to_char(ROUND(salary * 1.05, 0),'$999,999') AS "Good Salary",
        to_char((ROUND(salary * 1.05, 0) - salary) * 12,'$999,999') AS "Annual Pay Increase"
    FROM employees
    WHERE department_id IN (20, 50, 60);

-----------------------------------------------------------------
-- Question 3
-- Write a query that displays the employee�s Full Name and Job Title in the 
-- following format:

-- DAVIES, CURTIS is ST_CLERK 

-- Only employees whose last name ends with S and first name starts with C or K.
-- Give this column an appropriate label like Person and Job
-- Sort the result by the employees� last names.

SELECT UPPER(last_name || ', ' || first_name) || ' is ' || UPPER(job_id) AS "Employee Jobs"
    FROM employees
    WHERE UPPER(last_name) LIKE '%S' AND (UPPER(first_name) LIKE 'C%' OR UPPER(first_name) LIKE 'K%')
    ORDER BY last_name;
----------------------------------------------------------------
-- Question 4
-- For each employee hired before 1992, display the employee�s last name, 
-- hire date and calculate the number of YEARS between TODAY and the date the 
-- employee was hired. Label the column Years worked. 

-- Order your results by the number of years employed. 

-- Round the number of years employed up to the closest whole number.

SELECT  last_name AS "Last Name", 
        hire_date AS "Hire Date", 
        ROUND(((sysdate-hire_date)/365.25),0) AS "Years Worked"
    FROM employees
    WHERE hire_date < to_date('19920101','yyyymmdd')
    ORDER BY "Years Worked";

SELECT  last_name AS "Last Name", 
        hire_date AS "Hire Date",
        ROUND(months_between(sysdate,hire_date)/12,0) AS "Years Worked"
    FROM employees
    WHERE hire_date < to_date('19920101','yyyymmdd')
    ORDER BY "Years Worked";
-----------------------------------------------------------------
-- Question 5
-- Create a query that displays the city names, country codes and state province 
-- names, but only for those cities that starts with S and has at least 8 
-- characters in their name. If city does not have a province name assigned, 
-- then put Unknown Province.  Be cautious of case sensitivity!

SELECT  city AS "City",
        country_id AS "Country",
        NVL(state_province, 'Unknown Province') AS "Province"
    FROM locations
    WHERE UPPER(city) LIKE 'S%' AND LENGTH(city) >= 8;


-----------------------------------------------------------------
-- Question 6
-- Display each employee�s last name, hire date, and salary review date, which 
-- is the first Thursday after a year of service, but only for those hired 
-- after 1997.
-- Label the column REVIEW DAY. 
-- Format the dates to appear in the format similar to 
-- TUESDAY, August the Thirty-First of year 1998
-- Sort by review date 

SELECT  last_name AS "Last Name",
        hire_date AS "Hire Date",
        TO_CHAR ( NEXT_DAY ( add_months(HIRE_DATE,12), 'Thursday' ), 'DAY, Month "the" ddspth "of year" yyyy' )  AS "Review Date"
    FROM employees
    WHERE hire_date >= to_date('19970101','yyyymmdd')
    ORDER BY hire_date;
        
-- OR
SELECT  last_name AS "Last Name",
        hire_date AS "Hire Date",
        TO_CHAR ( NEXT_DAY ( ADD_MONTHS(HIRE_DATE,12), 'Thursday' ), 'fmDAY, Month "the" Ddspth "of year" yyyy' )  AS "Review Date"
    FROM employees
    WHERE hire_date >= to_date('19970101','yyyymmdd')
    ORDER BY hire_date;