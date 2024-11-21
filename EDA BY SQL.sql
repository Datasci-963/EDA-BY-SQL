----- EXPLORATORY DATA ANALYSIS

SELECT * FROM layoffs_staging2;


SELECT * FROM layoffs_staging2;

SELECT max(total_laid_off),max(percentage_laid_off)
from layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE  percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;


select company, sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;


select  min(date),max(date)
from layoffs_staging2;

select industry ,sum(total_laid_off)
from layoffs_staging2
group by industry
order by 2 desc;

select company ,sum(total_laid_off)
from layoffs_staging2
group by company
order by 2 desc;

select date ,sum(total_laid_off)
from layoffs_staging2
group by date
order by 2 desc;

select stage ,sum(total_laid_off)
from layoffs_staging2
group by stage
order by 2 desc;

select substring(date,1,7) as month ,sum(total_laid_off)
from layoffs_staging2
where substring(date,1,7) is not null
group by month
order by 1 asc; 

with rolling_total as
(
select substring(date,1,7) as month ,sum(total_laid_off) as total_off
from layoffs_staging2
where substring(date,1,7) is not null
group by month
order by 1 asc
)
select month,total_off,
sum(total_off) over(order by month) as rolling_total
from rolling_total;

select company,year(date) ,sum(total_laid_off)
from layoffs_staging2
group by company,year(date)
order by 3 asc;

with company_year (company ,years,total_laid_off) as
(
select company,year(date),sum(total_laid_off)
from layoffs_staging2
group by company ,year(date)
)
select*,dense_rank()over(partition by years order by total_laid_off desc) as ranking
from company_year
where years is not null
order by ranking asc;








