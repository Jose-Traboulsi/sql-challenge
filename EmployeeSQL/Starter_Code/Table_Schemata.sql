DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS titles;


CREATE TABLE titles(
	title_id VARCHAR(5) PRIMARY KEY NOT NULL,
	title VARCHAR(20) NOT NULL
);

CREATE TABLE employees(
	emp_no INTEGER PRIMARY KEY NOT NULL,
	emp_title_id VARCHAR(5) NOT NULL,
	birth_date TEXT, 	-- Some people may not want to answer, so we account for null rows
	first_name VARCHAR(35) NOT NULL,
	last_name VARCHAR(35) NOT NULL,
	sex VARCHAR(5),		-- Some people may not want to answer this question either, so we account for null rows
	hire_date TEXT NOT NULL,
	FOREIGN KEY(emp_title_id) REFERENCES titles(title_id)
);

CREATE TABLE employees_temp (
	emp_no INTEGER PRIMARY KEY NOT NULL,
	emp_title_id VARCHAR(5) NOT NULL,
	birth_date TEXT,
	first_name VARCHAR(35) NOT NULL,
	last_name VARCHAR(35) NOT NULL,
	sex VARCHAR(5),
	hire_date TEXT NOT NULL,
	FOREIGN KEY(emp_title_id) REFERENCES titles(title_id)
);

INSERT INTO employees (emp_no, emp_title_id, birth_Date, first_name, last_name, sex, hire_date)
SELECT
	et.emp_no,
	et.emp_title_id,
	TO_DATE(et.birth_date, 'MM-DD-YYYY'),
	et.first_name,
	et.last_name,
	et.sex,
	TO_dATE(et.hire_date, 'MM-DD-YYYY')
FROM employees_temp AS et;

SELECT * FROM employees;

DROP TABLE employees_temp;

CREATE TABLE departments(
	dept_no VARCHAR(4) PRIMARY KEY NOT NULL,
	dept_name VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE salaries(
	emp_no INTEGER PRIMARY KEY NOT NULL,
	salary INTEGER NOT NULL,
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no)
);

CREATE TABLE dept_emp(
	emp_no INTEGER NOT NULL,
	dept_no VARCHAR(4) NOT NULL,
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY(dept_no) REFERENCES departments(dept_no),
	PRIMARY KEY(emp_no, dept_no)
);

CREATE TABLE dept_manager(
	dept_no VARCHAR(4) NOT NULL,
	emp_no INTEGER NOT NULL,
	FOREIGN KEY(dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY(emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY(dept_no, emp_no)
);