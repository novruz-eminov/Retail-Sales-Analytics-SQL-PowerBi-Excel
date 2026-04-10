CREATE DATABASE RetailAnalytics;

CREATE TABLE staging_retail (
    InvoiceNo NVARCHAR(20),
    StockCode NVARCHAR(20),
    Description NVARCHAR(255),
    Quantity INT,
    InvoiceDate DATETIME,
    UnitPrice DECIMAL(10,2),
    CustomerID INT,
    Country NVARCHAR(100),
    TotalPrice DECIMAL(12,2)
);

CREATE TABLE dim_customers (
    customer_id INT PRIMARY KEY,
    country NVARCHAR(100)
);

CREATE TABLE dim_products (
    product_id NVARCHAR(20) PRIMARY KEY,
    description NVARCHAR(255),
    unit_price DECIMAL(10,2)
);

CREATE TABLE dim_date (
    date_id DATE PRIMARY KEY,
    year INT,
    month INT,
    day INT
);

CREATE TABLE fact_sales (
    sales_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id NVARCHAR(20),
    customer_id INT,
    product_id NVARCHAR(20),
    order_date DATE,
    quantity INT,
    unit_price DECIMAL(10,2),
    total_price DECIMAL(12,2)
);
