/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME,@end_time DATETIME,@batch_start_time DATETIME,@batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time=GETDATE();
		PRINT '==============================================================';
		PRINT'Loading Bronze Layer';
		PRINT'===============================================================';

		PRINT'---------------------------------------------------------------';
		PRINT'Loading CRM Tables';
		PRINT'---------------------------------------------------------------';
		SET @start_time = GETDATE();
		PRINT '>> Truncting Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
		PRINT'>> Inserting Data Into: bronze.crm_cust_info'
		BULK INSERT bronze.crm_cust_info
		FROM 'E:\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH
		(
		FIRSTROW = 2,
		FIELDTERMINATOR=',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		print' >> Loading Duration: ' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' seconds';
		print'-----------------------------------------------------------------';

		PRINT '>> Truncting Table: bronze.crm_prd_info';

		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT'>> Inserting Data Into: bronze.crm_prd_info'

		BULK INSERT bronze.crm_prd_info
		FROM 'E:\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH
		(
		FIRSTROW = 2,
		FIELDTERMINATOR=',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		print' >> Loading Duration: ' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' seconds';
		print'-------------------------------------------------------------------';

		PRINT '>> Truncting Table: bronze.crm_sales_details';
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_sales_details;
		PRINT'>> Inserting Data Into: bronze.crm_sales_details'
		BULK INSERT bronze.crm_sales_details
		FROM 'E:\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH
		(
		FIRSTROW = 2,
		FIELDTERMINATOR=',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		print' >> Loading Duration: ' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' seconds';
		print'-------------------------------------------------------------------';


		PRINT'-------------------------------------------------------------------';
		PRINT'Loading ERP Tables';
		PRINT'-------------------------------------------------------------------';

		PRINT '>> Truncting Table: bronze.erp_CUST_AZ12';
		SET @start_time = GETDATE();

		TRUNCATE TABLE bronze.erp_CUST_AZ12;

		PRINT'>> Inserting Data Into: bronze.crm_sales_details'
		BULK INSERT bronze.erp_CUST_AZ12
		FROM 'E:\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH
		(
		FIRSTROW = 2,
		FIELDTERMINATOR=',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		print' >> Loading Duration: ' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' seconds';
		print'-------------------------------------------------------------------';

		PRINT '>> Truncting Table: bronze.erp_LOC_A101';
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_LOC_A101;
		PRINT'>> Inserting Data Into: bronze.erp_LOC_A101'
		BULK INSERT bronze.erp_LOC_A101
		FROM 'E:\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH
		(
		FIRSTROW = 2,
		FIELDTERMINATOR=',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		print' >> Loading Duration: ' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' seconds';
		print'-------------------------------------------------------------------';
	
		PRINT '>> Truncting Table: bronze.erp_PX_CAT_G1V2';
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;
		PRINT'>> Inserting Data Into: bronze.erp_PX_CAT_G1V2'
		BULK INSERT bronze.erp_PX_CAT_G1V2
		FROM 'E:\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH
		(
		FIRSTROW = 2,
		FIELDTERMINATOR=',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		print' >> Loading Duration: ' + CAST(DATEDIFF(second, @start_time,@end_time) AS NVARCHAR) + ' seconds';
		print'-----------------------------------------------------------------';
		SET @batch_end_time= GETDATE()
		PRINT'=================================================================';
		PRINT'Loading Bronze Layer is Completed';
		PRINT'   - Total Load  Duration: ' + CAST(DATEDIFF(SECOND,@batch_start_time,@batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT'================================================================='
	END TRY
	BEGIN CATCH
		PRINT '================================================================';
		PRINT 'Error Occured During Loading Bronze Layer';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR)
		PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '================================================================';
	END CATCH
END
