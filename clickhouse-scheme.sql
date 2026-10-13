create table stores (
    id UInt16,
    name String
) ENGINE = MergeTree ORDER BY (id);

create table products (
    id UInt16, 
    name String
) ENGINE = MergeTree ORDER BY (id);

create table check_items(
    store_id UInt16, 
    product_id UInt16,
    check_id UInt32,
    sold_at DateTime,
    quantity UInt16,
    unit_price Decimal(10,2)
) ENGINE = MergeTree ORDER BY (sold_at, check_id);