# Customers whose orders went up 3 months in a row

**Source:** SQL question from a Swiggy Data Analyst interview (shared on LinkedIn). Not a LeetCode problem.

## Question

Given a `swiggy_orders` table, find customers whose number of orders went **up 3 months in a row**: 3 consecutive calendar months where each month has more orders than the month before (e.g. Jan < Feb < Mar).

Edge cases:
- A skipped month breaks the streak (Jan, Feb, Apr is not consecutive).
- Equal counts are not an increase (3 → 3 doesn't count).
- December → January of the next year **is** consecutive.

| Column | Type |
|---|---|
| order_id | int |
| customer_id | int |
| order_date | date |
| amount | int |

## Test data

```sql
CREATE TABLE swiggy_orders (
  order_id INT,
  customer_id INT,
  order_date DATE,
  amount INT
);

INSERT INTO swiggy_orders VALUES
  (1, 101, '2024-01-10', 250),
  (2, 101, '2024-02-05', 300),
  (3, 101, '2024-02-20', 180),
  (4, 101, '2024-03-02', 220),
  (5, 101, '2024-03-15', 350),
  (6, 101, '2024-03-28', 400),
  (7, 102, '2024-01-04', 200),
  (8, 102, '2024-01-22', 150),
  (9, 102, '2024-02-11', 500),
  (10, 102, '2024-03-03', 260),
  (11, 102, '2024-03-19', 310),
  (12, 102, '2024-04-01', 190),
  (13, 102, '2024-04-12', 420),
  (14, 102, '2024-04-25', 275),
  (15, 104, '2024-01-08', 330),
  (16, 104, '2024-02-02', 210),
  (17, 104, '2024-02-17', 290),
  (18, 104, '2024-04-05', 360),
  (19, 104, '2024-04-14', 240),
  (20, 104, '2024-04-29', 410),
  (21, 105, '2024-01-03', 150),
  (22, 105, '2024-01-14', 220),
  (23, 105, '2024-01-27', 180),
  (24, 105, '2024-02-06', 300),
  (25, 105, '2024-02-18', 260),
  (26, 105, '2024-02-26', 190),
  (27, 105, '2024-03-04', 350),
  (28, 105, '2024-03-12', 280),
  (29, 105, '2024-03-21', 230),
  (30, 105, '2024-03-30', 310);
```

Expected output: **101** and **102**.
- 104 is excluded: Jan → Feb → Apr skips March.
- 105 is excluded: 3 → 3 → 4 is not a strict increase.

## Solution (MySQL)

```sql
with table_1 as (
  select customer_id, month(order_date) as month_, year(order_date) as year_,
         count(*) as count_order_by_month
  from swiggy_orders
  group by customer_id, year(order_date), month(order_date)
),

table_2 as (
  select *,
  (year_ * 12 + month_) - row_number() over (partition by customer_id order by year_, month_) as gap_between_month
  from table_1
),

table_3 as (
  select *,
  lag(count_order_by_month, 1) over (partition by customer_id, gap_between_month order by year_, month_) as lag_1,
  lag(count_order_by_month, 2) over (partition by customer_id, gap_between_month order by year_, month_) as lag_2
  from table_2
)
select distinct customer_id from table_3
where count_order_by_month > lag_1 and lag_1 > lag_2;
```

## How it works

1. **Monthly counts:** one row per customer per month with the number of orders.
2. **Gap detection:** `year_ * 12 + month_` turns each month into one running number. Subtracting a row number gives the same value for back-to-back months, so a skipped month starts a new group. Using the year keeps Dec → Jan consecutive.
3. **Look back:** within each customer **and** each group, LAG brings last month's count (`lag_1`) and the count from two months ago (`lag_2`) onto the current row.
4. **Filter:** keep months where this month > last month > the month before. Comparisons with NULL are never true, so the first two months of a run drop out. DISTINCT shows each customer once.
