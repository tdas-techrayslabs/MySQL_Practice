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

-- ------------------------------------------------------------------------------------------------------

-- Q9) 
-- You have a products table with columns: product_id, product_name, price, and category. 
-- Create a stored procedure to insert a new product into the table.

CREATE DATABASE product_system;

USE product_system;

CREATE TABLE PRODUCT (
	Product_ID INT PRIMARY KEY,
    PRODUCT_NAME VARCHAR(50) NOT NULL,
    PRICE DECIMAL(10,2) NOT NULL,
    CATEGORY VARCHAR(20) NOT NULL
);

DESCRIBE PRODUCT;

CALL insert_into_Product_Table(1, 'Mobile', 25999.99, 'Electronics');

SELECT * FROM PRODUCT;

-- ---------------------------------------------------------------------------------------------------------

-- Q10)
-- You have a products table with columns product_id, product_name, and price. 
-- Create a stored procedure to update the price of a product based on the provided product_id.

SELECT * FROM PRODUCT;

CALL update_price_Product_Table(1, 23670.45);

SELECT * FROM PRODUCT;

-- -------------------------------------------------------------------------------------------------------------

-- Q11) 
-- You have two tables: employees and departments. 
-- The employees table contains employee_id, first_name, last_name, salary, and department_id. 
-- The departments table contains department_id and department_name. 
-- You need to create a stored procedure to get employee details along with the department name.

CREATE DATABASE employee_department_system;

USE employee_department_system;

CREATE TABLE EMPLOYEES (
	Employee_ID INT PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    SALARY DECIMAL(12, 2) NOT NULL,
    DEPARTMENT_ID VARCHAR(20) NOT NULL,
    CONSTRAINT fk_Department_Id FOREIGN KEY(DEPARTMENT_ID) REFERENCES DEPARTMENTS(DEPARTMENT_ID) 
);

DESCRIBE EMPLOYEES;

CREATE TABLE DEPARTMENTS (
	DEPARTMENT_ID VARCHAR(20) PRIMARY KEY,
    DEPARTMENT_NAME VARCHAR(40) NOT NULL
);

DESCRIBE DEPARTMENTS;

INSERT INTO DEPARTMENTS VALUES
('D001', 'Human Resources'),
('D002', 'Finance'),
('D003', 'Engineering'),
('D004', 'Sales'),
('D005', 'Marketing');

SELECT * FROM DEPARTMENTS;

INSERT INTO EMPLOYEES VALUES
(101, 'Alice', 'Johnson', 75000.00, 'D003'),
(102, 'Bob', 'Smith', 65000.00, 'D002'),
(103, 'Charlie', 'Brown', 72000.00, 'D004'),
(104, 'Diana', 'Prince', 80000.00, 'D005'),
(105, 'Ethan', 'Hunt', 68000.00, 'D001');

SELECT * FROM EMPLOYEES;

CALL get_employee_details_with_department_name();

-- ------------------------------------------------------------------------------------

-- Q12) 
-- You have a column email in a table users. 
-- Write a query to extract the domain name (e.g., "example.com") from the email addresses.

CREATE DATABASE users_system;

USE users_system;

CREATE TABLE USERS (
	USER_ID INT PRIMARY KEY,
    NAME VARCHAR(50) NOT NULL,
    EMAIL VARCHAR(50) NOT NULL
);

DESCRIBE USERS;

INSERT INTO USERS VALUES
(1, 'Alice Johnson', 'alice.johnson@gmail.com'),
(2, 'Bob Smith', 'bob.smith@yahoo.com'),
(3, 'Charlie Brown', 'charlie.brown@example.com'),
(4, 'Diana Prince', 'diana.p@company.org'),
(5, 'Ethan Hunt', 'ethan.hunt@imf.gov'),
(6, 'Fiona Glenanne', 'fiona.g@burnnotice.tv'),
(7, 'George Martin', 'g.martin@westeros.com'),
(8, 'Hannah Lee', 'hannah.lee@uni.edu'),
(9, 'Isaac Newton', 'isaac.newton@science.uk'),
(10, 'Jane Doe', 'jane.doe@unknown.net');

SELECT * FROM USERS;

SELECT NAME, EMAIL, SUBSTR(EMAIL, INSTR(EMAIL, '@')+1) AS Domain_Name
FROM USERS;

-- ----------------------------------------------------------------------------------

-- Q13)
-- You have a column first_name in a table employees. 
-- Write a query to convert all the values in first_name to uppercase.

USE employee_department_system;

SELECT * FROM EMPLOYEES;

