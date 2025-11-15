CREATE DATABASE retail_analysis;    # creating database......
USE retail_analysis;

CREATE TABLE online_retail (      # creating DB table.....
    invoice_no INT,
    stock_code VARCHAR(20),
    description TEXT,
    quantity INT,
    invoice_date DATETIME,
    unit_price DECIMAL(10,2),
    customer_id INT,
    country VARCHAR(50)
);

SET GLOBAL local_infile = 1;   # to allow SQL read local files

LOAD DATA LOCAL INFILE 'C:\\Users\\TOCHUKWU IKWELLE\\Desktop\\Online Retail.csv'    # path to file
INTO TABLE online_retail
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SHOW VARIABLES LIKE 'local_infile';   # check if local_infile is ON

# Assessing data structure......

DESCRIBE online_retail;    # table structure

SELECT * FROM online_retail LIMIT 10;    # view sample records

SELECT COUNT(*) AS total_records FROM online_retail;   # view total records

# Assessing data quality............
SELECT                            # checking for NULL values in critical columns like 'invoice_no', 'customer_id', 'quantity', 'unit_price'......
	COUNT(*) AS total_null_rows,
    SUM(CASE WHEN invoice_no IS NULL THEN 1 ELSE 0 END) AS null_invoice_no,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS null_customer_id,
    SUM(CASE WHEN quantity IS NULL THEN 1 ELSE 0 END) AS null_quantity,
    SUM(CASE WHEN unit_price IS NULL THEN 1 ELSE 0 END) AS null_unit_price 
FROM online_retail;

SELECT COUNT(*) AS negative_quantity_value             # checking for negative value occurence in quantity and price columns
FROM online_retail
WHERE quantity < 0;

SELECT COUNT(*) AS negative_price_value
FROM online_retail
WHERE unit_price < 0;

SELECT * FROM online_retail
WHERE quantity < 0;

SELECT * FROM online_retail
WHERE unit_price < 0;

SELECT *      # abnormal sales
FROM online_retail
WHERE unit_price < 0 AND description LIKE '%adjust bad debt%';

SELECT SUM(quantity * unit_price) AS net_sales     # net sales analysis with only valid transcations...leaving out instances where price < 0
FROM online_retail
WHERE unit_price > 0;

SELECT        # checking for zero or high values...
    COUNT(*) AS zero_quantity_count
FROM online_retail 
WHERE quantity = 0;

SELECT 
    MIN(unit_price) AS min_price,
    MAX(unit_price) AS max_price,
    AVG(unit_price) AS avg_price
FROM online_retail 
WHERE unit_price > 0;





