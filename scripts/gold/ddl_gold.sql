IF OBJECT_ID ('gold.dim_customers','U') IS NOT NULL
  THEN DROP VIEW gold.dim_customers
GO
  
CREATE VIEW gold.dim_customers AS
SELECT 
ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key,
cst_id AS customer_id,
cst_key AS customer_number,
cst_firstname AS first_name,
cst_lastname last_name,
la.ccountry AS country,
cst_material_status AS marital_status,
CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr
	ELSE COALESCE(ca.gen, 'n/a')
END AS gender,
ca.bdate AS birthdate,
cts_create_date AS create_date
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca
ON ci.cst_key = ca.cid 
LEFT JOIN silver.erp_loc_a101 la
ON ci.cst_key = la.cid
GO


IF OBJECT_ID ('gold.dim_products','U') IS NOT NULL
  THEN DROP VIEW gold.dim_products
GO
CREATE VIEW gold.dim_products AS
SELECT
ROW_NUMBER() OVER (ORDER BY prd_start_dt, prd_key) AS product_key,
pn.[prd_id] AS product_id,
pn.[prd_key] AS product_number,
pn.[prd_nm] AS product_name,
pn.[cat_id] AS category_id,
pc.cat AS category,
pc.subcat AS subcategory,
pc.maintenance,
pn.[prd_cost] AS cost,
pn.[prd_line] AS product_line,
pn.[prd_start_dt] AS start_date
FROM [silver].[crm_prd_info] pn
LEFT JOIN silver.erp_px_cat_g1v2 pc
ON pn.cat_id = pc.id
WHERE prd_end_dt IS NULL
GO


IF OBJECT_ID ('gold.fact_sales','U') IS NOT NULL
  THEN DROP VIEW gold.fact_sales
GO
CREATE VIEW gold.fact_sales AS
SELECT 
[sls_ord_num] AS order_number,
pn.product_key,
pc.customer_key,
[sls_order_dt] AS order_date,
[sls_ship_dt] AS shipping_date,
[sls_due_dt] AS due_date,
[sls_sales] AS sales_amount,
[sls_quantity] AS quantity,
[sls_price] AS price
FROM [silver].[crm_sales_details] cu
LEFT JOIN gold.dim_products pn
ON cu.sls_prd_key = pn.product_number
LEFT JOIN gold.dim_customers pc
ON cu.[sls_cust_id] = pc.customer_id
GO


















