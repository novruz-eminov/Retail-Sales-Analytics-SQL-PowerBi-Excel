
INSERT INTO dim_customers(customer_id, country)
SELECT DISTINCT
   CustomerID,
   MIN(Country) AS country
FROM staging_retail
WHERE CustomerID IS NOT NULL
GROUP BY customerID


INSERT INTO dim_products (
    product_id,
    description,
    unit_price
)
SELECT
    StockCode,
    MIN(Description),
    MIN(UnitPrice)
FROM staging_retail
GROUP BY StockCode;


INSERT INTO dim_date (
    date_id,
    year,
    month,
    day
)
SELECT DISTINCT
    CAST(InvoiceDate AS DATE),
    YEAR(InvoiceDate),
    MONTH(InvoiceDate),
    DAY(InvoiceDate)
FROM staging_retail;


INSERT INTO fact_sales (
    order_id,
    customer_id,
    product_id,
    order_date,
    quantity,
    unit_price,
    total_price
)
SELECT
    InvoiceNo,
    CustomerID,
    StockCode,
    CAST(InvoiceDate AS DATE),
    Quantity,
    UnitPrice,
    TotalPrice
FROM staging_retail
WHERE CustomerID IS NOT NULL;