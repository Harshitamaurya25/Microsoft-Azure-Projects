IF OBJECT_ID('dbo.dim_date') IS NOT NULL
    DROP EXTERNAL TABLE dbo.dim_date;

CREATE EXTERNAL TABLE dbo.dim_date
WITH (
    LOCATION = 'starschema/dim_date',
    DATA_SOURCE = [divvyprojectcontainer_divvprojectstorageacct_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
)

AS
SELECT DISTINCT
    CONCAT(CONVERT(VARCHAR(50), trip_id), FORMAT(TRY_CONVERT(DATETIME, start_at), 'yyyyMMddHHmmss')) AS date_id,
    DATEPART(DAY, TRY_CONVERT(DATE, start_at)) AS DAYS,
    DATEPART(MONTH, TRY_CONVERT(DATE, start_at)) AS MONTH ,
    DATEPART(QUARTER, TRY_CONVERT(DATE, start_at)) AS QUARTER,
    DATEPART(YEAR, TRY_CONVERT(DATE, start_at)) AS YEAR
FROM dbo.staging_trip
WHERE TRY_CONVERT(DATE, start_at) IS NOT NULL

UNION

SELECT DISTINCT

    CONCAT(CONVERT(VARCHAR(50), trip_id), FORMAT(TRY_CONVERT(DATETIME, ended_at), 'yyyyMMddHHmmss')) AS date_id,
    
    DATEPART(DAY, TRY_CONVERT(DATE, ended_at)) AS DAYS,
    DATEPART(MONTH, TRY_CONVERT(DATE, ended_at)) AS MONTH ,
    DATEPART(QUARTER, TRY_CONVERT(DATE, ended_at)) AS QUARTER,
    DATEPART(YEAR, TRY_CONVERT(DATE, ended_at)) AS YEAR
FROM dbo.staging_trip
WHERE TRY_CONVERT(DATE, ended_at) IS NOT NULL

UNION

SELECT DISTINCT 
    CONCAT(CONVERT(VARCHAR(50), p.payment_id), FORMAT(TRY_CONVERT(DATETIME, p.date), 'yyyyMMddHHmmss')) AS date_id,
    DATEPART(DAY, TRY_CONVERT(DATE, p.date)) AS DAYS,
    DATEPART(MONTH, TRY_CONVERT(DATE, p.date)) AS MONTH ,
    DATEPART(QUARTER, TRY_CONVERT(DATE, p.date)) AS QUARTER,
    DATEPART(YEAR, TRY_CONVERT(DATE, p.date)) AS YEAR
FROM dbo.staging_payment p
WHERE TRY_CONVERT(DATE, p.date) IS NOT NULL;

GO

SELECT TOP 10 * FROM dbo.dim_date;
