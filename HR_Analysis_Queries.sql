select * from hr;
-- Data Cleaning 

-- Change Id column name 
alter table hr
change column ï»¿id emp_id varchar(20) NULL;

desc hr;
set sql_safe_updates=0;



-- Change birthdate format
update hr
SET birthdate = CASE 
WHEN birthdate like '%/%' then date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
WHEN birthdate like '%-%' then date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
else NULL
end;

-- convert data type to date 
alter table hr 
modify column birthdate date;

select * from hr;

-- Change hiredate format 
update hr
SET hire_date = CASE 
WHEN hire_date like '%/%' then date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
WHEN hire_date like '%-%' then date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
else NULL
end;

-- hiredate data type change 
alter table hr 
MODIFY column termdate date;

-- termdate standardize the records
update hr 
set termdate = if(termdate is not null or termdate!='',date(str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC')),'0000-00-00')
where true;


select termdate from hr;

-- termdate data type change 
alter table hr 
modify column termdate date;


SET sql_mode='ALLOW_INVALID_DATES';
select termdate from hr where termdate='';

-- Data processing 


-- Add age column to table 
ALTER TABLE hr ADD COLUMN age INT;


-- Age Calculation
UPDATE hr
set age = timestampdiff(YEAR,birthdate,curdate());


select birthdate,age from hr;

select age from hr where age<0 
union 
select max(age) from hr;
