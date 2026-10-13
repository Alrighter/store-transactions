create table stores (
    id int PRIMARY KEY,
    name text NOT NULL
);

create table products (
    id int PRIMARY KEY, 
    name text NOT NULL
);

create table check_items(
    store_id int NOT NULL, 
    product_id int NOT NULL,
    check_id int NOT NULL,
    sold_at timestamp NOT NULL,
    quantity int NOT NULL,
    unit_price numeric(10,2) NOT NULL
);

--indexes:
CREATE INDEX ci_prod_store_time ON check_items (product_id, store_id, sold_at);
CREATE INDEX ci_time_brin ON check_items USING brin (sold_at);