SELECT First_Name, UCASE(First_Name) AS Uppercase
FROM EMPLOYEES;

-- ------------------------------------------------------------------------------------

-- Q14) 
-- You have a column address in the table customers, which stores customer addresses. 
-- Write a query to extract the first 10 characters of the address for every customer.

CREATE DATABASE customer_system;

USE customer_system;

CREATE TABLE CUSTOMERS (
	NAME VARCHAR(50) PRIMARY KEY,
    ADDRESS VARCHAR(255) NOT NULL
);

DESCRIBE CUSTOMERS;

INSERT INTO CUSTOMERS VALUES
('Alice Johnson', '123 Maple Street, Springfield, IL 62701'),
('Bob Smith', '456 Oak Avenue, Denver, CO 80203'),
('Charlie Brown', '789 Pine Road, Austin, TX 73301'),
('Diana Prince', '101 Justice Blvd, Washington, DC 20001'),
('Ethan Hunt', '007 Secret Lane, London, UK SW1A 1AA'),
('Fiona Glenanne', '303 Ocean Drive, Miami, FL 33139'),
('George Martin', '12 Castle Hill, Westeros, Seven Kingdoms'),
('Hannah Lee', '88 Academic Way, Boston, MA 02115'),
('Isaac Newton', '1 Gravity Court, Cambridge, UK CB2 1TN'),
('Jane Doe', '500 Mystery St, Unknown City, XX 99999');

SELECT * FROM CUSTOMERS;

SELECT NAME, ADDRESS, LEFT(ADDRESS, 10) AS Extracted_Address
FROM CUSTOMERS; 

-- ------------------------------------------------------------------------------

-- Q15)
-- You have a column product_code in the table products, and each product code starts with the letters “P-”. 
-- Write a query to remove the prefix "P-" from all the product codes.

CREATE TABLE PRODUCTS (
	PRODUCT_CODE VARCHAR(10) PRIMARY KEY CHECK(PRODUCT_CODE LIKE 'P-%'),
    PRODUCT_NAME VARCHAR(50) NOT NULL
);

DESCRIBE PRODUCTS;

INSERT INTO PRODUCTS VALUES
('P-001', 'Wireless Mouse'),
('P-002', 'Mechanical Keyboard'),
('P-003', '27-inch Monitor'),
('P-004', 'USB-C Hub'),
('P-005', 'External Hard Drive'),
('P-006', 'Bluetooth Speaker'),
('P-007', 'Gaming Headset'),
('P-008', 'Webcam 1080p'),
('P-009', 'Laptop Stand'),
('P-010', 'Smartphone Holder');

SELECT * FROM PRODUCTS;

SELECT PRODUCT_CODE, SUBSTR(PRODUCT_CODE, 3) AS New_Product_Code 
FROM PRODUCTS; -- --------------------------------------------------------------------------------------------------------------------------------------------------------------

-- ----------------------------------------------------------------------------------

-- Q16) 
-- You have a column description in the table items, which contains product descriptions with varying white spaces. 
-- Write a query to trim the leading and trailing spaces from the description.

CREATE TABLE ITEMS (
	ITEM_ID INT PRIMARY KEY,
    ITEM_NAME VARCHAR(50) NOT NULL,
    DESCRIPTION TINYTEXT NOT NULL
);

DESCRIBE ITEMS;

INSERT INTO ITEMS VALUES
(1, 'Wireless Mouse', '   Ergonomic wireless mouse with   USB receiver   '),
(2, 'Keyboard', 'Compact     mechanical keyboard with RGB lighting'),
(3, 'Monitor', '   27-inch   full HD monitor     for work and gaming   '),
(4, 'Laptop Stand', 'Adjustable    aluminum laptop stand'),
(5, 'Webcam', ' Full HD 1080p webcam    with built-in microphone  ');

SELECT * FROM ITEMS;

SELECT ITEM_NAME, DESCRIPTION, CHAR_LENGTH(DESCRIPTION) AS Length_of_original_desc, LTRIM(RTRIM(DESCRIPTION)) AS New_Description, CHAR_LENGTH(LTRIM(RTRIM(DESCRIPTION))) AS Length_of_new_desc
FROM ITEMS;

-- ---------------------------------------------------------------------------------------------

-- Q17)
-- You have a column description in the products table. 
-- Write a query to replace any occurrence of the word "old" in the description column with the word "new".

CREATE DATABASE practice_db;

USE practice_db;

CREATE TABLE PRODUCTS (
	PRODUCT_ID INT PRIMARY KEY,
    PRODUCT_NAME VARCHAR(50) NOT NULL,
    DESCRIPTION TINYTEXT NOT NULL
);

