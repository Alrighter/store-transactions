import csv
import itertools
import random
from datetime import datetime, timedelta

SEED = 42
N_STORES = 50
N_PRODUCTS = 1000
N_CHECKS = 21_000_000
START = datetime(2025, 1, 1)
OPEN_HOUR, WORK_HOURS = 8, 14 

rnd = random.Random(SEED)

with open("data/stores.csv", "w", newline="") as f:
    w = csv.writer(f)
    w.writerow(["id", "name"])
    for i in range(1, N_STORES + 1):
        w.writerow([i, f"Store {i}"])

prices = [round(rnd.uniform(10, 300), 2) for _ in range(N_PRODUCTS)]
with open("data/products.csv", "w", newline="") as f:
    w = csv.writer(f)
    w.writerow(["id", "name"])
    for i in range(1, N_PRODUCTS + 1):
        w.writerow([i, f"Product {i}"])

weights = [1 / r ** 0.8 for r in range(1, N_PRODUCTS + 1)]
rnd.shuffle(weights) 
cum_weights = list(itertools.accumulate(weights))
product_ids = range(1, N_PRODUCTS + 1)

bundles = [rnd.sample(product_ids, rnd.randint(2, 4)) for _ in range(20)]

work_seconds = 0.0
avg_gap = 365 * WORK_HOURS * 3600 / N_CHECKS

with open("data/check_items.csv", "w", newline="") as f:
    w = csv.writer(f)
    w.writerow(["store_id", "product_id", "check_id", "sold_at", "quantity", "unit_price"])

    for check_id in range(1, N_CHECKS + 1):
        work_seconds += rnd.expovariate(1 / avg_gap)
        day, sec = divmod(int(work_seconds), WORK_HOURS * 3600)
        sold_at = START + timedelta(days=day, hours=OPEN_HOUR, seconds=sec)

        store_id = rnd.randint(1, N_STORES)
        n = rnd.randint(1, 7)
        items = set(rnd.choices(product_ids, cum_weights=cum_weights, k=n))
        if rnd.random() < 0.3:
            items.update(rnd.choice(bundles))

        for product_id in items:
            w.writerow([store_id, product_id, check_id, sold_at,
                        rnd.randint(1, 3), prices[product_id - 1]])

        if check_id % 1_000_000 == 0:
            print(f"{check_id:,} чеків")