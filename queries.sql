-- product_id    383;
-- store_id      28;
-- sold_at_from '2025-03-01';
-- sold_at_to   '2025-04-01';

--для нерівностей в джоінах в clickhouse
--SET allow_experimental_join_condition = 1;

SELECT SUM(quantity) sold_products_count
FROM check_items;

SELECT SUM(unit_price * quantity) as sum_of_sold_products
FROM check_items;

SELECT SUM(unit_price * quantity) as sum_of_sold_products
FROM check_items
WHERE sold_at between '2025-03-01' and '2025-04-01';

SELECT SUM(quantity)
FROM check_items
WHERE store_id = 28 and
      product_id = 383 and
      sold_at between '2025-03-01' and '2025-04-01';

SELECT SUM(quantity)
FROM check_items
WHERE product_id = 383 and
      sold_at between '2025-03-01' and '2025-04-01';

SELECT store_id, SUM(quantity * unit_price) AS revenue
FROM check_items
WHERE sold_at between '2025-03-01' and '2025-04-01'
GROUP BY (store_id)
ORDER BY store_id;

with march_items as (
    SELECT check_id, product_id
    FROM check_items
    WHERE sold_at between '2025-03-01' and '2025-04-01'
)
select first.product_id as p1, second.product_id as p2, count(*) as times
from march_items first
join march_items second on second.check_id = first.check_id and second.product_id > first.product_id
GROUP BY p1, p2
ORDER BY times DESC
LIMIT 10;

with march_items as (
    SELECT check_id, product_id
    FROM check_items
    WHERE sold_at between '2025-03-01' and '2025-04-01'
)
select first.product_id as p1, second.product_id as p2, third.product_id as p3, count(*) as times
from march_items first
join march_items second on second.check_id = first.check_id and second.product_id > first.product_id
join march_items third on third.check_id = first.check_id and third.product_id > second.product_id
GROUP BY p1, p2, p3
ORDER BY times DESC
LIMIT 10;

with march_items as (
    SELECT check_id, product_id
    FROM check_items
    WHERE sold_at between '2025-03-01' and '2025-04-01'
)
select first.product_id as p1, second.product_id as p2, third.product_id as p3, fourth.product_id as p4, count(*) as times
from march_items first
join march_items second on second.check_id = first.check_id and second.product_id > first.product_id
join march_items third on third.check_id = first.check_id and third.product_id > second.product_id
join march_items fourth on fourth.check_id = first.check_id and fourth.product_id > third.product_id
GROUP BY p1, p2, p3, p4
ORDER BY times DESC
LIMIT 10;