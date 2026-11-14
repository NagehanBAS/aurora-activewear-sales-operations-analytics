
-- Aurora Activewear
-- Task 2: Database Table Exploration
-- Inspect all four source tables to understand their structure
-- and prepare for inventory, sales, and delivery analytics.

-- Inventory: product models, variants, stock levels, and prices.
SELECT *
FROM aurora_inventory;

-- Sales: transaction dates, product IDs, and quantities sold.
SELECT *
FROM aurora_sales;

-- Parcels: shipping carriers, priorities, and delivery dates.
SELECT *
FROM aurora_parcels;

-- Parcel items: products and quantities associated with each parcel.
SELECT *
FROM aurora_parcel_items;
