/*
================================================================================
Quality Checks
================================================================================
Script Purpose:
       This script performs quality checks to validate the integrity,consistency
       and accuracy of the gold layer.These checks ensure:
       --Uniqueness of surrogate keys in dimension table.
       --Referential Integrity between fact and dimension
       --Validation of relationships in the data model for analytical purposes

Usage Notes:
       - Run these checks after data loading Silver layer
       - Investigate and resolve any discrepanics found during the checks
================================================================================
*/




--Joining 2 gender columns by taking CRM as master gender
select distinct
ci.cst_gndr,
ca.gen,
case when ci.cst_gndr != 'n/a' then ci.cst_gndr #CRM is the Master for gender Info
     else coalesce(ca.gen,'n/a')
end as new_gen
from silver.crm_cust_info ci
left join silver.erp_cust_az12 ca
on        ci.cst_key = ca.cid
left join silver.erp_loc_a101 la
on ci.cst_key = la.cid
order by 1 , 2 ;

select * from gold.dim_customers;

select distinct
gender 
from gold.dim_customers;

select * from gold.dim_products;

select * from gold.fact_sales;

--Checking 'gold.customer_key'
--Check for uniqueness of product key in gold.dim_customers
--Expetation:No result
select 
  customer_key,
  count(*) as duplicate_count
from gold.dim_customers
group by customer_key
having count(*) > 1;


--Checking 'gold.product_key'
--Check for uniqueness of product key in gold.dim_products
--Expectation:No result
select 
  product_key,
  count(*) as duplicate_count
from gold.dim_products
group by product_key
having count(*) > 1;

--Checking 'gold.fact_sales'
--Check the data model connectivity between fact and dimension
select *
from gold.fact_sales f
left join gold.dim_customers c
on c.customer_key = f.customer_key
left join gold.dim_products p
on p.product_key = f.product_key
where c.customer_key is null;
