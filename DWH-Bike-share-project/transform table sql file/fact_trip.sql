IF OBJECT_ID('dbo.fact_trip') IS NOT NULL
    DROP EXTERNAL TABLE dbo.fact_trip;

CREATE EXTERNAL TABLE dbo.fact_trip
WITH (
    LOCATION = 'starschema/fact_trip',
    DATA_SOURCE = [divvyprojectcontainer_divvprojectstorageacct_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
)
AS(
SELECT 
    t.trip_id,
    t.rider_id,
    t.start_station_id,
    t.end_station_id,
    DATEDIFF(
        MINUTE, 
        TRY_CAST(t.start_at AS DATETIME2), 
        TRY_CAST(t.ended_at AS DATETIME2)
    ) as [duration_minutes],
    DATEDIFF(
        YEAR, 
        TRY_CAST(r.birthday AS DATETIME2), 
        TRY_CAST(t.start_at AS DATETIME2)
    ) as [rider_age_at_ridetime],
    FORMAT(TRY_CAST(t.start_at AS DATETIME2), 'yyyyMMddHHmmss') AS [start_date_id],
    FORMAT(TRY_CAST(t.ended_at AS DATETIME2), 'yyyyMMddHHmmss') AS [end_date_id]

FROM dbo.staging_trip t

LEFT JOIN dbo.staging_rider r
    ON t.rider_id = r.rider_id
    );


SELECT TOP 10 * FROM dbo.fact_trip;
