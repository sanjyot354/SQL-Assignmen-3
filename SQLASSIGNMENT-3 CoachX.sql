--ASSIGNMENT SOLVE:
CREATE DATABASE SHIVAJI_University;
USE SHIVAJI_University;
--1.Create College_Table :-(Parent table)

CREATE TABLE College_Table (
             College_Id INT NOT NULL PRIMARY KEY,
			 College_Name VARCHAR (100) NOT NULL,
			 College_Area VARCHAR (200) NOT NULL,
			 );

--2.Create Department_Table :-(Child Table)
CREATE TABLE Department_Table (
             Dept_Id INT NOT NULL PRIMARY KEY ,
			 Dept_Name VARCHAR (100) NOT NULL,
			 Dept_Facility VARCHAR (100) NOT NULL ,
			 College_Id INT 
			 FOREIGN KEY (College_Id) REFERENCES College_Table (College_Id)
			 );

--3.Create Professor_Table :-
CREATE TABLE Professor_Table (
             Professor_ID  INT PRIMARY KEY,
             Professor_Name VARCHAR(100),
             Professor_Subject VARCHAR (50)
			 );

--4.Create Student_Table:-
CREATE TABLE Student_Table(
             Student_Id INT PRIMARY KEY ,
			 Student_Name VARCHAR (100),
			 Student_Stream VARCHAR (100),
			 Professor_ID INT
			 FOREIGN KEY (Professor_ID) REFERENCES Professor_Table (Professor_ID)
			 );

--Insert atleast 10 record ineach Table :-
--1.College_Table:-
INSERT INTO College_Table ( College_Id,College_Name,College_Area)
VALUES (1, 'Sunrise College','Kolhapur'),
       (2,'Karmiver College','Pandharpur'),
	   (3,'Shivaji Colege','Sangli'),
	   (4,'Sinhgad college', 'Satara'),
	   (5,'Vidyaniketan College','Sangola'),
	   (6,'Dayanand college','Pune'),
	   (7,'Bright Future College','Jalna'),
	   (8,'Sant Tukaram College','Jat'),
	   (9,'Rajarshi Shahu College','Sangavi'),
	   (10,'Savitribai Phule College ', 'Akluj');

--2.Department_Table:-
INSERT INTO Department_Table (Dept_Id, Dept_Name, Dept_Facility, College_Id)
VALUES
      (1, 'Computer Science', 'Lab, Wi-Fi, Library', 1),
      (2, 'Mechanical Engineering', 'Workshop, Lab, CAD Center', 2),
      (3, 'Electronics', 'Circuit Lab, Robotics Lab', 3),
      (4, 'Civil Engineering', 'Survey Lab, Concrete Testing', 4),
      (5, 'Information Technology', 'Computer Lab, Wi-Fi', 5),
      (6, 'Physics', 'Research Lab, Smart Classrooms', 6),
      (7, 'Chemistry', 'Chem Lab, Safety Equipment', 7),
      (8, 'Mathematics', 'Study Center, Seminar Hall', 8),
      (9, 'Biotechnology', 'Bio Lab, Research Equipment', 9),
      (10, 'Business Administration', 'Conference Hall, Smart Boards', 10);

--3.Proffessor_Table :-
INSERT INTO Professor_Table (Professor_ID, Professor_Name, Professor_Subject)
VALUES
      (1, 'Dr. Meera Sharma', 'Mathematics'),
      (2, 'Dr. Rajesh Kumar', 'Physics'),
      (3, 'Prof. Anita Desai', 'Chemistry'),
      (4, 'Dr. Suresh Iyer', 'Computer Science'),
      (5, 'Prof. Neha Verma', 'English'),
      (6, 'Dr. Arjun Reddy', 'Mechanical Engineering'),
      (7, 'Prof. Kavita Nair', 'Biology'),
      (8, 'Dr. Rohan Malhotra', 'Economics'),
      (9, 'Prof. Sneha Joshi', 'Civil Engineering'),
      (10, 'Dr. Vikram Chauhan', 'Business Administration');

