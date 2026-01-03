SELECT customer_key, COUNT(*)
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1


SELECT product_key, COUNT(*)
FROM gold.dim_product
GROUP BY product_key
HAVING COUNT(*) > 1
	
SELECT DISTINCT
cst_gndr,
ca.gen,
CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr
	ELSE COALESCE(ca.gen, 'n/a')
	END AS new_gen
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca
ON ci.cst_key = ca.cid 
LEFT JOIN silver.erp_loc_a101 la
ON ci.cst_key = la.cid
ORDER BY 1,2



SELECT * 
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
WHERE p.product_key iS NULL
