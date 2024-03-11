# Creating a Database
CREATE DATABASE bank;

# Using Database
USE bank;

# Creating Tables : Customer, branch, account, transaction Details, loan

CREATE TABLE customer
   (
       custID VARCHAR(6) PRIMARY KEY,
       fName VARCHAR(30),
       mName VARCHAR(30),
       lName VARCHAR(30),
       city VARCHAR(15),
       mobileNo VARCHAR(10),
       occupation VARCHAR(10),
       dob DATE
   );
   
   
   CREATE TABLE branch
   (
    branchID VARCHAR(6) PRIMARY KEY,
    branchName VARCHAR(30),
    branchCity VARCHAR(30)
   );
   
   
   CREATE TABLE account
   (
      accNumber VARCHAR(6) PRIMARY KEY,
      custID  VARCHAR(6),
      branchID VARCHAR(6),
      openingBalance INT(7),
      accOpenDate DATE,
      accType VARCHAR(10),
      accStatus VARCHAR(10),
      CONSTRAINT account_custID_fk FOREIGN KEY(custID) REFERENCES customer(custID),
      CONSTRAINT account_branchID_fk FOREIGN KEY(branchID) REFERENCES branch(branchID) 
    );
    
    
    
    CREATE TABLE transactionDetails
    (   
     tranNumber VARCHAR(6) PRIMARY KEY,
     accNumber VARCHAR(6),
     dateOfTran DATE,
     medium_of_transaction VARCHAR(20),
     transaction_type VARCHAR(20),
     transaction_amount INT(7), 
     CONSTRAINT transactionDetails_accNumber_fk FOREIGN KEY(accNumber) REFERENCES account(accNumber)  
    );
    
    
    CREATE TABLE loan
   (
    custID VARCHAR(6),
    branchID VARCHAR(6),
    loan_amount INT(7),
    CONSTRAINT loan_customer_custID_branchID_pk PRIMARY KEY(custID,branchID),
    CONSTRAINT loan_custID_fk FOREIGN KEY(custID) REFERENCES  customer(custID),
    CONSTRAINT loan_branchID_fk FOREIGN KEY(branchID) REFERENCES  branch(branchID)
   );
   
   
# Inserting Records into Customer Table :
   
INSERT INTO customer VALUES('C00001','Ramesh','Chandra','Sharma','Delhi','9543198345','Service','1976-12-06'),
                           ('C00002','Avinash','Sunder','Minha','Delhi','9876532109','Service','1974-10-16'),
						   ('C00003','Rahul',null,'Rastogi','Delhi','9765178901','Student','1981-09-26'),
                           ('C00004','Parul',null,'Gandhi','Delhi','9876532109','Housewife','1976-11-03'),
                           ('C00005','Naveen','Chandra','Aedekar','Mumbai','8976523190','Service','1976-09-19'),
                           ('C00006','Chitresh',null,'Barwe','Mumbai','7651298321','Student','1992-11-06'),
                           ('C00007','Amit','Kumar','Borkar','Mumbai','9875189761','Student','1981-09-06'),
                           ('C00008','Nisha',null,'Damle','Mumbai','7954198761','Service','1975-12-03'),
						   ('C00009','Abhishek',null,'Dutta','Kolkata','9856198761','Service','1973-05-22'),
                           ('C00010','Shankar',null,'Nair','Chennai','8765489076','Service','1976-07-12');
                           

# Inserting Records into Branch Table :

INSERT INTO branch VALUES('B00001','Asaf ali road','Delhi'),
						 ('B00002','New delhi main branch','Delhi'),
                         ('B00003','Delhi cantt','Delhi'),
                         ('B00004','Jasola','Delhi'),
                         ('B00005','Mahim','Mumbai'),
                         ('B00006','Vile parle','Mumbai'),
                         ('B00007','Mandvi','Mumbai'),
                         ('B00008','Jadavpur','Kolkata'),
                         ('B00009','Kodambakkam','Chennai');
    
    
# Inserting Records into Account Table :

INSERT INTO account VALUES('A00001','C00001','B00001',1000,'2012-12-15','Saving','Active'),
						  ('A00002','C00002','B00001',1000,'2012-06-12','Saving','Active'),
                          ('A00003','C00003','B00002',1000,'2012-05-17','Saving','Active'),
                          ('A00004','C00002','B00005',1000,'2013-01-27','Saving','Active'),
                          ('A00005','C00006','B00006',1000,'2012-12-17','Saving','Active'),
                          ('A00006','C00007','B00007',1000,'2010-08-12','Saving','Suspended'),
                          ('A00007','C00007','B00001',1000,'2012-10-02','Saving','Active'),
                          ('A00008','C00001','B00003',1000,'2009-11-09','Saving','Terminated'),
                          ('A00009','C00003','B00007',1000,'2008-11-30','Saving','Terminated'),
                          ('A00010','C00004','B00002',1000,'2013-03-01','Saving','Active');


