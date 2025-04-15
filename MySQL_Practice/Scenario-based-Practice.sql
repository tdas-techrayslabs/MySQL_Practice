-- Q1) 
-- You are working on an e-commerce database. The "customers" table needs a column that uniquely identifies each customer. 
-- The table should also store customer name, email, and phone number. 
-- Ensure that no two customers have the same identifier and the primary key should not allow null values. 
-- How would you design this table and enforce the uniqueness of the customer ID?

CREATE DATABASE ecommerce; 

USE ecommerce;

CREATE TABLE CUSTOMERS (
	Customer_ID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(50) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    Phone_number NUMERIC(10)
);

DESCRIBE CUSTOMERS;

-- --------------------------------------------------------------------------------------------------------------------------------------

-- Q2)
-- In a library management system, you have a "books" table that stores book titles, ISBN numbers, and authors. 
-- ISBN numbers must be unique because each book has a distinct ISBN. 
-- You are tasked with ensuring that no two books in the system share the same ISBN number, while allowing multiple books with the same title or same author. 
-- How would you implement this constraint?

CREATE DATABASE library_management_system;

USE library_management_system;

CREATE TABLE BOOKS (
	ISBN INT PRIMARY KEY,
    Title VARCHAR(50),
    Authors VARCHAR(30)
);

DESCRIBE BOOKS;

-- -----------------------------------------------------------------------------------------------------

-- Q3)
-- You are designing a payroll system. 
-- The "employees" table has columns for employee ID, name, date of birth, salary, and date of hire. 
-- The employee ID should be a string that supports both numbers and letters (e.g., "EMP123"), the salary should be a decimal to store precise values with two decimal places, 
-- and the date of birth and date of hire should be stored in a date format. 
-- What would be the most appropriate data types for these columns and why?

CREATE DATABASE payroll_system;

USE payroll_system;

CREATE TABLE EMPLOYEES (
	Employee_ID VARCHAR(30) PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Date_of_birth DATE NOT NULL,
    SALARY DECIMAL(10, 2) NOT NULL,
    Date_of_hire DATE NOT NULL  
);

DESCRIBE EMPLOYEES;

-- -------------------------------------------------------------------------------------------------------------------------------

-- Q4) 
-- You are building a database for an online course platform. 
-- You have two tables: one for "students" (containing student ID, name, and email) and another for "courses" (containing course ID, name, and instructor). 
-- You need to generate a report that lists all the students enrolled in each course, with the student’s name, course name, and instructor’s name. 
-- How would you retrieve this information using a SQL JOIN?

CREATE DATABASE online_course_platform;

USE online_course_platform;

CREATE TABLE COURSES (
	Course_ID VARCHAR(10) PRIMARY KEY,
    NAME VARCHAR(50) NOT NULL,
    INSTRUCTOR VARCHAR(40) NOT NULL
);

DESCRIBE COURSES;

CREATE TABLE STUDENTS (
	Student_ID NUMERIC(5) PRIMARY KEY,
    NAME VARCHAR(50) NOT NULL,
    EMAIL VARCHAR(30) NOT NULL,
    Course_ID VARCHAR(10),
    CONSTRAINT fk_Course_Id FOREIGN KEY (COURSE_ID) REFERENCES COURSES(COURSE_ID)
); 

DESCRIBE STUDENTS;

INSERT INTO COURSES VALUES
('CS101', 'Introduction to CS', 'Dr. John Smith'),
('MATH201', 'Calculus I', 'Dr. Emily Stone'),
('PHY110', 'Physics Basics', 'Dr. Alan Grant'),
('ENG205', 'Creative Writing', 'Prof. Laura White');

SELECT * FROM COURSES;

INSERT INTO STUDENTS VALUES
(10001, 'Alice Johnson', 'alice.johnson@example.com', 'CS101'),
(10002, 'Bob Lee', 'bob.lee@example.com', 'MATH201'),
(10003, 'Catherine Ray', 'catherine.ray@example.com', 'PHY110'),
(10004, 'David Kim', 'david.kim@example.com', 'ENG205'),
(10005, 'Eva Brown', 'eva.brown@example.com', 'CS101');

