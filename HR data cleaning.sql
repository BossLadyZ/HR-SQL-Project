CREATE DATABASE sqlprojects;

USE sqlprojects;

select * FROM hr;

/*rename ID column into something appropraite*/
ALTER table hr
CHANGE column ï»¿id emp_id VARCHAR(20) NULL; 

/*check datatypes of all columns*/

DESCRIBE hr;


/*change birthdate, hire_date to date datatypes*/

SELECT birthdate FROM hr;

SET sql_safe_updates = 0; 
/*different date formats observed, hyphens and dashes*/
UPDATE hr
SET birthdate = CASE
	WHEN birthdate LIKE'%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE'%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE null
END;
/*change data type of the birthdate column*/
ALTER TABLE hr
MODIFY COLUMN birthdate DATE;
/*Update format in hire_date column*/
UPDATE hr
SET hire_date = CASE
	WHEN hire_date LIKE'%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE'%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE null
END;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

SELECT hire_date FROM hr;

-- term date format update-- 
SELECT termdate FROM hr;
-- remove time from format and change format--
-- UPDATE hr
-- SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
-- WHERE termdate IS NOT NULL AND termdate != '';
UPDATE hr
SET termdate = IF(termdate IS NOT NULL AND termdate != '', date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')),'0000-00-00')
WHERE true;

SET sql_mode = 'ALLOW_INVALID_DATES';

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

-- adding age column to the dataset -- 
ALTER TABLE hr ADD COLUMN age INT;

-- calculate age --
UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());

SELECT birthdate, age FROM hr;

-- check minimum and maximum age -- 
SELECT 
	MIN(age) AS youngest,
    MAX(age) as Oldest
FROM hr;

-- check how many ages are less than 18 --
SELECT age FROM hr;

