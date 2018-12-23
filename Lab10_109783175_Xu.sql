-- ***********************
-- Name: Shutian XU
-- ID: 109783175
-- Date: NOV 25Th 2018
-- Purpose: Lab10 DBS301 SAB
-- ***********************

--Q1
--Create table CITIES from table LOCATIONS,but only for location numbers less than 2000 (do NOT create this table from scratch, 
--i.e. create and insert in one statement).
--Solution

CREATE TABLE CITIES AS(
   SELECT * FROM LOCATIONS
   WHERE LOCATION_ID < 2000 );
   DESCRIBE CITIES;

-- Q2
--Create table TOWNS from table LOCATIONS, but only for location numbers less than 1500 
--(do NOT create this table from scratch). This table will have same structure as table CITIES.You will have exactly 5 rows here.
--Solution

CREATE TABLE TOWNS AS(
    SELECT * FROM LOCATIONS
    WHERE LOCATION_ID < 1500);

--Q3
--Now you will empty your RECYCLE BIN with one powerful command. Then remove your table TOWNS, so that will remain in the recycle bin. 
--Check that it is really there and what time was removed.  
--Hint: Show RecycleBin, Purge, Flashback
--Solution

-- Empty your RECYCLE BIN 
PURGE RECYCLEBIN;
-- Remove your table TOWNS
DROP TABLE TOWNS;
--Check RECYCLE BIN and DROP time
SHOW RECYCLEBIN;
-- SOLUTION: 
-- The table is removed and drop time: 2018-11-25:14:26:23 

-- ORIGINAL NAME RECYCLEBIN NAME                OBJECT TYPE DROP TIME           
-- ------------- ------------------------------ ----------- ------------------- 
-- TOWNS         BIN$e4MxGpcqmPHgUxhrZgoIdw==$0 TABLE       2018-11-25:14:26:23 

--Q4 
-- Restore your table TOWNS from recycle bin and describe it. 
--Solution
FLASHBACK TABLE TOWNS TO BEFORE DROP;
DESCRIBE TOWNS;
-- Check what is in your recycle bin now.
SHOW RECYCLEBIN;
-- The table TOWNS has been restored from recycle bin, so it shows nothing in the recycle bin. 

--Q5
--Now remove table TOWNS so that does NOT remain in the recycle bin. 
--Solution
DROP TABLE TOWNS; 
PURGE RECYCLEBIN;
--Check that is really NOT there and then try to restore it. Explain what happened?
SHOW RECYCLEBIN;
-- Try to restore table TOWNS from RECYCLE BIN
FLASHBACK TABLE TOWNS TO BEFORE DROP;
--Explanation: the Script Output shows: "Trying to Flashback Drop an object which is not in RecycleBin."
--Sinece the recycle bin has been empty by command PURGE RECYCLEBIN, Table TOWNS cannot be restored. 
--Hence, the error messages shows in the log.

--Q6
--Create simple view called CAN_CITY_VU, based on table CITIES so that will contain only columns Street_Address, 
--Postal_Code, City and State_Province for locations only in CANADA. 
--Solution
CREATE VIEW CAN_CITY_VU AS(
SELECT Street_Address, Postal_Code, City, State_Province 
FROM CITIES
WHERE COUNTRY_ID IN (
SELECT COUNTRY_ID 
FROM COUNTRIES
WHERE UPPER(COUNTRY_NAME) = UPPER('CANADA')) );

--Then display all data from this view.
SELECT * FROM CAN_CITY_VU;

--Q7
--Modify your simple view so that will have following aliases instead of original column names: Str_Adr, P_Code, City and 
--Prov and also will include cities from ITALY as well. 
--Solution
CREATE OR REPLACE VIEW CAN_CITY_VU ("Str_Adr", "P_Code", "City", "Prov") AS(
SELECT Street_Address, Postal_Code, City, State_Province 
FROM CITIES
WHERE COUNTRY_ID IN (
SELECT COUNTRY_ID
FROM COUNTRIES
WHERE UPPER(COUNTRY_NAME) IN ('CANADA','ITALY')) );

--Then display all data from this view.
SELECT * FROM CAN_CITY_VU;

--Q8
--Create complex view called CITY_DNAME_VU, based on tables LOCATIONS and DEPARTMENTS, so that will contain only columns Department_Name, 
--City and State_Province for locations in ITALY or CANADA. 
--Include situations even when city does NOT have department established yet. 
--Solution
CREATE OR REPLACE VIEW CITY_DNAME_VU AS(
SELECT Department_Name, City, State_Province
FROM DEPARTMENTS D LEFT JOIN LOCATIONS L
ON L.LOCATION_ID = D.LOCATION_ID 
WHERE L.COUNTRY_ID IN (SELECT COUNTRY_ID FROM COUNTRIES
WHERE UPPER(COUNTRY_NAME) IN ('CANADA','ITALY')));

--Then display all data from this view.
SELECT * FROM CITY_DNAME_VU;

--Q9
--Modify your complex view so that will have following aliases instead of original column names: 
--DName, City and Prov and also will include all cities outside United States 
--Include situations even when city does NOT have department established yet. 
--Solution
CREATE OR REPLACE VIEW CITY_DNAME_VU("DName", "City", "Prov") AS(
SELECT department_name, city, state_province
FROM DEPARTMENTS D LEFT JOIN LOCATIONS L
ON L.LOCATION_ID = D.LOCATION_ID 
WHERE L.COUNTRY_ID IN (SELECT COUNTRY_ID FROM COUNTRIES
WHERE UPPER(COUNTRY_NAME) NOT LIKE '%UNITED STATES%'));

--Then display all data from this view.
SELECT * FROM CITY_DNAME_VU;

--Q10
--Check in the Data Dictionary what Views (their names and definitions) are created so far in your account. 
--Then drop your CITY_DNAME_VU and check Data Dictionary again. What is different?
--Solution
-- CHECK View name and definitions in my account of Data Dictionary
SELECT VIEW_NAME, TEXT
FROM USER_VIEWS;
--drop your CITY_DNAME_VU and check Data Dictionary again
DROP VIEW CITY_DNAME_VU;
--Explanation
--The difference is that, after dropping View CITY_DNAME_VU, there is no View CITY_DNAME_VU to be selected from the 
--USER_VIEWS account in Data Dictionary.









