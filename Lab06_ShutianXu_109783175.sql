-- ***********************
-- Name: Shutian Xu
-- ID: 109783175
-- Date: 10/11/2018
-- Purpose: Lab 6 DBS301
-- ***********************

--Q1
--SET AUTOCOMMIT ON (do this each time you log on)
--so any updates, deletes and inserts are automatically committed before you exit from Oracle.
SET AUTOCOMMIT ON;



--Q2
--Create an INSERT statement to do this.  
--Add yourself as an employee with a NULL salary, 0.2 commission_pct,
--in department 90, and Manager 100.  
--You started TODAY.

--cannot do that directly, since employee_id, email are not null!
--no need to set up salary, the default of that is null
INSERT INTO employees (employee_id, first_name, last_name, email,commission_pct,
                       department_id, manager_id, job_id,hire_date)
VALUES ('199','Shutian', 'Xu','sxu61@myseneca.ca', 0.2, 90, 100, 'IT_PROG',SYSDATE);

--Q3
--Create an Update statement to: Change the salary of the employees with a last name of Matos and Whalen to be 2500.
UPDATE employees
SET salary = 2500
WHERE UPPER(last_name) in ('MATOS', 'WHALEN');

--TEST salary
select * from employees
WHERE UPPER(last_name) in ('MATOS', 'WHALEN');

--Q4
--Display the last names of all employees who are in the same department as the employee named Abel.
SELECT last_name
FROM employees
WHERE department_id = (SELECT department_id
                        FROM employees
                        WHERE last_name = 'Abel');

--Q5
--Display the last name of the lowest paid employee(s)
SELECT last_name
FROM employees
WHERE Salary = (SELECT MIN(salary)
                FROM employees);

--Q6
--Display the city that the lowest paid employee(s) are located in.
SELECT l.city
FROM (departments d JOIN employees e
    on d.department_id = e.department_id) JOIN locations l
    on d.location_id = l.location_id
WHERE Salary = (SELECT MIN(salary)
                FROM employees);
                      
--Q7
--Display the last name, department_id, and salary of the lowest paid employee(s) in each department.  
--Sort by Department_ID. 
--(HINT: careful with department 60)

--SELECT last_name, department_id, salary
--FROM employees
-- salary in (SELECT MIN(salary)
--            FROM employees
--            GROUP BY department_id)   
--ORDER BY department_id;

--update
SELECT r1.last_name, r1.department_id, r1.salary
FROM employees r1, (SELECT DISTINCT e.department_id as "DEP", r.MIN as "MIN1"
                    FROM employees e, (SELECT MIN(salary) as "MIN", department_id
                                        FROM employees
                                        GROUP BY department_id) r
                    WHERE e.department_id = r.department_id) re
WHERE r1.department_id = re.DEP     
AND r1.salary = re."MIN1"
ORDER BY r1.department_id;

--Q8
--Display the last name of the lowest paid employee(s) in each city
SELECT e.last_name
FROM (departments d JOIN employees e
    on d.department_id = e.department_id) JOIN locations l
    on d.location_id = l.location_id
WHERE e.salary = (SELECT MIN(e.salary)
                FROM employees);

--Q9
--Display last name and salary for all employees who earn less than the lowest salary in ANY department.  
--Sort the output by top salaries first and then by last name.

--( I understood "less than the lowest salary in any departments" 
--as "this salary would less than the highest salary picked from the lowest salary for each departments"
--in other words, the first list is for the lowest(departments) salary,
--and the second list is for picking the highest one from the first list as a standard )
SELECT last_name, salary
FROM employees
WHERE salary < (SELECT MAX("minofdeps") AS "maxindep"
                FROM (SELECT MIN(salary) AS "minofdeps"
                      FROM employees
                      GROUP BY department_id))
ORDER BY salary DESC, last_name;

--Q10
--Display last name, job title and salary 
--for all employees whose salary matches any of the salaries from the IT Department. 
--Do NOT use Join method.
--Sort the output by salary ascending first and then by last_name
SELECT last_name,
        job_id as "Job Title",
        salary
FROM employees
WHERE salary in (SELECT salary
                FROM employees
                WHERE job_id = 'IT_PROG')
ORDER BY salary, last_name;