DESCRIBE PRODUCTS;

INSERT INTO PRODUCTS VALUES
(1, 'Smartphone', 'This is an old model with basic features'),
(2, 'Laptop', 'Slightly old version but still reliable'),
(3, 'Headphones', 'An old-school design with modern sound'),
(4, 'Camera', 'Perfect for capturing moments with the old lens'),
(5, 'Smartwatch', 'Not the old one, this version is improved');

SELECT * FROM PRODUCTS;

SELECT PRODUCT_NAME, DESCRIPTION, REPLACE(DESCRIPTION, 'old', 'new') AS NEW_DESCRIPTION
FROM PRODUCTS;

-- -----------------------------------------------------------------------------------------------------------------------

-- Q18)
-- You have a column full_name in the table staff. 
-- Write a query to extract the first name and last name from the full_name column assuming the names are separated by a space.

CREATE TABLE STAFF (
	STAFF_ID INT PRIMARY KEY,
    FULL_NAME VARCHAR(50) NOT NULL
);

DESCRIBE STAFF;

INSERT INTO STAFF VALUES
(1, 'Alice Johnson'),
(2, 'Bob Smith'),
(3, 'Charlie Brown'),
(4, 'Diana Prince'),
(5, 'Ethan Hunt'),
(6, 'Fiona Glenanne'),
(7, 'George Martin'),
(8, 'Hannah Lee'),
(9, 'Isaac Newton'),
(10, 'Jane Doe');

SELECT * FROM STAFF;

SELECT FULL_NAME, SUBSTRING_INDEX(FULL_NAME, ' ', 1) AS FIRST_NAME, SUBSTR(FULL_NAME, INSTR(FULL_NAME, ' ')+1) AS LAST_NAME
FROM STAFF;

-- ---------------------------------------------------------------------------------------------------------------------------

-- Q19)
-- You have a column price in the table items. 
-- Write a query to calculate the average price of all items in the table.

CREATE TABLE ITEMS (
	Item_Id INT PRIMARY KEY,
    Item_Name VARCHAR(50) NOT NULL,
    Price DECIMAL(10,2) NOT NULL
);

DESCRIBE ITEMS;

INSERT INTO ITEMS VALUES
(1, 'Wireless Mouse', 25.99),
(2, 'Mechanical Keyboard', 79.49),
(3, 'Monitor', 199.99),
(4, 'USB-C Hub', 34.50),
(5, 'Laptop Stand', 29.95),
(6, 'Webcam', 59.99),
(7, 'Bluetooth Speaker', 45.75),
(8, 'External Hard Drive', 89.00),
(9, 'Smartphone Holder', 15.25),
(10, 'Desk Lamp', 22.89);

SELECT * FROM ITEMS;

SELECT ROUND(AVG(PRICE), 2) AS Average_Price 
FROM ITEMS;

-- ----------------------------------------------------------------------------------

-- Q20)
-- You have a column quantity in the table sales. 
-- Write a query to find the highest quantity sold for any item.

CREATE TABLE SALES (
	SALE_ID INT PRIMARY KEY,
    ITEM_NAME VARCHAR(50) NOT NULL,
    QUANTITY INT NOT NULL
);

DESCRIBE SALES;

INSERT INTO SALES VALUES
(1, 'Wireless Mouse', 50),
(2, 'Mechanical Keyboard', 35),
(3, 'Monitor', 20),
(4, 'USB-C Hub', 70),
(5, 'Laptop Stand', 40),
(6, 'Webcam', 55),
(7, 'Bluetooth Speaker', 60),
(8, 'External Hard Drive', 30),
(9, 'Smartphone Holder', 90),
(10, 'Desk Lamp', 45);

SELECT * FROM SALES;

SELECT  MAX(QUANTITY) AS Highest_Quantity_Sold
FROM SALES;

SELECT ITEM_NAME, QUANTITY AS Highest_Quantity_Sold
FROM SALES
WHERE QUANTITY = (
	SELECT MAX(QUANTITY) 
    FROM SALES
);

-- ---------------------------------------------------------------------------------------------------

-- Q21)
-- You have a column amount in the table transactions. 
-- Write a query to round off the value of amount to two decimal places for each transaction.

CREATE TABLE TRANSACTIONS (
	TRANSACTION_ID INT PRIMARY KEY,
    TRANSACTION_DATE DATE NOT NULL,
	AMOUNT DECIMAL(14,6) NOT NULL
);

DESCRIBE TRANSACTIONS;

