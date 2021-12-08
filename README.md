# Pewlett-Hackard-Analysis

## Analysis Overview

The purpose of this analysis is to help Pewlett Hackard determine the number of employees who are eligible for retirement so Pewlett Hackard can determine what they need to do to be prepared for the high number of employees that may be leaving.  In this case, we are to determine the number of retirees by title so Pewlett Hackard knows the types of positions that will need to be filled.  In addition, we need to determine the number of employees eligible for the Mentorship Program, which is a proactive program to help prepare existing employees to fill the positions being vacated.

## Results

The results of this analysis are displayed in the two pictures below.

Number of Retirees by Title

![Retirees_by_Title](https://github.com/mshideler/Pewlett-Hackard-Analysis/blob/main/Analysis%20Projects%20Folder/Pewlett-Hackard-Analysis%20Folder/Data/retiring_titles_pic.png)

Partial List of Employees Eligible for the Mentorship Program

![Mentorship_Eligibility](https://github.com/mshideler/Pewlett-Hackard-Analysis/blob/main/Analysis%20Projects%20Folder/Pewlett-Hackard-Analysis%20Folder/Data/mentorship_eligibility_pic.png)

What These Results Tell Us

- The titles with the highest number of retirees are Senior Engineer and Senior Staff.
  
- Retirees who are either Senior Engineers or Senior Staff make up approximately 64% of the total number of retirees.

- The total count of retirees by title is 90,398 whereas the total count of employees eligible for the mentorship program equals 1,549.

- The total number of employees currently employed is 240,124.  Because there are 90,398 retirees, that means retirees make up approximately 38% of Pewlett Hackard’s workforce.

## Summary

Question 1. How many roles will need to be filled as the "silver tsunami" begins to make an impact?

If the roles are expected to stay the same, all 90,398 roles need to be filled so as to minimize the “silver tsunami” effect.  Again, the number of retirees makes up 38% of Pewlett Hackard’s workforce.  Otherwise, numerous, additional responsibilities will be assigned to the remaining employees, which will have a negative impact on the company as a whole.  If the roles change, perhaps fewer roles would need to be filled depending on how those roles change.

Here is the query used to determine the total number of current employees.

```
SELECT COUNT (e.emp_no), de.to_date
FROM employees AS e
INNER JOIN dept_emp AS de
ON e.emp_no = de.emp_no
WHERE de.to_date = '9999-01-01'
GROUP BY de.to_date;
```

Question 2. Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?

Refactoring the code for this exercise led us to determine that the percentage of retirees per department is 37% - 38%, which is more than is necessary for the mentorship program.  The rest of the retirees could be tasked with helping to find other ways to pass on their knowledge.

Here is the refactored code:

```
-- create table for current employees by department
SELECT COUNT (e.emp_no),
	de.dept_no,
	d.dept_name
INTO ms_currentees_dept
FROM employees AS e
INNER JOIN dept_emp AS de
ON e.emp_no = de.emp_no
INNER JOIN departments AS d
ON de.dept_no = d.dept_no
WHERE de.to_date = '9999-01-01'
GROUP BY de.dept_no, d.dept_name
ORDER BY COUNT (e.emp_no) DESC;
	
-- Get departments of employees born between 1952 and 1955
SELECT e.emp_no,
	de.dept_no,
	d.dept_name,
	de.from_date,
	de.to_date
INTO ms_retirees_dept
FROM employees AS e
INNER JOIN dept_emp AS de
ON (e.emp_no = de.emp_no)
INNER JOIN departments as d
ON (de.dept_no = d.dept_no)
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

-- Create a table with a list of unique employees and their most recent dept
SELECT DISTINCT ON (emp_no) emp_no,
	dept_no,
	dept_name
INTO ms_unique_depts
FROM ms_retirees_dept
ORDER BY emp_no, from_date DESC;

-- Create a table with the number of retiring employees by dept
SELECT COUNT (emp_no), dept_no, dept_name
-- INTO ms_retiring_depts
FROM ms_unique_depts
GROUP BY dept_no, dept_name
ORDER BY COUNT (emp_no) DESC;
```

