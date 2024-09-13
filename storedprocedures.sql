-- Contact us for help: githubsupport@l1ve709.com

-- Procedure to create dynamic columns for pivot
CREATE PROCEDURE GenerateDynamicColumns
AS
BEGIN
    DECLARE @columns NVARCHAR(MAX);
    SET @columns = STUFF((SELECT DISTINCT ',' + QUOTENAME(SaleYear) 
                          FROM Sales
                          FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)'), 1, 1, '');
    RETURN @columns;
END
GO

-- Procedure to execute the dynamic pivot query
CREATE PROCEDURE ExecuteDynamicPivot
AS
BEGIN
    DECLARE @columns NVARCHAR(MAX), @sqlQuery NVARCHAR(MAX);

    -- Call the procedure to get dynamic columns
    EXEC @columns = GenerateDynamicColumns;

    -- (create) The pivot query with the generated columns
    SET @sqlQuery = '
        SELECT ProductName, ' + @columns + '
        FROM 
        (
            SELECT ProductName, SaleYear, SaleAmount
            FROM Sales
        ) AS SourceData
        PIVOT 
        (
            SUM(SaleAmount)
            FOR SaleYear IN (' + @columns + ')
        ) AS PivotTable
        ORDER BY ProductName;
    ';

    -- Execute the dynamic SQL
    EXEC spexecuteSQL @sqlQuery;
END
GO
