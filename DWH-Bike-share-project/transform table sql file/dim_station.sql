IF OBJECT_ID('dbo.dim_station') IS NOT NULL
    DROP EXTERNAL TABLE dbo.dim_station;

CREATE EXTERNAL TABLE dbo.dim_station
WITH (
    LOCATION = 'starschema/dim_station',
    DATA_SOURCE = [divvyprojectcontainer_divvprojectstorageacct_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
)

AS(
SELECT 
    s.station_id,
    s.name as station_name,
    s.latitude,
    s.longitude

FROM dbo.staging_station s
)
GO

SELECT TOP 10 * FROM dbo.dim_station;
