/*
=======================================================================================
Stored Procedure: Load Bronze layer (Source->Bronze)
=======================================================================================
Script Purpose:
      This stored procedure loads data into the 'bronze' schema from external CSV files
      It performs the following actions
      - Truncate the bronze tables before loading data.

Parameters:
     None
     This stored procedure does not accept any parameters or return any values.

Usage Example:
      CALL bronze.load_bronze;
=======================================================================================
*/



DELIMITER $$

CREATE PROCEDURE bronze.load_bronze()
BEGIN

    /* Customer Info */
    TRUNCATE TABLE bronze.crm_cust_info;

    SET @sql = "
    LOAD DATA LOCAL INFILE 
    'C:/Users/tanis/OneDrive/All_DataSet/DataWarehouseProject/sql-data-warehouse-project/datasets/source_crm/cust_info.csv'
    INTO TABLE bronze.crm_cust_info
    FIELDS TERMINATED BY ','
    ENCLOSED BY '\"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS";

    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;



    /* Product Info */
    TRUNCATE TABLE bronze.crm_prd_info;

    SET @sql = "
    LOAD DATA LOCAL INFILE 
    'C:/Users/tanis/OneDrive/All_DataSet/DataWarehouseProject/sql-data-warehouse-project/datasets/source_crm/prd_info.csv'
    INTO TABLE bronze.crm_prd_info
    FIELDS TERMINATED BY ','
    ENCLOSED BY '\"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS";

    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;



    /* Sales Details */
    TRUNCATE TABLE bronze.crm_sales_details;

    SET @sql = "
    LOAD DATA LOCAL INFILE 
    'C:/Users/tanis/OneDrive/All_DataSet/DataWarehouseProject/sql-data-warehouse-project/datasets/source_crm/sales_details.csv'
    INTO TABLE bronze.crm_sales_details
    FIELDS TERMINATED BY ','
    ENCLOSED BY '\"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS";

    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;



    /* ERP Location */
    TRUNCATE TABLE bronze.erp_loc_a101;

    SET @sql = "
    LOAD DATA LOCAL INFILE 
    'C:/Users/tanis/OneDrive/All_DataSet/DataWarehouseProject/sql-data-warehouse-project/datasets/source_erp/LOC_A101.csv'
    INTO TABLE bronze.erp_loc_a101
    FIELDS TERMINATED BY ','
    ENCLOSED BY '\"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS";

    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;



    /* ERP Customer */
    TRUNCATE TABLE bronze.erp_cust_az12;

    SET @sql = "
    LOAD DATA LOCAL INFILE 
    'C:/Users/tanis/OneDrive/All_DataSet/DataWarehouseProject/sql-data-warehouse-project/datasets/source_erp/CUST_AZ12.csv'
    INTO TABLE bronze.erp_cust_az12
    FIELDS TERMINATED BY ','
    ENCLOSED BY '\"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS";

    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;



    /* ERP Product Category */
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;

    SET @sql = "
    LOAD DATA LOCAL INFILE 
    'C:/Users/tanis/OneDrive/All_DataSet/DataWarehouseProject/sql-data-warehouse-project/datasets/source_erp/PX_CAT_G1V2.csv'
    INTO TABLE bronze.erp_px_cat_g1v2
    FIELDS TERMINATED BY ','
    ENCLOSED BY '\"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS";

    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

END $$

DELIMITER ;

select * from bronze.crm_cust_info;
