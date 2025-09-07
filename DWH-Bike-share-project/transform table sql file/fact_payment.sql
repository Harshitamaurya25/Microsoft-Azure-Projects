IF OBJECT_ID('dbo.fact_payment') IS NOT NULL
    DROP EXTERNAL TABLE dbo.fact_payment;

CREATE EXTERNAL TABLE dbo.fact_payment
WITH (
    LOCATION = 'starschema/fact_payment',
    DATA_SOURCE = [divvyprojectcontainer_divvprojectstorageacct_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
)

AS(
    
SELECT 
    p.payment_id,
    p.rider_id,
    p.amount,
    p.date_id
FROM dbo.staging_payment p
)
GO

SELECT TOP 10 * FROM dbo.fact_payment;
