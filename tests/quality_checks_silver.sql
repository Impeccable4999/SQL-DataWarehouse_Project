USE Datawarehouse
SELECT 
prd_id,
COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL


SELECT 
prd_key
FROM silver.crm_prd_info
WHERE prd_key != TRIM(prd_key)


SELECT 
DISTINCT prd_line
FROM silver.crm_prd_info

SELECT 
DISTINCT cst_gndr
FROM silver.crm_cust_info

SELECT prd_nm
FROM bronze.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)


SELECT 
*
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt

SELECT *
 FROM silver.crm_prd_info


USE Datawarehouse
IF OBJECT_ID ('silver.crm_prd_info', 'U') IS NOT NULL
	DROP TABLE silver.crm_prd_info;
CREATE TABLE [silver].[crm_prd_info](
	prd_id INT ,
	cat_id NVARCHAR(50),
	prd_key nvarchar(50) ,
	prd_nm nvarchar(50) ,
	prd_cost int ,
	prd_line nvarchar(50) ,
	prd_start_dt date ,
	prd_end_dt date ,
	dwh_create_date datetime2 default GETDATE()
	);

INSERT INTO silver.crm_prd_info
(
prd_id,
cat_id,
prd_key,
prd_nm,
prd_cost,
prd_line,
prd_start_dt,
prd_end_dt
)

SELECT
prd_id,
REPLACE(SUBSTRING(prd_key,1,5), '-', '_') AS cat_id,
SUBSTRING(prd_key,7,LEN(prd_key)) AS prd_key,
prd_nm,
ISNULL(prd_cost, 0) AS prd_cost,
CASE UPPER(TRIM(prd_line))
	WHEN 'R' THEN 'Road'
	WHEN 'S' THEN 'Other Sales'
	WHEN 'M' THEN 'Mountain'
	WHEN 'T' THEN 'Touring'
	ELSE 'n/a'
END AS prd_line,
CAST(prd_start_dt AS DATE) AS prd_start_dt,
CAST(LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt ASC) - 1 AS DATE) AS prd_end_dt
FROM bronze.crm_prd_info

SELECT DISTINCT 
bdate
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01' OR bdate > GETDATE()


SELECT DISTINCT gen FROM silver.erp_cust_az12
