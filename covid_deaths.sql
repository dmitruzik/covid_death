-- SELECT * FROM CovidDeaths;
-- Where continent is not null
-- ORDER by 3, 4

-- Looking at total cases vs total deaths
SELECT Location, date, total_cases, total_deaths, (CAST(total_deaths AS FLOAT) / CAST(total_cases AS FLOAT)) * 100 AS DeathPercentage
From CovidDeaths
order by 1, 2

-- Looking total cases vs population
-- show what percentage of population get covid

SELECT Location, date, total_cases, population,  (CAST(total_cases AS FLOAT) / CAST(population AS FLOAT)) * 100 AS PercentPopulationInfected
From CovidDeaths
Where continent is not null
order by 1, 2

-- Looking at countries with highest infection rates

SELECT Location, population, Max(total_cases) as HighestInfectionCount, Max((CAST(total_cases AS FLOAT) / CAST(population AS FLOAT))) * 100 as PercentPopulationInfected
From CovidDeaths
Where continent is not null
Group by location, population 
order by PercentPopulationInfected desc

-- Show countries with highest death count population

SELECT Location, MAX(CAST(total_deaths as FLOAT)) as TotalDeathCount
From CovidDeaths
Where continent is not null
Group by location
order by TotalDeathCount desc

-- Showing continents with the highest death rate

SELECT continent, MAX(CAST(total_deaths as FLOAT)) as TotalDeathCount
From CovidDeaths
Where continent  is not null
Group by continent
order by TotalDeathCount desc

-- GLOBAL NUMBERS

SELECT SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/
SUM(new_cases)*100 as DeathPercantage
From CovidDeaths
Where continent  is not null
-- Group by date
order by 1, 2

-- JOIN two Tables

SELECT * FROM CovidDeaths cd 
Join CovidVaccinations cv 
	On cd.location = cv.location 
	and cd.date = cv.date 
	
	
	-- Temp Table

-- Looking at total population vs vaccination

SELECT cd.continent, cd.location, cd.population, cv.new_vaccinations
, SUM(CAST(cv.new_vaccinations as int)) OVER (Partition by cd.location Order by cd.location, cd.date)
as RollingPeopleVaccinated
FROM CovidDeaths cd 
Join CovidVaccinations cv 
	On cd.location = cv.location 
	and cd.date = cv.date 
Where cd.continent is not null
order by 2, 3







