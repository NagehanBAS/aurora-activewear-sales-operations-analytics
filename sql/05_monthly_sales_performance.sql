
-- Aurora Activewear
-- Task 5: Monthly Sales Performance Analysis
-- Calculate monthly sales volume, revenue, average basket value,
-- and average daily units sold.
--
-- Methodology:
-- Average basket value is estimated per sales record because
-- the dataset does not include unique order identifiers.
-- Daily averages are calculated using recorded sales days only.

WITH sales_detail AS (
    SELECT
        s.date_date,
        CAST(strftime('%m', s.date_date) AS INTEGER) AS purchase_month,
        s.product_id,
        s.qty,
        i.price,
        s.qty * i.price AS revenue
    FROM aurora_sales AS s
    INNER JOIN aurora_inventory AS i
        ON s.product_id =
           i.model_id || '_' || i.color || '_' || i.size
)

SELECT
    purchase_month,
    SUM(qty) AS total_products_sold,
    ROUND(SUM(revenue), 2) AS total_revenue,
    ROUND(
        SUM(revenue) * 1.0 / NULLIF(COUNT(*), 0),
        2
    ) AS average_basket,
    ROUND(
        SUM(qty) * 1.0 / NULLIF(COUNT(DISTINCT date_date), 0),
        2
    ) AS average_products_sold_per_day
FROM sales_detail
GROUP BY purchase_month
ORDER BY purchase_month;
