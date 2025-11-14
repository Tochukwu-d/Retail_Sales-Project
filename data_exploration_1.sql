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

LOAD DATA LOCAL INFILE 'C:\\Users\\TOCHUKWU IKWELLE\\Desktop\\Online Retail.csv'
INTO TABLE online_retail
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SHOW VARIABLES LIKE 'local_infile';   # check if local_infile is ON

SELECT * FROM online_retail LIMIT 10;
