IF OBJECT_ID('dbo.dim_rider') IS NOT NULL
    DROP EXTERNAL TABLE dbo.dim_rider;

CREATE EXTERNAL TABLE dbo.dim_rider
WITH (
    LOCATION = 'starschema/dim_rider',
    DATA_SOURCE = [divvyprojectcontainer_divvprojectstorageacct_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
)

AS(
SELECT 
    r.rider_id,
    r.first,
    r.last,
    r.address,
    r.birthday,
    r.account_start_date,
    r.account_end_date,
    r.is_member

FROM dbo.staging_rider r
)
GO

SELECT TOP 10 * FROM dbo.dim_rider;
