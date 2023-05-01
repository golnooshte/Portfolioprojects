Select Location, date, total_cases, new_cases, total_deaths, population
From portfolio..CovidDeaths
Where continent is not null 
order by 1,2

-------------------
-----Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country

Select Location, date, total_cases,total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
From portfolio..CovidDeaths
Where location like '%states%'
and continent is not null 
order by 1,2
---------------
-- Total Cases vs Population
-- Shows what percentage of population infected with Covid

Select Location, date, Population, total_cases,  (total_cases/population)*100 as PercentPopulationInfected
From portfolio..CovidDeaths
order by 1,2
------------

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From portfolio..CovidDeaths
--Where location like '%states%'
Group by Location, Population
order by PercentPopulationInfected desc


-- showing countries with highest death count per population 
Select Location, Population, MAX(total_deaths) as TotalDeathCount,
Max((total_deaths/population))*100 as PercentPopulationDeath
From portfolio..CovidDeaths
WHERE continent is not null
Group by Location, Population
order by  TotalDeathCount desc;

-----showing the  highest death count per continent

Select continent, MAX(total_deaths) as TotalDeathCount
From portfolio..CovidDeaths
WHERE continent is not null
Group by [continent]
order by  TotalDeathCount desc;
--- showing the continent with highest death count per population 
Select continent , MAX(total_deaths) as TotalDeathCount,
 Max(total_deaths/population)*100 as TotalDeathPercentagePerPopulation
From portfolio..CovidDeaths
WHERE continent is not null
Group by [continent]
order by TotalDeathPercentagePerPopulation desc;

-----Global 
Select date,sum(new_cases) as total_cases,sum(new_deaths) as total_deaths,
Cast(sum(new_deaths) as float)/sum(new_cases)*100 as DeathPercentage
From portfolio..CovidDeaths
WHERE continent is not null
Group by date
order by date; 
------ total deaths and cases in the whole world
Select sum(new_cases) as total_cases,sum(new_deaths) as total_deaths,
Cast(sum(new_deaths) as float)/sum(new_cases)*100 as DeathPercentage
From portfolio..CovidDeaths
WHERE continent is not null; 
------ looking at total population vs vaccination 


With PopVsVac(continent,location,date,population,new_vaccinations,RollingPeopleVaccinated)
as
(select dea.continent,dea.location,dea.date,dea.population,
vac.new_vaccinations,
sum(cast(vac.total_vaccinations as bigint))
 OVER(Partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
 from portfolio..CovidDeaths dea
 JOIN portfolio..CovidVaccinations vac
 on dea.[location]=vac.[location]
 and dea.date=vac.date
 where dea.continent is not null 
)
 Select * , (RollingPeopleVaccinated / population)*100 from PopVsVac;
 -----temp table 
 Drop TABLE if EXISTS #PercentPopulationVaccinated
 CREATE table #PercentPopulationVaccinated
 ( continent NVARCHAR(255),
 location NVARCHAR(255),
 Date DATETIME,
 population NUMERIC,
 new_vaccinations NUMERIC,
 RollingPeopleVaccinated NUMERIC
 )
 INSERT into #PercentPopulationVaccinated
 
select dea.continent,dea.location,dea.date,dea.population,
vac.new_vaccinations,
sum(cast(vac.total_vaccinations as bigint))
 OVER(Partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
 from portfolio..CovidDeaths dea
 JOIN portfolio..CovidVaccinations vac
 on dea.[location]=vac.[location]
 and dea.date=vac.date
 -------
 Select *, (RollingPeopleVaccinated/population)*100  from #PercentPopulationVaccinated;
 ---Crating a view to store data for later visualization 
CREATE VIEW PercentPopulationVaccinated as
 Select dea.continent,dea.location,dea.date,dea.population,
vac.new_vaccinations,
sum(cast(vac.total_vaccinations as bigint))
 OVER(Partition by dea.location order by dea.location,dea.date) as RollingPeopleVaccinated
 from portfolio..CovidDeaths dea
 JOIN portfolio..CovidVaccinations vac
 on dea.[location]=vac.[location]
 and dea.date=vac.date
 where dea.continent is not null ;
 
---------------------------------------------
 Select * from PercentPopulationVaccinated;