INSERT INTO TRANSACTIONS VALUES
(1, '2025-04-01', 150.4567),
(2, '2025-04-02', 200.9876),
(3, '2025-04-03', 350.2234),
(4, '2025-04-04', 99.8888),
(5, '2025-04-05', 450.6789),
(6, '2025-04-06', 100.5499),
(7, '2025-04-07', 599.9999),
(8, '2025-04-08', 125.0045),
(9, '2025-04-09', 789.1234),
(10, '2025-04-10', 999.8765);

SELECT * FROM TRANSACTIONS;

SELECT TRANSACTION_ID, AMOUNT, ROUND(AMOUNT, 2) AS Rounded_Amount
FROM TRANSACTIONS;

-- ---------------------------------------------------------------------------------------------------------------

-- Q22)
-- You have a column total_sales in the table store. 
-- Write a query to calculate the sum of all sales in the table and find out if the total sales exceed 1,000,000.

CREATE TABLE STORE (
	STORE_ID INT PRIMARY KEY,
    STORE_NAME VARCHAR(50) NOT NULL,
    TOTAL_SALES DECIMAL(15,2) NOT NULL
);

DESCRIBE STORE;

INSERT INTO STORE VALUES
(1, 'Downtown Market', 250000.00),
(2, 'Uptown Superstore', 180500.75),
(3, 'City Center Plaza', 120300.25),
(4, 'Westside Mart', 305600.00),
(5, 'Lakeside Retail', 195000.50);

SELECT * FROM STORE;

SELECT 
SUM(TOTAL_SALES) AS Total_Sales,
CASE
WHEN SUM(TOTAL_SALES) > 1000000 
THEN 'Yes'
ELSE 'No'
END AS EXCEEDS_1000000
FROM STORE;

-- --------------------------------------------------------------------------------------------------

-- Q23)
-- You have a column order_date in the table orders, which stores the date of each order. 
-- Write a query to extract the year part of the order_date for all orders.

CREATE TABLE ORDERS (
	ORDER_ID INT PRIMARY KEY,
    ORDER_DATE DATE NOT NULL
);

DESCRIBE ORDERS;

INSERT INTO ORDERS VALUES
(1, '2025-04-01'),
(2, '2023-04-02'),
(3, '2017-04-03'),
(4, '2003-04-04'),
(5, '2021-04-05'),
(6, '2018-04-06'),
(7, '2022-04-07'),
(8, '2020-04-08'),
(9, '2012-04-09'),
(10, '2014-04-10');

SELECT * FROM ORDERS;

SELECT ORDER_ID, ORDER_DATE, YEAR(ORDER_DATE) AS Year
FROM ORDERS;

-- -------------------------------------------------------------------------------------

-- Q24)
-- You have a column price in the table products. 
-- Write a query to find the difference between the maximum and minimum price of all products.

CREATE TABLE PRODUCTS_New (
	PRODUCT_ID INT PRIMARY KEY,
    PRODUCT_NAME VARCHAR(50) NOT NULL,
    PRICE DECIMAL(10,2) NOT NULL
);

DESCRIBE PRODUCTS_New;

INSERT INTO PRODUCTS_New VALUES
(1, 'Smartphone', 699.99),
(2, 'Laptop', 1299.50),
(3, 'Tablet', 499.00),
(4, 'Smartwatch', 199.99),
(5, 'Bluetooth Speaker', 149.95),
(6, 'Monitor', 299.99),
(7, 'Keyboard', 89.90),
(8, 'Mouse', 59.99),
(9, 'Headphones', 159.00),
(10, 'Webcam', 109.75);

SELECT * FROM PRODUCTS_New;

SELECT MAX(PRICE), MIN(PRICE), (MAX(PRICE) - MIN(PRICE)) AS Price_Difference
FROM PRODUCTS_New;

-- --------------------------------------------------------------------------------------------------------------------

-- Q25)
-- You have a column rating in the table reviews where each rating is a decimal. 
-- Write a query to find the total number of reviews that have a rating greater than or equal to 4.5.

CREATE TABLE REVIEWS (
	REVIEW_ID INT PRIMARY KEY,
    RATING DECIMAL(2,1) NOT NULL
);

DESCRIBE REVIEWS;

INSERT INTO REVIEWS VALUES
(1, 4.5),
(2, 3.8),
(3, 5.0),
(4, 2.9),
(5, 4.2),
(6, 1.7),
(7, 3.3),
(8, 4.9),
(9, 2.5),
(10, 3.0);

SELECT * FROM REVIEWS;

SELECT COUNT(*) AS No_of_rating
FROM REVIEWS
WHERE RATING >= 4.5;

































