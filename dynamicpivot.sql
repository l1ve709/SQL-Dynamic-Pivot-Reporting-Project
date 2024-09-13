-- Contact us for help: githubsupport@l1ve709.com

-- Declare variables for dynamic SQL
DECLARE @columns AS NVARCHAR(MAX), @sqlQuery AS NVARCHAR(MAX);

-- Generate dynamic columns based on the distinct SaleYear values
SET @columns = STUFF((SELECT DISTINCT ',' + QUOTENAME(SaleYear) 
                      FROM Sales
                      FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 1, '');

-- Create the dynamic SQL query for pivoting the data
SET @sqlQuery = '
    SELECT ProductName, ' + @columns + '
    FROM 
    (
        SELECT ProductName, SaleYear, SaleAmount
        FROM Sales
    ) AS SourceData
    PIVOT 
    (
        SUM(SaleAmount)            -- Aggregate function to sum the sales amount
        FOR SaleYear IN (' + @columns + ')  -- Pivot based on dynamically generated years
    ) AS PivotTable
    ORDER BY ProductName;
';

-- Execute the dynamic SQL query
EXEC spexecuteSQL @sqlQuery;
