IF OBJECT_ID ('silver.crm_prd_info', 'U') IS NOT NULL
	DROP TABLE silver.crm_prd_info;
GO

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
GO


IF OBJECT_ID ('silver.crm_cust_info', 'U') IS NOT NULL
	DROP TABLE silver.crm_cust_info;
GO

CREATE TABLE [silver].[crm_cust_info](
	[cst_id] [int] NULL,
	[cst_key] [nvarchar](50) NULL,
	[cst_firstname] [nvarchar](50) NULL,
	[cst_lastname] [nvarchar](50) NULL,
	[cst_material_status] [nvarchar](50) NULL,
	[cst_gndr] [nvarchar](50) NULL,
	[cts_create_date] [date] NULL,
	[dwh_create_date] [datetime2](7) DEFAULT GETDATE()
);
GO

IF OBJECT_ID ('silver.crm_sales_details', 'U') IS NOT NULL
	DROP TABLE silver.crm_sales_details
GO
	;
CREATE TABLE [silver].[crm_sales_details](
	[sls_ord_num] [nvarchar](50) NULL,
	[sls_prd_key] [nvarchar](50) NULL,
	[sls_cust_id] [int] NULL,
	[sls_order_dt] [date] NULL,
	[sls_ship_dt] [date] NULL,
	[sls_due_dt] [date] NULL,
	[sls_sales] [int] NULL,
	[sls_quantity] [int] NULL,
	[sls_price] [int] NULL,
	[dwh_create_date] [datetime2](7) DEFAULT GETDATE()
);
GO

IF OBJECT_ID ('silver.erp_cust_az12', 'U') IS NOT NULL
	DROP TABLE silver.erp_cust_az12
GO

CREATE TABLE [silver].[erp_cust_az12](
	[cid] [nvarchar](50) NULL,
	[bdate] [date] NULL,
	[gen] [nvarchar](50) NULL,
	[dwh_create_date] [datetime2](7) DEFAULT GETDATE()
);
GO

IF OBJECT_ID ('silver.erp_loc_a101', 'U') IS NOT NULL
	DROP TABLE silver.erp_loc_a101
GO

CREATE TABLE [silver].[erp_loc_a101](
	[cid] [nvarchar](50) NULL,
	[ccountry] [nvarchar](50) NULL,
	[dwh_create_date] [datetime2](7) DEFAULT GETDATE()
);
GO

IF OBJECT_ID ('silver.erp_px_cat_g1v2', 'U') IS NOT NULL
	DROP TABLE silver.erp_px_cat_g1v2
GO

CREATE TABLE [silver].[erp_px_cat_g1v2](
	[id] [nvarchar](50) NULL,
	[cat] [nvarchar](50) NULL,
	[subcat] [nvarchar](50) NULL,
	[maintenance] [nvarchar](50) NULL,
	[dwh_create_date] [datetime2](7) DEFAULT GETDATE()
);
GO

