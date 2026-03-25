-- *DATA CLEANING 


-- CREATING A NEW TABLE LAYOFF_STAGING 

select * 
from layoffs;
create table layoff_staging 
like layoffs;

-- INSERTING VALUES
 
insert layoff_staging
select * from layoffs;


-- REMOVING DUPLICATES 

WITH duplicate_cte as(
select * ,
ROW_NUMBER() OVER(
PARTITION BY company, location,industry, total_laid_off, percentage_laid_off , 
'date', stage , country , funds_raised_millions) as row_num
from layoff_staging )
select * 
from duplicate_cte
where row_num>1;

select * 
from layoff_staging
where company = 'Better.com';


-- CREATING A NEW TABLE LAYOFF_STAGING2

CREATE TABLE `layoff_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select * 
from layoff_staging2;


-- INSERTING THE VALUES AND REMOVING DUPLICATES 
insert layoff_staging2
select * ,
ROW_NUMBER() OVER(
PARTITION BY company, location,industry, total_laid_off, percentage_laid_off , 
'date', stage , country , funds_raised_millions) as row_num
from layoff_staging ;

DELETE 
from layoff_staging2
where row_num>1;


select * 
from layoff_staging2;



-- *STANDARDISATION 


-- REMOVING EXTRA SPACES 
SELECT company, trim(company)
from layoff_staging2;

update layoff_staging2
set company = trim(company);


-- CHANGING THE DUPLICATED VALUES 

select distinct industry 
from layoff_staging2
order by 1;

select *
from layoff_staging2
where industry like 'crypto%';

update layoff_staging2
set industry = 'crypto'
where industry = 'crypto%';

select distinct location
from layoff_staging2
order by 1;

-- TRAILING 

select distinct country 
from layoff_staging2
order by 1;

update layoff_staging2
set country = trim(trailing '.' from country )
where country like 'United states%';

select * 
from layoff_staging2;

-- CONVERTING TEXT TO DATE 
select `date`,
str_to_date (`date` , '%m/%d/%Y') 
from layoff_staging2;

update layoff_staging2
set `date` = str_to_date (`date` , '%m/%d/%Y') ;

alter table layoff_staging2
modify `date` date ;

select * 
from layoff_staging2;



-- 8FILLING UP NULL VALUES 

select * 
from layoff_staging2
where industry is null 
or industry = '';

update layoff_staging2
set industry = null 
where industry = '';


select t1.industry , t2.industry 
from layoff_staging2 t1 
join layoff_staging2 t2 
	on t1.company = t2.company 
    where (t1.industry is null or t1.industry = '')
	and t2.industry is not null ;
    
update layoff_staging2 t1 
join layoff_staging2 t2 
	on t1.company = t2.company 
set t1.industry = t2.industry 
where (t1.industry is null or t1.industry = '')
	and t2.industry is not null ;

select * 
from layoff_staging2
where company = 'Airbnb';


select * 
from layoff_staging2
where total_laid_off is null 
and percentage_laid_off is null ;

alter table layoff_staging2
drop column row_num;

delete
from layoff_staging2
where total_laid_off is null 
and percentage_laid_off is null ;


select * from layoff_staging2;

