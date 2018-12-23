-- ***********************
-- Name: Shutian Xu
-- ID: 152023164
-- Date: October 3rd 2018
-- Purpose: Lab 5 DBS301 
-- ***********************

--Part A
-- Simple Joins
-- Simplely use the key word "join"

--Q1
--Display the department name, city, street address and postal code
--for departments
--sorted by city and department name.
SELECT d.department_name, l.city, l.street_address, l.postal_code
FROM departments d JOIN locations l
  ON d.location_id = l.location_id
ORDER BY 2,1;

--Q2
--Display full name of employees as a single field using format of Last, First,
--their hire date, salary, department name and city,
--but only for departments with names starting with an A or S
--sorted by department name and employee name.
SELECT e.last_name||', '||e.first_name AS "Full Name",
    e.hire_date,
    e.salary,
    d.department_name,
    l.city
FROM (employees e JOIN departments d
  ON e.department_id = d.department_id) JOIN locations l
  ON d.location_id = l.location_id
WHERE UPPER(d.department_name) LIKE 'A%'
  OR UPPER(d.department_name) LIKE 'S%'
ORDER BY 4,1;

--Q3
--Display the full name of the manager of each department in states/provinces of Ontario, California and Washington
--along with the department name, city, postal code and province name.  
--Sort the output by city and then by department name.

SELECT e.last_name||' '||e.first_name AS "Full Name",
      d.department_name,
      l.city,
      l.postal_code,
      l.state_province AS "Province"
FROM (employees e JOIN departments d
  ON e.department_id = d.department_id) JOIN locations l
  ON d.location_id = l.location_id
WHERE e.manager_id = d.manager_id
  AND l.state_province in ('Ontario', 'California', 'Washington')
ORDER BY 3,2;

--Q4
--Display employee's last name and employee number
--along with their manager's last name and manager number.
--Label the columns Employee, Emp#, Manager, and Mgr# respectively.
SELECT e.last_name AS "Employee",
      e.employee_id AS "Emp#",
      m.last_name AS "Manager",
      m.manager_id AS "Mgr#"
FROM employees e LEFT JOIN employees m
    ON e.manager_id = m.employee_id;

--Part B
--Non-Somple Joind
-- Standard Joins
-- = / +=

--Q5
--Display the department name, city, street address, postal code and country name for all Departments.
--Use the JOIN and USING form of syntax. 
--Sort the output by department name descending.
SELECT d.department_name,
      l.city,
      l.street_address,
      l.postal_code,
      g.country_name
FROM (departments d JOIN locations l
  ON d.location_id = l.location_id) JOIN countries g
  ON l.country_id = g.country_id
ORDER BY 1 DESC;

--Q6
--Display full name of the employees, their hire date and salary together with their department name, 
--but only for departments which names start with A or S. 
--a.Full name should be in format of: First / Last. 
--b.Use the JOIN and ON form of syntax.
--c.Sort the output by department name and then by last name.
SELECT e.first_name||' '||e.last_name as "Full Name",
        e.hire_date,
        e.salary,
        d.department_name
FROM employees e JOIN departments d
    ON e.department_id = d.department_id
WHERE UPPER(d.department_name) LIKE 'A%'
    OR upper(d.department_name) LIKE 'S%'
ORDER BY d.department_name, e.last_name;


--Q7
--Display full name of the manager of each department in provinces Ontario, California and Washington 
--plus department name, city, postal code and province name. 
--a.Full name should be in format as follows: Last, First.  
--b.Use the JOIN and ON form of syntax.
--c.Sort the output by city and then by department name. 
SELECT e.last_name||' '||e.first_name AS "Full Name",
        d.department_name,
        l.city,
        l.postal_code,
        l.state_province
FROM (employees e join departments d
    ON e.department_id = d.department_id) JOIN locations l
    ON d.location_id = l.location_id
WHERE l.state_province IN ('Ontario', 'California', 'Washington')
ORDER BY 3,2;


--Q8
--Display the department name and Highest, Lowest and Average pay per each department. 
--Name these results High, Low and Avg.
--a.Use JOIN and ON form of the syntax.
--b.Sort the output so that department with highest average salary are shown first.
SELECT d.department_name,
      to_char(MAX(salary), '$999,999.99') AS "High",
      to_char(MIN(salary), '$999,999.99') AS "Low",
      to_char(AVG(NVL(salary, 1)), '$999,999.99') AS "Avg"
FROM departments d JOIN employees e
    ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY 4 DESC;

--Q9
--Display the employee last name and employee number along with their manager��s last name and manager number. 
--Label the columns Employee
--a.Emp#, Manager, and Mgr#, respectively. 
--b.Include also employees who do NOT have a manager and also employees who do NOT supervise anyone 
--(or you could say managers without employees to supervise).
SELECT e.last_name AS "Employee",
      e.employee_id AS "Emp#",
      m.last_name AS "Manager",
      m.manager_id AS "Mgr#"
FROM employees e LEFT JOIN employees m
    ON e.manager_id = m.employee_id;


