SELECT * FROM STUDENTS;

SELECT s.NAME, C.NAME, INSTRUCTOR
FROM STUDENTS s
INNER JOIN 
COURSES c
ON s.COURSE_ID = c.COURSE_ID;

-- --------------------------------------------------------------------------------------------------------------

-- Q5)
-- A university system has two separate tables: one for full-time students and one for part-time students. 
-- Both tables have the same structure (student ID, name, enrollment date, and major). 
-- The university wants a unified list of all students enrolled in the system, regardless of their status. 
-- How would you combine these two tables into a single result set that lists all the students?

CREATE DATABASE university_system; 

USE university_system;

CREATE TABLE Full_Time_Students (
	Student_ID INT PRIMARY KEY,
    NAME VARCHAR(50) NOT NULL,
    ENROLLMENT_DATE DATE NOT NULL,
    MAJOR VARCHAR(20) NOT NULL
);

DESCRIBE Full_Time_Students;

CREATE TABLE Part_Time_Students (
	Student_ID INT PRIMARY KEY,
    NAME VARCHAR(50) NOT NULL,
    ENROLLMENT_DATE DATE NOT NULL,
    MAJOR VARCHAR(20) NOT NULL
);

DESCRIBE Part_Time_Students;

INSERT INTO Full_Time_Students VALUES
(101, 'Ariana Lee', '2022-08-15', 'Computer Science'),
(102, 'Benjamin Cruz', '2021-07-20', 'Mechanical Engg'),
(103, 'Chloe Wang', '2023-01-10', 'Biology'),
(104, 'Daniel Patel', '2022-09-05', 'Business'),
(105, 'Emily Ross', '2023-02-01', 'Mathematics');

SELECT * FROM Full_Time_Students;

INSERT INTO Part_Time_Students VALUES
(201, 'Fiona Adams', '2023-03-12', 'Psychology'),
(202, 'George Smith', '2022-10-03', 'History'),
(203, 'Hannah Lin', '2023-01-18', 'Fine Arts'),
(204, 'Ivan Lopez', '2022-11-22', 'Computer Science'),
(205, 'Jasmine Khan', '2023-02-28', 'English Literature');

SELECT * FROM Part_Time_Students;

SELECT * FROM Full_Time_Students
UNION 
SELECT * FROM Part_Time_Students;

-- ----------------------------------------------------------------------------------------------------------------

-- Q6)
-- You are creating a report for a sales department. 
-- The report needs to show the total sales for each salesperson, but you want the column names to be more user-friendly. 
-- Instead of showing "SUM(sales_amount)", you want it to appear as "Total Sales".
-- How would you use aliases to modify the column headings in your result set?

CREATE DATABASE sales_department;

USE sales_department;

CREATE TABLE SALES (
    Sale_ID INT PRIMARY KEY,
    NAME VARCHAR(50) NOT NULL,
    SALES_AMOUNT DECIMAL(10, 2)
);

DESCRIBE SALES; 

INSERT INTO SALES VALUES
(1, 'Alice Johnson', 1200.50),
(2, 'Bob Smith', 800.00),
(3, 'Alice Johnson', 1500.00),
(4, 'Catherine Lee', 950.75),
(5, 'Bob Smith', 1340.20),
(6, 'David Kim', 1100.00),
(7, 'Catherine Lee', 980.00),
(8, 'Alice Johnson', 700.00);

SELECT * FROM SALES;

SELECT NAME AS SALESPERSON_NAME, SUM(SALES_AMOUNT) AS Total_Sales
FROM SALES
GROUP BY NAME; 

-- -----------------------------------------------------------------------------------------------

