
-- Aurora Activewear
-- Task 1: Database Setup
-- Create and populate inventory, sales, parcels, and parcel items tables.

CREATE TABLE aurora_inventory (
    model_id TEXT,
    model_name TEXT,
    color TEXT,
    color_name TEXT,
    size TEXT,
    new BOOLEAN,
    forecast_stock INTEGER,
    stock INTEGER,
    price NUMERIC
);

INSERT INTO aurora_inventory VALUES
('M100','AeroRun Tee','BLK','Black','S',true,120,80,35),
('M100','AeroRun Tee','BLK','Black','M',true,100,60,35),
('M100','AeroRun Tee','WHT','White','M',true,90,40,35),
('M200','FlowYoga Top','GRN','Green','S',false,70,30,45),
('M200','FlowYoga Top','GRN','Green','M',false,80,50,45),
('M300','TrailFlex Shorts','BLU','Blue','M',true,110,70,50),
('M300','TrailFlex Shorts','BLU','Blue','L',true,95,20,50);

CREATE TABLE aurora_sales (
    date_date DATE,
    product_id TEXT,
    qty INTEGER
);

INSERT INTO aurora_sales VALUES
('2024-01-02','M100_BLK_S',3),
('2024-01-03','M100_BLK_M',5),
('2024-01-04','M100_WHT_M',2),
('2024-02-02','M200_GRN_S',4),
('2024-02-10','M300_BLU_M',6),
('2024-03-03','M300_BLU_M',2),
('2024-03-05','M200_GRN_M',3);

CREATE TABLE aurora_parcels (
    parcel_id INTEGER,
    parcel_tracking TEXT,
    transporter TEXT,
    priority TEXT,
    date_purchase DATE,
    date_shipping DATE,
    date_delivery DATE,
    date_cancelled DATE
);

INSERT INTO aurora_parcels VALUES
(1,'TRK001','DHL','High','2024-01-02','2024-01-03','2024-01-06',NULL),
(2,'TRK002','UPS','Medium','2024-01-04','2024-01-05','2024-01-10',NULL),
(3,'TRK003','DHL','Low','2024-02-02','2024-02-03','2024-02-08',NULL),
(4,'TRK004','FedEx','High','2024-03-01','2024-03-02','2024-03-05',NULL);

CREATE TABLE aurora_parcel_items (
    parcel_id INTEGER,
    model_name TEXT,
    qty INTEGER
);

INSERT INTO aurora_parcel_items VALUES
(1,'AeroRun Tee',4),
(1,'TrailFlex Shorts',1),
(2,'FlowYoga Top',3),
(3,'TrailFlex Shorts',2),
(4,'AeroRun Tee',2),
(4,'FlowYoga Top',1);
