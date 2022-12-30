select *
from coviddeaths
where continent!=""
order by 3,4;
   
select *
from covidvacinations
where continent!=""
order by 3,4; 

select location, date , total_cases, new_cases, total_deaths, population
from coviddeaths
where continent!=""
order by 1,2;

-- Shows the likelyhood of dying if contracted covid in Cameroon
select 	location, date,total_cases, total_deaths, (total_deaths/total_cases) * 100 as DeathPercentage
from coviddeaths
-- where location="Cameroon"
where continent!=""
order by 2;

-- Shows what percentage of population that get covid
select location, date, total_cases, population, (total_cases/population) * 100  as DeathPercentage
from coviddeaths
-- where location="Cameroon"
where continent!=""
order by 1,2;

-- Showing the highest cases per country
select continent, location, population, max(total_cases) as HighestInfectionCount
, max((total_cases/population)*100) as PercentPopulationInfected
from coviddeaths
where continent!=""
group by location, population
order by PercentPopulationInfected desc; 

-- Showing the highest deaths per country
select continent, location, population, max(convert(total_deaths, float)) as HighestDeathCount
from coviddeaths
where continent!=""
group by location
order by HighestDeathCount desc;

-- Showing the highest death count per countinent
select continent, max(cast(total_deaths as float)) as HighestDeathCount
from coviddeaths
where continent!=""
Group by continent
order by HighestDeathCount desc;

-- Total Death Percentage per country
select location, max(population) as population, sum(new_cases) as total_cases, sum(new_deaths) as total_deaths, (sum(new_deaths)/sum(new_cases)) * 100 as DeathPercentage
from coviddeaths
-- where location="Cameroon"
where continent!=""
group by location 
order by 1;

-- Total Death Percentage per continent
select continent, max(population) as population, sum(new_cases) as total_cases, sum(new_deaths) as total_deaths, (sum(new_deaths)/sum(new_cases)) * 100 as DeathPercentage
from coviddeaths
-- where location="Cameroon"
where continent!=""
group by continent 
order by 1;

select location, max(population) as population, sum(new_cases) as total_cases, sum(new_deaths) as total_deaths, (sum(new_deaths)/sum(new_cases)) * 100 as DeathPercentage
from coviddeaths
-- where location="Cameroon"
where continent!=""
group by location 
order by 1;

select  max(population) as population, sum(new_cases) as total_cases, sum(new_deaths) as total_deaths, (sum(new_deaths)/sum(new_cases)) * 100 as DeathPercentage
from coviddeaths
-- where location="Cameroon"
where continent!=""
-- group by date 
order by 1;


-- CTE
with deavsvac (continent, location, date, population, new_vaccinations, cum_vaccinations)
as
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(vac.new_vaccinations) over (partition by dea.location order by dea.location, dea.date) as cum_vaccinations
from portfolioproject.coviddeaths dea
join covidvacinations vac
	on dea.location = vac.location
    and dea.date = vac.date
where dea.continent!="")
select *, (cum_vaccinations/population) * 100 as percentage_cum_vaccination
from deavsvac;

-- Creating view to store data for later visualizations
create view PercentagePopupercentagepopulationvaccinatedlationVaccinated as
(select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(vac.new_vaccinations) over (partition by dea.location order by dea.location, dea.date) as cum_vaccinations
from portfolioproject.coviddeaths dea
join covidvacinations vac
	on dea.location = vac.location
    and dea.date = vac.date
where dea.continent!="");


select * from percentagepopulationvaccinated;