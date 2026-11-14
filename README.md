# Aurora Activewear | Sales & Operational Performance Analytics

**SQL Portfolio Project | SQLite | Inventory Management, Sales Analytics & Logistics Performance**

## Project Overview

This project explores the sales and operational performance of Aurora Activewear, a fictional European sustainable activewear business operating across B2C and B2B channels.

Using SQLite, the analysis combines inventory, sales transactions, shipping records, and parcel-level product information to investigate inventory utilization, revenue generation, and delivery efficiency.

The project demonstrates how structured SQL analysis can transform operational data into actionable business insights supporting commercial planning, inventory decisions, and logistics performance monitoring.

### Business Objectives

- Explore the database structure and identify relationships between operational datasets.
- Identify inventory product variants with no recorded sales.
- Evaluate delivery performance across carriers, shipping priorities, and months.
- Calculate monthly sales volumes, revenue, and average transaction-level revenue.
- Support data-driven decisions related to stock allocation, promotional planning, and operational efficiency.

## Technology & Analytical Methods

**Database:** SQLite  
**Language:** SQL  
**Development Environment:** SQLite Online  
**Version Control:** Git & GitHub

**SQL techniques applied:**
- Common Table Expressions (CTEs)
- INNER JOIN and LEFT JOIN
- Aggregation with SUM, AVG, MIN, MAX, and COUNT
- GROUP BY and ORDER BY
- Date extraction using strftime()
- Date calculations using julianday()
- Conditional filtering and NULL handling
- Calculated product identifiers
- Revenue and operational KPI calculations

## Dataset & Data Model

The project uses four interconnected tables containing sample records for January–March 2024.

| Table | Records | Description |
|---|---:|---|
| `aurora_inventory` | 7 | Product models, colors, sizes, prices, and stock levels |
| `aurora_sales` | 7 | Sales dates, product identifiers, and quantities |
| `aurora_parcels` | 4 | Shipment information, carriers, priorities, and delivery dates |
| `aurora_parcel_items` | 6 | Products and quantities associated with individual parcels |

### Data Relationships

**Inventory to Sales**

A product-level identifier is constructed by concatenating `model_id`, `color`, and `size`.

For example:

`M100_BLK_S`

This identifier connects inventory product variants to sales records through `product_id`.

**Parcels to Parcel Items**

The `parcel_id` field links shipment records to their associated product quantities.

Because a parcel may contain multiple product entries, the delivery analysis aggregates parcel items before calculating shipment-level KPIs. This prevents duplicate counting of parcels and biased delivery averages.

## SQL Project Structure

```text
aurora-activewear-sales-operations-analytics/
│
├── README.md
│
└── sql/
    ├── 01_database_setup.sql
    ├── 02_table_exploration.sql
    ├── 03_unsold_products.sql
    ├── 04_delivery_performance.sql
    └── 05_monthly_sales_performance.sql
```

### Analysis Workflow

| File | Purpose |
|---|---|
| `01_database_setup.sql` | Create and populate the four source tables |
| `02_table_exploration.sql` | Inspect table structures and operational records |
| `03_unsold_products.sql` | Identify inventory variants without recorded sales |
| `04_delivery_performance.sql` | Calculate delivery-time and parcel-volume KPIs |
| `05_monthly_sales_performance.sql` | Calculate monthly revenue and sales performance metrics |

## Analysis 1 — Unsold Inventory Identification

**Business Question:** Which product variants exist in inventory but have no recorded sales?

A LEFT JOIN connects inventory records to sales using a constructed product identifier. An `IS NULL` filter identifies product variants without matching sales records.

### Results

| Product Model | Product ID | Finding |
|---|---|---|
| TrailFlex Shorts | `M300_BLU_L` | No recorded sales |

The unsold variant corresponds to the blue, size L version of TrailFlex Shorts.

Importantly, this does not mean the entire TrailFlex Shorts model is unsold. The size M variant has recorded transactions.

### Business Implications

- Review demand patterns at the SKU level rather than relying exclusively on model-level performance.
- Investigate whether the unsold variant requires targeted promotion or inventory redistribution.
- Incorporate variant-level sales patterns into future stock forecasting and replenishment decisions.

**Key Insight:** SKU-level analysis can reveal inventory issues that may be hidden by aggregated product-model performance.

## Analysis 2 — Delivery Performance

**Business Question:** How efficiently are shipments delivered across carriers, priorities, and months?

Delivery duration is measured as the number of calendar days between purchase and delivery.

The analysis calculates:

- Average delivery time
- Minimum delivery time
- Maximum delivery time
- Number of parcels
- Total products shipped

Results are grouped by purchase month, shipping priority, and transporter.

### Results

| Purchase Month | Priority | Transporter | Avg. Delivery (Days) | Min. | Max. | Parcels | Products |
|---|---|---|---:|---:|---:|---:|---:|
| January | High | DHL | 4 | 4 | 4 | 1 | 5 |
| January | Medium | UPS | 6 | 6 | 6 | 1 | 3 |
| February | Low | DHL | 6 | 6 | 6 | 1 | 2 |
| March | High | FedEx | 4 | 4 | 4 | 1 | 3 |

