/*
=====================================================================================
Quality Checks
=====================================================================================
Script Purpose:
       This script performs various quality checks for data consistency,accuracy and 
       standardization accross the 'silver' schemas.It includes checks for:
       --Null or duplicate primary keys.
       --Unwanted spaces in string field.
       --Data standardization and consistency.
       --Invalid date ranges and orders.
       --Data consistency between related fields.

Usage Notes:
     --Run these checks after data loading Silver Layer.
     --Investigate and resolve any discrepanics found during the checks.
=====================================================================================
*/



#check for crm_cust_info
#Check For Nulls or Duplicates in Primary Key
#Expectaion:No Result


select 
cst_id,
count(*)
from silver.crm_cust_info
group by cst_id
having count(*)>1 or cst_id is null;


#Check for unwanted Spaces
#Expectation:No Results

select cst_firstname
from silver.crm_cust_info
where cst_firstname!=trim(cst_firstname);

select cst_lastname
from silver.crm_cust_info
where cst_lastname!=trim(cst_lastname);

select cst_gndr
from silver.crm_cust_info
where cst_gndr!=trim(cst_gndr);

#Data Standardization & consistency

select distinct cst_gndr
from silver.crm_cust_info;

select distinct cst_material_status
from silver.crm_cust_info;



#For crm_prd_info
# Check for Nulls or Duplicates in Primary Key
# Expectation : No Result

select * from crm_prd_info;

select 
prd_id,
count(*)
from silver.crm_prd_info
group by prd_id
having count(*)>1 or prd_id is null;

#Check for unwanted Spaces
#Expectation:No Results

select prd_nm
from silver.crm_prd_info
where prd_nm!=trim(prd_nm);

#Check for NULLs or Negative Numbers
#Expectation : No Results

select prd_cost
from silver.crm_prd_info
where prd_cost < 0 or prd_cost is null or prd_cost='';

#Data Standardization & consistency
#Expectation : No Results

select distinct prd_line
from silver.crm_prd_info;

#Check for invalid date orders
select *
from silver.crm_prd_info
where prd_start_dt > prd_end_dt;


#Check for crm_sales_details
#Check For Nulls or Duplicates in Primary Key
#Expectaion:No Result

select * from silver.crm_sales_details;


select 
sls_ord_num,
count(*)
from silver.crm_sales_details
group by sls_ord_num
having count(*)>1 or sls_ord_num is null;

select 
*
from silver.crm_sales_details
where sls_ord_num='SO51176'
;

#Check for invalid date orders

select 
nullif(sls_order_dt,0)
from silver.crm_sales_details
where sls_order_dt<=0
or length(sls_order_dt)!=8
or sls_order_dt > 20500101
or sls_order_dt < 19000101;

select 
nullif(sls_ship_dt,0)
from silver.crm_sales_details
where sls_ship_dt<=0
or length(sls_ship_dt)!=8
or sls_ship_dt > 20500101
or sls_ship_dt < 19000101;

select 
nullif(sls_due_dt,0)
from silver.crm_sales_details
where sls_due_dt<=0
or length(sls_due_dt)!=8
or sls_due_dt > 20500101
or sls_due_dt < 19000101;

select 
*
from silver.crm_sales_details
where sls_order_dt > sls_ship_dt or sls_order_dt > sls_due_dt;

#Check Data Consistency: Between Sales,Quantity and Price
#Sales = Quantity * Price
#Values must not be null , zero or negative

select distinct
sls_sales ,
sls_quantity,
sls_price 
from silver.crm_sales_details
where sls_sales != sls_quantity * sls_price
or sls_sales is null or sls_sales='' or sls_quantity is null or sls_price is null
or sls_sales <= 0  or sls_quantity <= 0  or sls_price <= 0 
order by
sls_sales,
sls_quantity,
sls_price;


#Check for erp_cus
#For erp_cust_az12
#Identify Out-of-Range Dates

select * from silver.erp_cust_az12;

select distinct
bdate
from silver.erp_cust_az12
where bdate < '1924-01-01' or bdate > curdate();


#Data Standardization & Consistency
select distinct
gen
from silver.erp_cust_az12;


#check for erp_loc
#Data Standardization & Consistency

select * from silver.erp_loc_a101;

select distinct cntry 
from silver.erp_loc_a101
order by cntry;
