# CovidProject

The provided SQL script involves multiple queries and actions related to analyzing COVID-19 data from the `CovidDeaths$` and `CovidVaccinations$` tables within the `Covid_Project` database. Here's a short description of the work done in each section:

1.Filter and Sort Data:
   - The initial query retrieves data from the `CovidDeaths$` table where the continent is not null, and it's ordered by the third and fourth columns.

2. Data Selection for Analysis:
   - Data with specific columns (`location`, `date`, `total_cases`, `new_cases`, `total_deaths`, `population`) is selected from the `CovidDeaths$` table, filtered by a non-null continent, and ordered by location and date.

3. Total Cases vs Total Deaths:
   - A query is used to compare the total cases and total deaths in Yemen. It calculates the death percentage as a ratio of total deaths to total cases.

4. Total Cases vs Population:
   - Another query calculates the infection rate by dividing total cases by population for each location and date.

5. Countries with Highest Infection Rate:
   - This query identifies countries with the highest infection rates compared to their population by grouping and calculating the infection rate.

6. Countries with Highest Death Count per Population:
   - The query finds countries with the highest death counts per population by grouping and calculating maximum death counts.

7. Continent vs Total Deaths:
   - This query calculates the total deaths for each continent and excludes certain locations. The data is grouped by location and ordered by total deaths in descending order.

8. Global Numbers:
   - A query provides global COVID-19 statistics such as total cases, total deaths, and death percentage for each date. Data is grouped by date and ordered accordingly.

9. Joining Tables:
   - This query performs an inner join between the `CovidDeaths$` and `CovidVaccinations$` tables on `location` and `date`.

10. Total Population vs Vaccinations:
    - A query retrieves information about continent, location, date, population, and new vaccinations from the joined tables, filtered by a non-null continent.

11. Rolling Count:
    - This query calculates a rolling sum of new vaccinations over time for different locations and continents, also showing the rolling count of people vaccinated.

12. Common Table Expression (CTE) Usage:
    - A CTE named `PopvsVac` is used to store the result of a complex query involving the rolling count of vaccinations and related population data.

13. CTE Query with Additional Calculations:
    - The CTE result is selected, and additional calculations, including the vaccination percentage, are performed.

14. Temporary Table Creation:
    - A temporary table named `#PercentPopulationVaccinated` is created to store the same data as the previous CTE.

15. Insert Data into Temporary Table:
    - Data from the CTE query is inserted into the temporary table.

16. Querying Temporary Table with Calculations:
    - Data from the temporary table is selected, and similar calculations to the CTE query are applied.

17. Creating a View for Visualization:
    - A view named `PercentPopulationVaccinatedView` is created, encapsulating the CTE logic for easier data retrieval.

The script involves various analytical queries, including comparisons of COVID-19 data, calculations of percentages and rates, joining tables, using CTEs and temporary tables, and creating a view for visualization purposes. The focus is on analyzing infection rates, vaccination rates, and other COVID-19-related statistics.