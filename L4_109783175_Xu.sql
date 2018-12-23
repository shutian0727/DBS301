-- ***********************
-- Name: Shutian Xu
-- ID: 109783175
-- Date: Sep 27th 2018
-- Purpose: Lab 4 DBS301 
-- ***********************

--Q1
--Display the difference between the Average pay and Lowest pay in the company.  
--Name this result Real Amount.  
--Format the output as currency with 2 decimal places.
SELECT to_char(ROUND(AVG(salary) - MIN(salary),2),'$999,999.99')
AS "Real Amount"
FROM employees;

--Q2
--Display the department number and Highest, Lowest and Average pay per each department.
--Name these results High, Low and Avg.  
--Sort the output so that the department with highest average salary is shown first.  
--Format the output as currency where appropriate.
SELECT department_id,
  to_char(MAX(salary), '$999,999.99') AS "High",
  to_char(MIN(salary), '$999,999.99') AS "Low",
  to_char(AVG(NVL(salary, 1)), '$999,999.99') as "Avg"
FROM employees
GROUP BY department_id
ORDER BY "Avg" DESC;

--Q3
--Display how many people work the same job in the same department.
--Name these results Dept#, Job and How Many.
--Include only jobs that involve more than one person.  
--Sort the output so that jobs with the most people involved are shown first.
SELECT department_id as "Despt#", job_id AS "Job", COUNT(department_id) AS "How Many"
FROM employees
group by department_id, job_id
having count(DISTINCT job_id) > 1
order by  "How Many" desc;

--Q4
--For each job title display the job title and total amount paid each month for this type of the job.
--Exclude titles AD_PRES and AD_VP and also include only jobs that require more than $12,000.  
--Sort the output so that top paid jobs are shown first.
SELECT job_id AS "job title", TO_CHAR(ROUND(SUM(salary),2),'$999,999.99') AS "total amount"
FROM employees
WHERE job_id NOT IN ('AD_PRES', 'AD_VP')
GROUP BY job_id
HAVING BY(salary) > 12000
ORDER BY "total amount" DESC;

--Q5
--For each manager number display how many persons he / she supervises.
--Exclude managers with numbers 100, 101 and 102 and also
--include only those managers that supervise more than 2 persons.  
--Sort the output so that manager numbers with the most supervised persons are shown first.
SELECT manager_id, COUNT(manager_id)
FROM employees
WHERE manager_id NOT IN(100,101,102)
GROUP BY manager_id
HAVING COUNT(manager_id) > 2
ORDER BY 2 DESC;


--Q6
--For each department show the latest and earliest hire date, BUT
--exclude departments 10 and 20
--exclude those departments where the last person was hired in this century.
--Sort the output so that the most recent, meaning latest hire dates, are shown first.
SELECT department_id, MIN(hire_date) AS "Min", MAX(hire_date) AS "Max"
FROM employees
GROUP BY department_id
HAVING department_id NOT IN (10,20)
AND to_char(MAX(hire_date),'cc') != to_char(sysdate,'cc')
ORDER BY 3 desc;







