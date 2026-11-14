
-- Aurora Activewear
-- Task 3: Identify Unsold Inventory Products
-- Find product variants listed in inventory without recorded sales.

SELECT
    i.model_name,
    i.model_id || '_' || i.color || '_' || i.size AS product_id
FROM aurora_inventory AS i
LEFT JOIN aurora_sales AS s
    ON i.model_id || '_' || i.color || '_' || i.size = s.product_id
WHERE s.product_id IS NULL
ORDER BY i.model_name;
