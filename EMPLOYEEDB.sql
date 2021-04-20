create  database EMPLOYEEDB;

create table department(dep_id integer not null primary key, dep_name varchar(20),dep_location varchar(15));

insert into department(dep_id,dep_name,dep_location)values (1001,'FINANCE','SYDNEY');
insert into department(dep_id,dep_name,dep_location)values (2001,'AUDIT','MELBOURNE');
insert into department(dep_id,dep_name,dep_location)values (3001,'MARKETING','PERTH');
insert into department(dep_id,dep_name,dep_location)values (4001,'PRODUCTION','BRISBANE');

 

create table employees(emp_id integer primary key,emp_name varchar(15),job_name varchar(15),
manager_id integer, hire_date date,salary decimal(10,2),commission decimal(7,2),
dep_id integer,FOREIGN KEY (dep_id) REFERENCES department(dep_id) );

insert into employees(emp_id,emp_name,job_name,manager_id,hire_date,salary,commission,dep_id)values(68319,'KAYLING','PRESIDENT',NULL,'1991-11-18',6000,NULL,1001);
insert into employees(emp_id,emp_name,job_name,manager_id,hire_date,salary,commission,dep_id)values(66928,'BLAZE','MANAGER',68319,'1991-05-01',2750,NULL,3001);
insert into employees(emp_id,emp_name,job_name,manager_id,hire_date,salary,commission,dep_id)values(67832,'CLARE','MANAGER',68319,'1991-06-09',2550,NULL,1001);
insert into employees(emp_id,emp_name,job_name,manager_id,hire_date,salary,commission,dep_id)values(65646,'JONAS','MANAGER',68319,'1991-04-02',2957,NULL,2001);
insert into employees(emp_id,emp_name,job_name,manager_id,hire_date,salary,commission,dep_id)values(67858,'SCARLET','ANALYST',65646,'1997-04-19',3100,NULL,2001);
insert into employees(emp_id,emp_name,job_name,manager_id,hire_date,salary,commission,dep_id)values(69062,'FRANK','ANALYST',65646,'1991-12-03',3100,NULL,2001);
insert into employees(emp_id,emp_name,job_name,manager_id,hire_date,salary,commission,dep_id)values(63679,'SANDRINE','CLERK',69062,'1990-12-18',900,NULL,2001);
insert into employees(emp_id,emp_name,job_name,manager_id,hire_date,salary,commission,dep_id)values(64989,'ADELYN','SALESMAN',66928,'1991-02-20',1700,400,3001);
insert into employees(emp_id,emp_name,job_name,manager_id,hire_date,salary,commission,dep_id)values(65271,'WADE','SALESMAN',66928,'1991-02-22',1350,600,3001);
insert into employees(emp_id,emp_name,job_name,manager_id,hire_date,salary,commission,dep_id)values(66564,'MADDEN','SALESMAN',66928,'1991-09-28',1350,1500,3001);
insert into employees(emp_id,emp_name,job_name,manager_id,hire_date,salary,commission,dep_id)values(68454,'TUCKER','SALESMAN',66928,'1991-09-08',1600,0,3001);
insert into employees(emp_id,emp_name,job_name,manager_id,hire_date,salary,commission,dep_id)values(68736,'ADNRES','CLERK',67858,'1997-05-23',1200,NULL,2001);
insert into employees(emp_id,emp_name,job_name,manager_id,hire_date,salary,commission,dep_id)values(69000,'JULIUS','CLERK',66928,'1991-12-03',1050,NULL,3001);
insert into employees(emp_id,emp_name,job_name,manager_id,hire_date,salary,commission,dep_id)values(69324,'MARKER','CLERK',67832,'1992-01-23',1400,NULL,1001);

create table salary_grade(grade integer primary key,min_salary integer, max_salary integer);

insert into salary_grade(grade,min_salary,max_salary)values (1,800,1300);
insert into salary_grade(grade,min_salary,max_salary)values (2,1301,1500);
insert into salary_grade(grade,min_salary,max_salary)values (3,1501,2100);
insert into salary_grade(grade,min_salary,max_salary)values (4,2101,3100);


SELECT * from employees where( SELECT DATEDIFF(year, hire_date, GETDATE())),0)) IN >27;

 
 select * from employees

SELECT *
FROM employees
WHERE EXTRACT(YEAR FROM age((SELECT DATEDIFF(year, '2010-03-13', GETDATE())), 0), hire_date)) > 27; 

SELECT * from employees where salary<3500 ;

SELECT emp_name,job_name,salary from employees where job_name='ANALYST';

SELECT * from employees where TO_CHAR();

SELECT emp_name,emp_id,salary,hire_date from employees where hire_date < '1991-04-01';

SELECT emp_name, job_name from employees where manager_id is NULL;
SELECT emp_id,
       emp_name,
       salary,
       age (GETDATE(), hire_date) as  "Experience"
FROM employees
WHERE manager_id=68319;

SELECT MAX(salary)
FROM(select * from ( select  salary from  employees order by salary asc ));

SELECT *
FROM employees
WHERE MOD(salary,2) = 1;

SELECT emp_name,
       CHAR(1.15*salary,'$99,999') AS "Salary"
FROM employees;

SELECT emp_name || '   ' || job_name AS "Employee & Job"
FROM employees ;

SELECT emp_name | '('| lower(job_name)|')' AS "Employee"
FROM employees;