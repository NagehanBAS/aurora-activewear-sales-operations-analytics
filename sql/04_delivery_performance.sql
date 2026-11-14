
-- Aurora Activewear
-- Task 4: Delivery Performance Analysis
-- Analyze delivery times, parcel volumes, and shipped product
-- quantities by purchase month, priority, and carrier.
-- Delivery times are measured in calendar days.

WITH parcel_summary AS (
    SELECT
        p.parcel_id,
        CAST(strftime('%m', p.date_purchase) AS INTEGER) AS purchase_month,
        p.priority,
        p.transporter,
        julianday(p.date_delivery) - julianday(p.date_purchase) AS delivery_days,
        SUM(pi.qty) AS total_items
    FROM aurora_parcels AS p
    INNER JOIN aurora_parcel_items AS pi
        ON p.parcel_id = pi.parcel_id
    WHERE p.date_delivery IS NOT NULL
      AND p.date_cancelled IS NULL
    GROUP BY
        p.parcel_id,
        p.date_purchase,
        p.date_delivery,
        p.priority,
        p.transporter
)

SELECT
    purchase_month,
    priority,
    transporter,
    ROUND(AVG(delivery_days), 2) AS average_delivery_time,
    MIN(delivery_days) AS minimum_delivery_time,
    MAX(delivery_days) AS maximum_delivery_time,
    COUNT(*) AS number_of_parcels,
    SUM(total_items) AS total_products
FROM parcel_summary
GROUP BY
    purchase_month,
    priority,
    transporter
ORDER BY
    purchase_month,
    priority,
    transporter;