--4.Students_Table:-
INSERT INTO Student_Table(  Student_Id ,Student_Name ,Student_Stream , Professor_ID )
VALUES (1, 'Amit Patel', 'Computer Science', 4),
       (2, 'Priya Sharma', 'Mechanical Engineering', 6),
       (3, 'Rohan Mehta', 'Mathematics', 1),
       (4, 'Sneha Nair', 'Physics', 2),
       (5, 'Vikas Reddy', 'Chemistry', 3),
       (6, 'Neha Verma', 'Biology', 7),
       (7, 'Karan Singh', 'Civil Engineering', 9),
       (8, 'Simran Kaur', 'English', 5),
       (9, 'Tanya Joshi', 'Business Administration', 10),
       (10, 'Rahul Deshmukh', 'Economics', 8);

--Task 1:- 
--1. Give the information of College_ID and College_name from College_Table.
SELECT College_ID , College_Name
FROM College_Table;

--2. Show  Top 5 rows from Student table.
SELECT TOP 5 *
FROM Student_Table;

--3. What is the name of  professor  whose ID  is 5 .
SELECT * FROM Professor_Table
WHERE Professor_ID=5;

--4. Convert the name of the Professor into Upper case .
SELECT Professor_ID,
UPPER (Professor_Name) AS Professor_Name_Upper,
Professor_Subject
FROM Professor_Table;

--5. Show me the names of those students whose name is start with 'a'.
SELECT * FROM Student_Table
WHERE Student_Name LIKE 'a%';

--6. Give the name of those colleges whose end with 'a'.
SELECT * FROM College_Table
WHERE College_Name LIKE '%a';

--7.  Add one Salary Column in Professor_Table .
ALTER TABLE Professor_Table
ADD Salary INT ;

--8. Add one Contact Column in Student_table.
ALTER TABLE Student_Table 
ADD Contact INT ;

--9. Find the total Salary of Professor .
SELECT SUM (Salary) AS Total_Salary
FROM Professor_Table;

--10. Change datatype of any one column of any one Table.
ALTER TABLE Professor_Table 
ALTER COLUMN Salary DECIMAL (5,2 );

--Task 3:- 
--1. Show first 5 records from Students table and Professor table Combine.
SELECT TOP 5 * FROM Student_Table
SELECT TOP 5 * FROM Professor_Table ;

--2. Apply Inner join on all 4 tables together(Syntax  is mandatory) .
SELECT S.Student_Id, S.Student_Name , S.Student_Stream,
       P.Professor_ID, P.Professor_Name ,
	   D.Dept_Name , D.Dept_Facility,
	   C.College_Id,C.College_Name ,C.College_Area
FROM Student_Table S
INNER JOIN Professor_Table  P
ON S.Professor_ID= P.Professor_ID
INNER JOIN Department_Table  D
ON P.Professor_ID=D.Dept_Id
INNER JOIN College_Table C
ON D.College_Id = C.College_Id  ;

--3. Show Some null values from Department table and Professor table.
SELECT D.Dept_Id ,D.Dept_Name , D.Dept_Facility,
      P.Professor_Name ,P.Professor_Subject, P.Salary 
	  FROM Department_Table D
	  LEFT JOIN Professor_Table  P
	  ON D.Dept_Id=P.Professor_ID;

--4. Create a View from College Table  and give those records whose college name starts with C .
CREATE VIEW Colleges_StartsWith_C AS 
SELECT College_Id,
       College_Name ,
       College_Area
FROM College_Table
WHERE College_Name LIKE 'C%';

/*5. Create Stored Procedure  of Professor table whatever customer ID will be 
given by user it should show whole records of it. */
CREATE PROCEDURE GetProfessorInfo (@ProfessorId INT)
 AS 
 BEGIN 
 SELECT * FROM Professor_Table
 WHERE Professor_ID = @ProfessorId
 END;

 EXEC GetProfessorInfo @ProfessorId=1;
 EXEC GetProfessorInfo @ProfessorId=2;
 EXEC GetProfessorInfo @ProfessorId=3;
 EXEC GetProfessorInfo @ProfessorId=4;
 EXEC GetProfessorInfo @ProfessorId=5;
 EXEC GetProfessorInfo @ProfessorId=6;
 EXEC GetProfessorInfo @ProfessorId=7;
 EXEC GetProfessorInfo @ProfessorId=8;
 EXEC GetProfessorInfo @ProfessorId=9;
 EXEC GetProfessorInfo @ProfessorId=10;

 --6. Rename the College_Table to College_Tables_Data .
 EXEC sp_rename 'College_Table' ,'College_Table_Data';