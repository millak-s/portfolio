-- Shows the table coviddeaths excluding rows with an empty string as column
select * from coviddeaths
where continent != ""
order by 3,4;


-- Shows the likelyhood of dying when infected with the virus every per country
select continent, location, date, population, total_cases, total_deaths
,(total_cases/population) * 100  as pct_population_infected
,(total_deaths/total_cases)*100 as pct_infected_population_dead
from coviddeaths
where continent != ""
group by location, date
order by 2,3;


-- Shows the likelyhood of contracting the virus and the likelyhood of dying if infected when the infected and death numbers were
-- at its highest in every country
-- CTE
with max_numbers (continent, location, population, highest_infected_count, highest_death_count)
as
(select continent, location, max(population) as population
, max(cast(total_cases as float)) as highest_infection_count
,max(convert(total_deaths, float)) as highest_death_count
from coviddeaths
where continent != ""
group by location)
select *, round((highest_infected_count/population) * 100, 3)  as pct_population_infected
,round((highest_death_count/highest_infected_count)*100, 3) as pct_infected_dead
from max_numbers
order by highest_infected_count desc;

-- Breaking up by continent
with max_numbers (continent, population, highest_infected_count, highest_death_count)
as
(select continent, max(population) as population
, max(cast(total_cases as float)) as highest_infection_count
,max(convert(total_deaths, float)) as highest_death_count
from coviddeaths
where continent != ""
group by continent)
select *, round((highest_infected_count/population) * 100, 3)  as pct_population_infected
,round((highest_death_count/highest_infected_count)*100, 3) as pct_infected_dead
from max_numbers
order by highest_infected_count desc;