-- Q7)
-- In a database tracking the sales transactions of a retail store, you have a "sales" table containing transaction IDs, employee IDs, product IDs, quantities sold, and sale dates. 
-- You need to generate a report that shows the total quantity of each product sold per month, organized by product and month. 
-- How would you use the GROUP BY clause to aggregate this data?

CREATE DATABASE sales_transactions;

USE sales_transactions;

CREATE TABLE SALES (
	Transaction_ID INT PRIMARY KEY,
    EMPLOYEE_ID INT NOT NULL,
    PRODUCT_ID INT NOT NULL,
    Quantity_Sold INT NOT NULL,
    SALE_Date DATE NOT NULL
);

DESCRIBE SALES;

INSERT INTO SALES VALUES
(1, 101, 501, 2, '2024-01-10'),
(2, 102, 502, 1, '2024-01-15'),
(3, 103, 501, 3, '2024-01-20'),
(4, 101, 503, 5, '2024-02-05'),
(5, 102, 501, 4, '2024-02-12'),
(6, 104, 502, 2, '2024-02-18'),
(7, 103, 503, 1, '2024-03-01'),
(8, 101, 501, 2, '2024-03-07'),
(9, 104, 502, 3, '2024-03-15'),
(10, 102, 503, 4, '2024-03-20');

SELECT * FROM SALES;


SELECT PRODUCT_ID, COUNT(*) AS Total_quantity, MONTHNAME(SALE_DATE) AS Month_Name
FROM SALES
GROUP BY MONTH(SALE_Date), PRODUCT_ID, Month_name
ORDER BY PRODUCT_ID, MONTH(SALE_Date);

-- ------------------------------------------------------------------------------------------------------

-- Q8)
-- You are analyzing employee performance in a company. 
-- You have a table called "employee_sales" which records sales figures for each employee. 
-- You want to generate a list of employees who have made more than $10,000 in sales, but only include those employees who have made sales in at least 3 different regions. 
-- How would you use the HAVING clause to filter the data after applying GROUP BY?

CREATE DATABASE employee_performance;

USE employee_performance;

CREATE TABLE EMPLOYEE_SALES (
	SALE_ID INT PRIMARY KEY,
	Employee_ID INT NOT NULL,
    NAME VARCHAR(50) NOT NULL,
    REGION VARCHAR(30) NOT NULL,
    SALE_AMOUNT DECIMAL(12, 0) NOT NULL,
    SALE_Date DATE NOT NULL
);

DESCRIBE EMPLOYEE_SALES;

DROP TABLE EMPLOYEE_SALES;

INSERT INTO EMPLOYEE_SALES VALUES
(1, 101, 'Alice Johnson', 'North', 4500.00, '2024-01-10'),
(2, 101, 'Alice Johnson', 'South', 3800.00, '2024-01-12'),
(3, 101, 'Alice Johnson', 'East', 3200.00, '2024-01-14'),
(4, 102, 'Bob Smith', 'North', 2000.00, '2024-01-15'),
(5, 102, 'Bob Smith', 'North', 5200.00, '2024-01-17'),
(6, 103, 'Catherine Lee', 'East', 3500.00, '2024-01-18'),
(7, 103, 'Catherine Lee', 'West', 4000.00, '2024-01-19'),
(8, 103, 'Catherine Lee', 'South', 3000.00, '2024-01-20'),
(9, 104, 'David Kim', 'North', 8000.00, '2024-01-21'),
(10, 104, 'David Kim', 'East', 1000.00, '2024-01-22'),
(11, 105, 'Eva Brown', 'West', 9500.00, '2024-01-23'),
(12, 105, 'Eva Brown', 'South', 600.00, '2024-01-24'),
(13, 101, 'Alice Johnson', 'West', 6500.00, '2024-11-30');

SELECT * FROM EMPLOYEE_SALES;

SELECT NAME, SUM(SALE_AMOUNT) AS Total_Sale, COUNT(REGION) AS No_of_Regions
FROM EMPLOYEE_SALES
GROUP BY NAME
HAVING Total_Sale > 10000
AND 
COUNT(REGION) >= 3;
















