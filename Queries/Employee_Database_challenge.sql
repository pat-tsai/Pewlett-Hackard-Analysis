
-- Finding retirees from each department
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees as e
INNER JOIN titles as t
	ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no ASC;


-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (r.emp_no) r.emp_no,
	r.first_name,
	r.last_name,
	r.title
INTO unique_titles
FROM retirement as r
ORDER BY r.emp_no ASC, r.to_date DESC;


-- Retries number of employees about to retire
SELECT COUNT (DISTINCT t.emp_no), t.title
INTO retiring_titles
FROM unique_retirement AS t
GROUP BY t.title
ORDER BY COUNT (t.title) DESC;


-- Selecting current employees eligible for mentorship program
SELECT DISTINCT ON (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	d.from_date,
	d.to_date,
	t.title
INTO mentorship_eligibility
FROM employees as e
LEFT JOIN dept_emp as d
	ON e.emp_no = d.emp_no
LEFT JOIN titles as t
	ON e.emp_no = t.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
	AND d.to_date = '9999-01-01'
ORDER BY e.emp_no ASC;
