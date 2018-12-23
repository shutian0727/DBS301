-- ***********************
-- Name: Shutian XU
-- ID: 109783175
-- Date: NOV 12Th 2018
-- Purpose: Lab 8 DBS301 SAB
-- ***********************

--Q1
--Display the names of the employees whose salary is the same as the lowest salaried employee in any department.
--SOLUTION:
 SELECT FIRST_NAME||' '|| LAST_NAME, SALARY
 FROM EMPLOYEES
 WHERE SALARY IN ( SELECT MIN(salary) 
                 FROM EMPLOYEES
                 GROUP BY DEPARTMENT_ID);
                              
--Q2
--Display the names of the employee(s) whose salary is the lowest in each department.
SELECT e.FIRST_NAME||' '|| e.LAST_NAME, a.MINSALARY, e.DEPARTMENT_ID
FROM EMPLOYEES e
JOIN (SELECT MIN(SALARY) AS MINSALARY,DEPARTMENT_ID
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID) a
on e.DEPARTMENT_ID = a.DEPARTMENT_ID AND e.salary = a.MINSALARY
ORDER BY DEPARTMENT_ID;
                              
--Q3
--Give each of the employees in question 2 a $100 bonus.
SELECT e.FIRST_NAME||' '|| e.LAST_NAME, a.MINSALARY+100 AS BONUS, e.DEPARTMENT_ID
FROM EMPLOYEES e
JOIN (SELECT MIN(SALARY) AS MINSALARY,DEPARTMENT_ID
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID) a
on e.DEPARTMENT_ID = a.DEPARTMENT_ID AND e.salary = a.MINSALARY;

--Q4
--Create a view named ALLEMPS that consists of all employees 
--includes employee_id, last_name, salary, department_id, department_name, city and country (if applicable)
CREATE VIEW "ALLEMPS" AS( 
    SELECT EMPLOYEE_ID, LAST_NAME, SALARY, DEPARTMENT_ID, DEPARTMENT_NAME, CITY,COUNTRY_NAME
    FROM EMPLOYEES JOIN DEPARTMENTS USING (DEPARTMENT_ID)
    JOIN LOCATIONS USING (LOCATION_ID)
    JOIN COUNTRIES USING (COUNTRY_ID));
    SELECT * FROM ALLEMPS;
    
--Q5
--Use the ALLEMPS view to:
--a.	Display the employee_id, last_name, salary and city for all employees
--b.	Display the total salary of all employees by city
--c.	Increase the salary of the lowest paid employee(s) in each department by 100
--d.	What happens if you try to insert an employee by providing values for all columns in this view?
--e.	Delete the employee named Vargas. Did it work? Show proof.
--a.
SELECT EMPLOYEE_ID, LAST_NAME, SALARY, CITY FROM ALLEMPS;
--b.
SELECT SUM(SALARY), CITY FROM ALLEMPS
GROUP BY CITY;
--C.
UPDATE ALLEMPS
SET SALARY=SALARY+100
WHERE (SALARY, DEPARTMENT_ID) IN(
SELECT MIN(SALARY),DEPARTMENT_ID FROM ALLEMPS
GROUP BY DEPARTMENT_ID);
--d.
INSERT INTO ALLEMPS VALUES('124','TYLER','7100','60','IT','SOUTHLAKE','UNITED STATES OF AMERICA');
--e.
DELETE FROM ALLEMPS WHERE LAST_NAME = 'Vargas';

--Q6
--Create a view named ALLDEPTS that consists of all departments and 
--includes department_id, department_name, city and country (if applicable)
--SOLUTION
CREATE OR REPLACE VIEW "ALLDEPTS" AS
SELECT DEPARTMENT_ID, DEPARTMENT_NAME,CITY, C.COUNTRY_ID, COUNTRY_NAME
FROM DEPARTMENTS D LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID LEFT JOIN COUNTRIES C
ON L.COUNTRY_ID = C.COUNTRY_ID;
 
--Q7
--Use the ALLDEPTS view to:
--a.For all departments display the department_id, name and city
--b.For each city that has departments located in it display the number of departments by city
--SOLUTION
--a.
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, CITY FROM ALLDEPTS
WHERE DEPARTMENT_ID IS NOT NULL;
--b.
SELECT CITY, COUNT(DEPARTMENT_ID) AS "NUMBER OF DEPARTMENTS"
FROM ALLEMPS
GROUP BY CITY
HAVING COUNT(DEPARTMENT_ID) > 0;

--Q8
--Create a view called ALLDEPTSUMM that consists of all departments and includes for each department: 
--department_id, department_name, number of employees, number of salaried employees,total salary of all employees. 
--Number of Salaried must be different from number of employees. The difference is some get commission.
--SOLUTION
CREATE OR REPLACE VIEW "ALLDEPTSUMM" AS
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, COUNT(EMPLOYEE_ID) AS "NUMBER OF EMPLOYEES", COUNT(COMMISSION_PCT) AS "NUMBER OF SALARIED EMPLOYEES",
SUM(SALARY) AS "TOTAL SALARY OF ALL EMPLOYEES" FROM EMPLOYEES FULL OUTER JOIN DEPARTMENTS USING (DEPARTMENT_ID)
GROUP BY DEPARTMENT_ID,DEPARTMENT_NAME;
SELECT * FROM ALLDEPTSUMM;
-- Q9
--Use the ALLDEPTSUMM view to display department name and number of employees for departments that have more than the 
--average number of employees 
--SOLUTION
SELECT DEPARTMENT_NAME, "NUMBER OF EMPLOYEES"
FROM ALLDEPTSUMM
WHERE "NUMBER OF EMPLOYEES">(SELECT SUM("NUMBER OF EMPLOYEES")/COUNT(DEPARTMENT_ID) 
FROM ALLDEPTSUMM);


-- Q10
--A)Use the GRANT statement to allow another student (Neptune account) to retrieve data for your employees table 
--and to allow them to retrieve, insert and update data in your departments table. Show proof
--SOLUTION
GRANT SELECT ON employees TO dbs301_183g35;
GRANT SELECT,INSERT, UPDATE ON departments TO dbs301_183g35

--B)Use the REVOKE statement to remove permission for that student to insert and update data in your departments table
REVOKE INSERT,UPDATE ON departments FROM dbs301_183g35;






