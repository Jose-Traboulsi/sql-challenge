# sql-challenge

Screenshot contains table schemata, which outlines the relationships between the various datasets
ID columns are the primary keys generally (emp_id, title_id, etc.) given these are unique values by nature.
In the code, the order of table creation matters, since we need to create the fields that will become foreign keys in subsequent tables first so that these are picked up.
For instance, we create the Title table first since emlployees takes title_id as it's foreign key. We then create the Employees table so that tables taking emp_id field can be created (i.e., Salaries, Department Manager...).
In the In the case of deparment employees and department manager tables, we needed to create a combined primary key. This is because a single employees can be assigned to more than one department per the data.
So, to make unique identifiers, we combine employee ids with department ids. Note that, at the same time, these ids are foreign keys too, since they belong to the employees and departments table.
I added a UNIQUE constraint to the department name column since no department within the company should have a duplicated name.
The column values for birth_date and hire_date are expressed as text for now. I will explain why below.
Some people may not want to report their sex or date of birth, so I did not include the NOT NULL condition on these columns when creating the tables. In fact, if we do, DOB will not work.

Temporary table for Employees
I was getting an error when uploading data into the Employees table since the date format for the birth_date field was not being processed. 
Using help from my colleagues and online forums, I determined that one way to get around this is to "inserting" values from a temporary table into the actual Employees table, and in the process, converting
the birth_date and hire_date values into dates. This is why the date column values where first expressed as text and not date forms originally.
This bypasses the error being received when uploading the csv data. I discussed this with a tutor, and he mentioned this has to do with some updates that pgAdmin may have released recently.


DATA ANALYSIS

1. List the employee number, last name, first name, sex, and salary of each employee.
To get this done, we need to conduct an inner join between the Employees and the Salaries table, since the Salaries table contains this information.
We do this by tying the employee number columns on each table. Employee number is a foreign key in the Slaries table used to link it to the Employees table.
We can use an inner join since the employee ids/numbers are the same in both tables.

2. List the first name, last name, and hire date for the employees who were hired in 1986.
We can get this information from the Employees table itself by filtering records to ensure hire_date column only shows rows where the year in the date equals 1986.
To do this, we include a WHERE line in the code and specify hire_date BETWEEN Jan 1 and Dec 31 of 1986.

3. List the manager of each department along with their department number, department name, employee number, last name, and first name.
We do this by using two inner joins. We need two since the Employees table and the Departments table are not interconnected, but we can use the Department Managers table to connect both.
As such, we can join Employees to Department Managers via the emp_no, and then join to the Departments table dept_no. 
We can also do this by linking Deparments and Department Manager via dept_no, and then to Employees using emp_no in Deparment Managers.

4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
The logic here is the same as above, but we must now use the Department Employees table to combine Employees with it via emp_no and then with Departments to get the dept_name column.

5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
No need to make Joins here since all of the requested information can be found in the Employees table. The trick here is to use the function LEFT() to extract the first letter of the last name and make this a filter.
LEFT (last_name, 1) = 'B' takes each row of data in the last_name column and returns the first character (position 1) of the text when = B. We add this to the filter condition to look for first_name = 'Hercules'.

6. List each employee in the Sales department, including their employee number, last name, and first name.
For this one, we need to join the Employees table with the Deparment Employees one via the emp_no, and then with Departments via dept_no to obtain the department names.
We add a filter to dept_no so that only rows with dept_no=d007 (the code for the Sales department per the Departments table) are shown.

7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
The process is simular to the last question, but the key difference is adding an OR argument to the WHERE filter to include employees in the Development (d007) department as well.

8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
We can get all of this information from the Employees table and use aggregation (COUNT) and group by to obtain the count of how many employees have a certain last name .
In other words, how many times a certain last name appears in the last_name column of the Employee dataset.
We format in descending order by indicating ORDER BY DESC at the end of the code.
