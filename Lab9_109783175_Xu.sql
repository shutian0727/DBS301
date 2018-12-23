-- ***********************
-- Name: Shutian XU
-- ID: 109783175
-- Date: NOV 19Th 2018
-- Purpose: Lab9 DBS301 SAB
-- ***********************

--Q1
--Create table SALESREP and load it with data from table EMPLOYEES table. 
--Use only the equivalent columns from EMPLOYEE as shown below and only for people in department 80.
--Solution
CREATE TABLE SALESREP( 
RepId NUMBER(6),
FName VARCHAR2(20),  
LName VARCHAR2(25) NOT NULL,   
Phone# VARCHAR2(20),
Salary NUMBER(8,2),
Commission NUMBER(2,2),
CONSTRAINT RepId_pk PRIMARY KEY (RepId));


INSERT INTO SALESREP(RepId, FName, LName,Phone#,Salary,Commission) 
(SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, PHONE_NUMBER, SALARY, COMMISSION_PCT
FROM EMPLOYEES WHERE DEPARTMENT_ID = 80);

--Q2
--Create CUST table
--Solution
CREATE TABLE CUST(
   CUST#	  	NUMBER(6),
   CUSTNAME 	VARCHAR2(30) NOT NULL,
   CITY 		VARCHAR2(20) NOT NULL,
   RATING		CHAR(1),
   COMMENTS	    VARCHAR2(200),
   SALESREP#	NUMBER(7),
   CONSTRAINT cust_cust#_pk PRIMARY KEY (Cust#),
   CONSTRAINT cust_custname_city_uk UNIQUE(CustName, City),
   CONSTRAINT cust_rating_ck CHECK (Rating IN ('A','B','C','D')),
   CONSTRAINT cust_salesrep#_fk FOREIGN KEY (SalesRep#)
   REFERENCES SALESREP (RepId));
   
INSERT INTO CUST (cust#,custname,city,rating,salesrep#) 
VALUES(501,'ABC LTD.','Montreal','C',149);
INSERT INTO CUST (cust#,custname,city,rating,salesrep#) 
VALUES(502,'Black Giant','Ottawa','B',174);
INSERT INTO CUST (cust#,custname,city,rating,salesrep#) 
VALUES(503,'Mother Goose','London','B',174);
INSERT INTO CUST (cust#,custname,city,rating,salesrep#) 
VALUES(701,'BLUE SKY LTD','Vancouver','B',176);
INSERT INTO CUST (cust#,custname,city,rating,salesrep#) 
VALUES(702,'MIKE and SAM Inc.','Kingston','A',174);
INSERT INTO CUST (cust#,custname,city,rating,salesrep#) 
VALUES(703,'RED PLANET','Mississauga','C',174);
INSERT INTO CUST (cust#,custname,city,rating,salesrep#) 
VALUES(717,'BLUE SKY LTD','Regina','D',176);

--Q3
--Create table GOODCUST by using following columns but only if their rating is A or B. 
CREATE TABLE GOODCUST(
CUSTID NUMBER(6), 
NAME   VARCHAR2(30) NOT NULL, 
LOCATION VARCHAR2(20) NOT NULL, 
REPID    NUMBER(7),  
CONSTRAINT cust_CUSTID_pk PRIMARY KEY(CustId),
   CONSTRAINT cust_name_location_uk UNIQUE (Name, Location),
   CONSTRAINT cust_RepId_fk FOREIGN KEY (RepId)
   REFERENCES SALESREP (RepId));

INSERT INTO GOODCUST
(SELECT cust#, custname,city , salesrep#
FROM cust 
WHERE rating = 'A' or rating = 'B');

INSERT INTO GOODCUST(CUSTID, NAME, LOCATION, REPID)
VALUES ('502', 'Black Giant','Ottawa', '202');

INSERT INTO GOODCUST(CUSTID, NAME, LOCATION, REPID)
VALUES ('503', 'Mother Goose','London', '202');

INSERT INTO GOODCUST(CUSTID, NAME, LOCATION, REPID)
VALUES ('504', 'Black Giant','OVancouver', '202');

INSERT INTO GOODCUST(CUSTID, NAME, LOCATION, REPID)
VALUES ('5701', 'MIKE and SAM inc','Kingston', '10');

--Q4
--Now add new column to table SALESREP called JobCode that will be of variable character type with max length of 12. 
--Do a DESC SALESREP to ensure it executed

ALTER TABLE SALESREP
ADD JOBCODE VARCHAR2(12);
DESC SALESREP;

--Q5
--Declare column Salary in table SALESREP as mandatory one and Column Location in table GOODCUST as optional one. 
--Solution

ALTER TABLE SALESREP
MODIFY  SALARY NOT NULL;

ALTER TABLE GOODCUST
MODIFY LOCATION NULL;

--Lengthen FNAME in SALESREP to 37. The result of a DESCRIBE should show it happening 

ALTER TABLE SALESREP
MODIFY FNAME VARCHAR2(37);

ALTER TABLE GOODCUST
MODIFY NAME VARCHAR2(3);

--Q6
--Now get rid of the column JobCode in table SALESREP in a way that will not affect daily performance. 
--Solution
ALTER TABLE l9salesrep
    DROP COLUMN JobCode;

--Q7
--Declare PK constraints in both new tables ? RepId and CustId
--Solution
ALTER TABLE SALESREP
ADD CONSTRAINT cust_RepId_pk PRIMARY KEY(RepId);

ALTER TABLE GOODCUST
ADD CONSTRAINT cust_CustId_pk PRIMARY KEY(CustId);

--Q8
--Declare UK constraints in both new tables ? Phone# and Name
ALTER TABLE GOODCUST
ADD CONSTRAINT name_uk UNIQUE (name);

ALTER TABLE SALESREP
ADD CONSTRAINT phone_uk UNIQUE (phone#);

--Q9
--Restrict amount of Salary column to be in the range [6000, 12000] and Commission to be not more than 50%.
--solution
ALTER TABLE SALESREP
ADD CONSTRAINT check_salary CHECK (salary BETWEEN 6000 AND 12000);

ALTER TABLE SALESREP
ADD CONSTRAINT commission_salary CHECK (commission < 0.5);

--Q10
--Ensure that only valid RepId numbers from table SALESREP may be entered in the table GOODCUST. 
--Why this statement has failed?
--solution
--Because of referential integrity. We need to make sure the salesrep# exist in table SALESREP first due to the referential integrity.

ALTER TABLE GOODCUST
ADD CONSTRAINT RepId_FK
FOREIGN KEY (RepId)
REFERENCES SALESREP(RepId);

-- Q11
--Firstly write down the values for RepId column in table GOODCUST and then make all these values blank. 
--Now redo the question 10. Was it successful? 
-- SOLUTION --
--It was not successful, since, due to the referential integrity, I need to ensure data exist in the Parent table SALESREP. 
--not in table GOODCUST. So making values blank in GOODCUST will not solve the problem in this case.

ALTER TABLE GOODCUST
ADD CONSTRAINT RepId_FK
FOREIGN KEY (RepId)
REFERENCES SALESREP(RepId);

-- Q12 
--Disable this FK constraint now and enter old values 
--for RepId in table GOODCUST and save them. Then try to enable your FK constraint. What happened?  

--solution
--It doesn't work either. We cannot insert data into GOODCUST with RepId that's not in SALESREP
--Unless we put primary key data into table SALESREP first
ALTER TABLE GOODCUST
DISABLE CONSTRAINT RepId_FK;

-- Q13
--Get rid of this FK constraint. Then modify your CK constraint from question 9 to allow Salary amounts from 5000 to 15000  
--solution

ALTER TABLE goodcust
DISABLE CONSTRAINT RepId_FK;

ALTER TABLE salesrep
DROP CONSTRAINT check_salary;

ALTER TABLE salesrep
ADD CONSTRAINT check_salary CHECK (salary BETWEEN 5000 AND 15000);

--Q14 
--Get rid of this FK constraint. Then modify your CK constraint from question 9 to allow Salary amounts from 5000 to 15000  
--solution

DESCRIBE SALESREP;
DESCRIBE GOODCUST;

SELECT  constraint_name, constraint_type, search_condition, table_name
FROM     user_constraints
WHERE table_name IN ('SALESREP','GOODCUST')
ORDER  BY  4 , 2