# Inserting Records into Transaction Details Table :

INSERT INTO transactionDetails VALUES('T00001','A00001','2013-01-01','Cheque','Deposit',2000),
									 ('T00002','A00001','2013-02-01','Cash','Withdrawal',1000),
                                     ('T00003','A00002','2013-01-01','Cash','Deposit',2000),
                                     ('T00004','A00002','2013-02-01','Cash','Deposit',3000),
                                     ('T00005','A00007','2013-01-11','Cash','Deposit',7000),
                                     ('T00006','A00007','2013-01-13','Cash','Deposit',9000),
                                     ('T00007','A00001','2013-03-13','Cash','Deposit',4000),
                                     ('T00008','A00001','2013-03-14','Cheque','Deposit',3000),
                                     ('T00009','A00001','2013-03-21','Cash','Withdrawal',9000),
                                     ('T00010','A00001','2013-03-22','Cash','Withdrawal',2000),
                                     ('T00011','A00002','2013-03-25','Cash','Withdrawal',7000),
							         ('T00012','A00007','2013-03-26','Cash','Withdrawal',2000);
         
         
# Inserting Records into Loan Table :

INSERT INTO loan VALUES('C00001','B00001',100000),
					   ('C00002','B00002',200000),
                       ('C00009','B00008',400000),
                       ('C00010','B00009',500000),
                       ('C00001','B00003',600000),
                       ('C00002','B00001',600000);
                       
                       
# Performs querying on this :

# Query 1 : Write a query to display the customer number, firstname, customer’s date of birth. 
# 			Display in sorted order of date of birth year and within that sort by firstname.

SELECT mobileNo,fName,dob FROM customer
ORDER BY EXTRACT(YEAR FROM dob), fName ASC;


# Query 2 : Write a query to display the customer’s number, first name, and middle name. The customer’s who don’t have a middle name, 
# 			for them display the last name. Give the alias name as Cust_Name. 

SELECT mobileNo,fName AS First_Name, IF(mName IS NULL,lName,mName) AS Cust_Name FROM customer;



# Query 3 : Write a query to display account number, customer’s number, customer’s firstname,lastname,account opening date.

SELECT a.accNumber,c.custID,c.fName as First_Name,c.lName as Last_Name,a.accOpenDate FROM customer as c
INNER JOIN account as a
ON a.custID = c.custID;


# Query 4 : Write a query to display the number of customer’s from Delhi. Give the count an alias name of Cust_Count.

SELECT COUNT(custID) AS Cust_Count,city FROM customer
WHERE city = "Delhi";


# Query 5 : Write a query to display  the customer number, customer firstname,account number for the customer’s 
# 			whose accounts were created after 15th of any month.

SELECT c.mobileNo, c.fName AS First_Name,a.accNumber, a.accOpenDate from customer AS C
INNER JOIN account AS A
ON a.custID = c.custID
WHERE Day(a.accOpenDate) > 15;


# Query 6 : Write a query to display the customers firstname, city and account number 
# 			who are not into business, service or studies

SELECT c.fName as First_Name, c.city, a.accNumber, c.occupation FROM customer AS c
INNER JOIN account AS a
ON a.custID = c.custID
WHERE c.occupation NOT IN ("business","service","studies");



# Query 7 : Write a query to display city name and count of branches in that city. 
#			Give the count of branches an alias name of Count_Branch.

SELECT branchCity, COUNT(branchID) AS Count_Branch FROM branch
GROUP BY (branchCity);


# Query 8 : Write a query to display account id, customer’s firstname, customer’s lastname for the customer’s whose account is Active.

SELECT a.accNumber,c.fName AS First_Name, c.lName AS Last_Name FROM customer AS c
INNER JOIN account AS a 
WHERE a.accStatus = "Active";


# Query 9 : Write a query to display the customer’s number, customer’s firstname, branch id and loan amount for 
# 			people who have taken loans.

SELECT c.custID, c.fName AS First_Name, l.branchID, l.loan_amount FROM customer AS c
INNER JOIN loan AS l
ON l.custID = c.custID;


# Query 10 : Write a query to display customer number, customer name, account number where the account status is terminated.

SELECT c.mobileNo, CONCAT(c.fName,c.lName) AS Customer_Name, a.accNumber FROM customer AS c
INNER JOIN account AS a
ON a.custID = c.custID
WHERE a.accStatus = "Terminated";

                                     