### Overall Operational KPIs

| KPI | Result |
|---|---:|
| Total Parcels | 4 |
| Total Products Shipped | 13 |
| Average Delivery Time | 5 days |
| Minimum Delivery Time | 4 days |
| Maximum Delivery Time | 6 days |

### Business Insights

**Delivery Speed**

The shortest observed delivery duration was four days, while the longest was six days.

**Carrier Performance**

The sample includes DHL, UPS, and FedEx. Delivery duration varies across shipments, but the number of observations is too small to establish statistically meaningful carrier rankings.

**Operational Reporting**

Parcel-level aggregation ensures that shipments containing multiple products are counted only once when evaluating delivery efficiency.

### Business Implications

- Monitor carrier performance using consistently defined delivery KPIs.
- Expand the analysis with additional shipment records to evaluate differences across carriers and priority categories.
- Combine delivery metrics with fulfillment volumes when reviewing operational performance.

## Analysis 3 — Monthly Sales Performance

**Business Question:** How do sales volume, revenue, and average sales performance vary by month?

Sales data is joined with inventory prices through constructed product identifiers.

Revenue is calculated as:

`Revenue = Unit Price × Quantity Sold`

### Monthly Sales KPIs

| Purchase Month | Products Sold | Total Revenue | Average Basket* | Avg. Products Sold per Sales Day |
|---|---:|---:|---:|---:|
| January | 10 | 350 | 116.67 | 3.33 |
| February | 10 | 480 | 240.00 | 5.00 |
| March | 5 | 235 | 117.50 | 2.50 |

*Average basket is calculated as revenue per sales record rather than per customer order because the dataset does not contain order identifiers.*

*The daily average uses dates with recorded sales, not all calendar days in the month.*

### Sales Performance Highlights

**February Generated the Highest Revenue**

February recorded total revenue of 480, compared with 350 in January and 235 in March.

**Product Mix Influenced Revenue**

January and February both recorded 10 units sold, but February generated greater revenue.

This reflects differences in the prices and quantities of products sold.

**March Recorded Lower Sales Volume**

March recorded five units sold, compared with 10 units in each preceding month.

The limited dataset does not establish whether this reduction reflects seasonality, customer demand, or other commercial factors.

### Overall Sales KPIs

| KPI | Result |
|---|---:|
| Total Products Sold | 25 |
| Total Revenue | 1,065 |
| Sales Records | 7 |
| Months Analyzed | 3 |
| Highest-Revenue Month | February |

Revenue figures are expressed in dataset monetary units because no currency is explicitly specified.

## Key Business Recommendations

### 1. Strengthen SKU-Level Inventory Monitoring

Track product sales by model, color, and size to identify underperforming variants and support more granular replenishment planning.

### 2. Improve Commercial Performance Reporting

Monitor monthly revenue alongside unit sales, product mix, and average revenue per sales record.

This provides more context than analyzing sales volume alone.

### 3. Standardize Delivery Performance KPIs

Use consistent delivery-duration calculations and parcel-level aggregation to evaluate logistics performance without inflating shipment counts.

### 4. Expand Analytical Data Coverage

Introduce additional historical transactions, customer order identifiers, and shipment observations to support more reliable trend analysis, basket metrics, and carrier comparisons.

### 5. Connect Operational and Commercial Decisions

Combine sales performance, stock availability, and delivery efficiency to improve coordination between commercial planning, inventory management, and logistics operations.

## Methodology & Limitations

This project uses a small, illustrative dataset and should be interpreted as a demonstration of SQL-based business analysis rather than a complete operational performance assessment.

**Key considerations:**

- The data covers January through March 2024.
- Only seven sales records and four parcels are available.
- No unique sales-order identifiers are provided.
- Average basket value therefore represents revenue per sales record.
- Average daily sales are calculated using days with recorded transactions.
- The currency of revenue values is unspecified.
- Carrier-level observations are insufficient for reliable performance rankings.
- Recorded delivery durations are calculated from purchase date to delivery date, not shipping date to delivery date.
- Inventory and shipment quantities describe different datasets and are not assumed to reconcile directly.

These limitations are important when interpreting the results or extending the project to a larger business environment.

## How to Run

1. Open a SQLite-compatible environment, such as SQLite Online.
2. Execute `sql/01_database_setup.sql` to create and populate the tables in a fresh database.
3. Run `sql/02_table_exploration.sql` to inspect the source data.
4. Execute `sql/03_unsold_products.sql` to identify unsold inventory variants.
5. Execute `sql/04_delivery_performance.sql` to calculate shipping and delivery KPIs.
6. Execute `sql/05_monthly_sales_performance.sql` to generate monthly sales metrics.

The analysis scripts can be executed independently after the database has been initialized.

## Skills Demonstrated

- SQL querying and relational data exploration
- Data modeling and composite product identifier construction
- JOIN operations across operational datasets
- Aggregation and KPI reporting
- Revenue and sales performance analysis
- Inventory optimization analytics
- Logistics and delivery performance measurement
- Business insight generation
- Analytical documentation and reproducibility

## Author

**Nagehan Bas**
