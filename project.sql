create database employee;
use employee;

CREATE TABLE emp_record (
emp_id VARCHAR(6) not null PRIMARY KEY,
f_name VARCHAR(10) not null,
l_name VARCHAR(10) not null,
gender VARCHAR(10) not null,
role VARCHAR(30) not null,
dept VARCHAR(15) not null,
exp INT not null,
country VARCHAR(15) not null,
continent VARCHAR(15) not null,
salary INT not null,
emp_rating INT not null,
manager_id VARCHAR(5),
proj_id varchar(5));	

describe emp_record;
select * from emp_record;

CREATE TABLE proj_table (
proj_id varchar(7) not null PRIMARY KEY,
proj_name VARCHAR(30) not null,
domain VARCHAR(15) not null,
start_date DATE not null,
closure_date DATE not null,
dev_qtr VARCHAR(4) not null,
status VARCHAR(10) not null);

drop table proj_table;
select * from proj_table;
describe proj_table;

CREATE TABLE data_sci_team (
emp_id VARCHAR(6) not null PRIMARY KEY,
f_name VARCHAR(10) not null,
l_name VARCHAR(10) not null,
gender VARCHAR(10) not null,
role VARCHAR(30) not null,
dept VARCHAR(15) not null,
exp INT not null,
country VARCHAR(15) not null,
continent VARCHAR(15) not null);

describe data_sci_team;

SELECT emp_id, f_name, l_name, gender, dept
FROM emp_record;

select emp_id,f_name,l_name,gender,dept,emp_rating
from emp_record
where emp_rating < 2;
select emp_id,f_name,l_name,gender,dept,emp_rating
from emp_record
where emp_rating > 4;

select emp_id,f_name,l_name,gender,dept,emp_rating
from emp_record
where emp_rating BETWEEN 2 and 4;

select concat(f_name,' ',l_name) as Name from emp_record where dept = 'FINANCE';
select * from emp_record;
select role,manager_id,count(*)
from emp_record
group by manager_id;

select * from emp_record;
SELECT f_name, l_name, dept
FROM emp_record
WHERE dept = 'HEALTHCARE'
UNION
SELECT f_name, l_name, dept
FROM emp_record
WHERE dept = 'FINANCE';

SELECT emp_id, f_name, l_name, role, dept, emp_rating, emp_rating AS max_rating
FROM emp_record
WHERE (dept, emp_rating)
IN (SELECT dept, MAX(emp_rating) FROM emp_record GROUP By dept)
ORDER BY dept ASC;

SELECT role, MIN(salary) AS minSalary, MAX(salary) AS maxSalary
FROM emp_record
GROUP BY role;

SELECT f_name, l_name, exp as experience,
DENSE_RANK() OVER (ORDER BY exp DESC) exp_rank
FROM emp_record;

CREATE VIEW 6K_salary AS
SELECT emp_id, f_name, l_name, country, salary
FROM emp_record
WHERE salary > 6000;
SELECT * FROM 6k_salary;

SELECT emp_id, f_name, l_name, exp
FROM emp_record
WHERE exp IN (
SELECT exp
FROM emp_record
WHERE exp > 10
);

DELIMITER //
CREATE PROCEDURE Employee3()
BEGIN
SELECT * FROM emp_record
WHERE exp > 3;
END //
DELIMITER ;
CALL Employee3;

DELIMITER //
CREATE PROCEDURE check_role()
BEGIN
  SELECT * FROM emp_record
  CASE
     WHEN exp <= 2 THEN SET role = 'JUNIOR DATA SCIENTIST';
     WHEN exp BETWEEN 3 AND 5 THEN SET role = 'ASSOCIATE DATA SCIENTIST';
     WHEN exp BETWEEN 11 AND 12 THEN SET role = 'LEAD DATA SCIENTIST';
     WHEN exp BETWEEN 13 AND 16 THEN SET role = 'MANAGER';
     ELSE SET role = 'all good';
  END CASE;
END //
DELIMITER ; 

ALTER TABLE emp_record ADD INDEX fname_index (f_name);
SELECT * FROM emp_record WHERE f_name = 'Eric';

SELECT f_name, l_name, salary, ((salary * .05)*emp_rating) AS bonus
FROM emp_record;

SELECT continent, AVG(salary)
FROM emp_record
GROUP BY continent
ORDER BY continent ASC;