DROP TABLE departments;
CREATE TABLE departments (
	dept_no VARCHAR(25) NOT NULL PRIMARY KEY, 
	dept_name VARCHAR(50) NOT NULL,
	last_updated TIMESTAMP
); 

DROP TABLE dept_emp;
CREATE TABLE dept_emp (
	emp_no INT NOT NULL PRIMARY KEY, 
	dept_no VARCHAR(25) NOT NULL,
	last_updated TIMESTAMP
); 

DROP TABLE dept_manager;
CREATE TABLE dept_manager (
	dept_no VARCHAR(25) NOT NULL, 
	emp_no INT NOT NULL PRIMARY KEY,
	last_updated TIMESTAMP
); 

DROP TABLE employees;
CREATE TABLE employees (
	emp_no INT NOT NULL PRIMARY KEY, 
	emp_title_id VARCHAR(25) NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR (50) NOT NULL,
	last_name VARCHAR (50) NOT NULL,
	sex VARCHAR (10) NOT NULL,
	hire_date DATE NOT NULL,
	last_updated TIMESTAMP
); 

DROP TABLE salaries;
CREATE TABLE salaries (
	emp_no INT NOT NULL PRIMARY KEY, 
	salary INT NOT NULL,
	last_updated TIMESTAMP
); 

DROP TABLE titles;
CREATE TABLE titles (
	title_id VARCHAR(25) NOT NULL PRIMARY KEY, 
	title VARCHAR(100) NOT NULL,
	last_updated TIMESTAMP
); 


-- 1. List the employee number, last name, first name, sex, and salary of each employee.

SELECT 
	e.emp_no, 
	e.last_name, 
	e.first_name, 
	e.sex, 
	s.salary
FROM 
	employees e
JOIN salaries s ON e.emp_no = s.emp_no;

-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.

SELECT
	first_name, 
	last_name, 
	hire_date
FROM 
	employees
WHERE hire_date BETWEEN '01/01/1986' AND NOW()
ORDER BY 
	hire_date ASC,
	last_name ASC;


-- 3. List the manager of each department along with their department number, department name, 
      -- employee number, last name, and first name.

SELECT 
	d.dept_name,
	d.dept_no,
	e.emp_no,
	t.title,
	e.last_name,
	e.first_name
FROM
	dept_manager m
JOIN employees e ON m.emp_no = e.emp_no
JOIN departments d ON m.dept_no = d.dept_no
JOIN titles t ON e.emp_title_id = title_id;

-- 4. List the department number for each employee along with that employee’s 
   -- employee number, last name, first name, and department name.

SELECT 
	e.emp_no,
	e.last_name,
	e.first_name,
	d.dept_name,
	d.dept_no
FROM
	employees e
JOIN dept_emp de ON de.emp_no = e.emp_no
JOIN departments d ON de.dept_no = d.dept_no
ORDER BY 
	dept_name ASC, 
	last_name ASC;

-- 5. List first name, last name, and sex of each employee whose first name is Hercules 
   -- and whose last name begins with the letter B.

SELECT 
	last_name, 
	first_name,
	sex
FROM employees
WHERE
	first_name = 'Hercules'
	AND last_name LIKE 'B%';

-- 6. List each employee in the Sales department, including their employee number, 
   -- last name, and first name.

SELECT 
	d.dept_name,
	e.last_name,
	e.first_name,
	e.emp_no
FROM
	employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE dept_name = 'Sales';

-- 7. List each employee in the Sales and Development departments, including 
   -- their employee number, last name, first name, and department name.

SELECT 
	d.dept_name,
	e.last_name,
	e.first_name,
	e.emp_no
FROM
	employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE 
	dept_name = 'Sales'
	OR dept_name = 'Development'; 
	
-- 8. List the frequency counts, in descending order, of all the employee last 
   -- names (that is, how many employees share each last name).

SELECT
	last_name,
	COUNT(*) AS "Name_Frequency"
FROM employees
GROUP BY
	last_name;


