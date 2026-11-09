-- Все заказы с покупателем, товарами и производителями
SELECT o.order_id,
       o.created_at::date       AS order_date,
       o.status,
       c.full_name              AS customer,
       c.email,
       p.name                   AS product,
       m.name                   AS manufacturer,
       oi.quantity,
       oi.unit_price,
       oi.quantity * oi.unit_price AS line_total
FROM orders o
JOIN customers      c  ON c.customer_id = o.customer_id
JOIN order_items    oi ON oi.order_id   = o.order_id
JOIN products       p  ON p.product_id  = oi.product_id
JOIN manufacturers  m  ON m.manufacturer_id = p.manufacturer_id
ORDER BY o.order_id, p.name;


-- Покупатели, не сделавшие ни одного заказа, + их потенциальные категории интереса
-- (для демонстрации LEFT JOIN по трём таблицам)
SELECT c.customer_id,
       c.full_name,
       c.email,
       COUNT(o.order_id) AS orders_count,
       COALESCE(SUM(o.total_amount), 0) AS total_spent
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
LEFT JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY c.customer_id, c.full_name, c.email
HAVING COUNT(o.order_id) = 0
ORDER BY c.customer_id;


-- Товары, которые: (а) были куплены хотя бы раз,
-- (б) остаток на складе < 20, (в) производитель из США или Китая
SELECT p.product_id,
       p.name,
       p.price,
       p.stock_qty,
       m.name    AS manufacturer,
       m.country,
       COUNT(oi.order_id) AS times_ordered,
       SUM(oi.quantity)   AS total_qty_sold
FROM products p
JOIN manufacturers m  ON m.manufacturer_id = p.manufacturer_id
JOIN order_items   oi ON oi.product_id     = p.product_id
WHERE p.stock_qty < 20
  AND m.country IN ('США', 'Китай')
GROUP BY p.product_id, p.name, p.price, p.stock_qty, m.name, m.country
HAVING SUM(oi.quantity) >= 1
ORDER BY total_qty_sold DESC;

-- По каждой категории: сколько товаров, средняя/мин/макс цена, суммарный остаток
SELECT cat.name                              AS category,
       COUNT(p.product_id)                   AS products_count,
       ROUND(AVG(p.price), 2)                AS avg_price,
       MIN(p.price)                          AS min_price,
       MAX(p.price)                          AS max_price,
       SUM(p.stock_qty)                      AS total_stock
FROM categories cat
JOIN products   p ON p.category_id = cat.category_id
GROUP BY cat.name
ORDER BY products_count DESC;


-- Покупатели, потратившие больше 150000 руб. суммарно
SELECT c.customer_id,
       c.full_name,
       COUNT(DISTINCT o.order_id) AS orders_count,
       SUM(o.total_amount)        AS total_spent,
       ROUND(AVG(o.total_amount), 2) AS avg_order
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
WHERE o.status <> 'cancelled'
GROUP BY c.customer_id, c.full_name
HAVING SUM(o.total_amount) > 150000
ORDER BY total_spent DESC;

-- По месяцам: число заказов, выручка, средний чек
SELECT TO_CHAR(created_at, 'YYYY-MM') AS month,
       COUNT(*)                        AS orders_count,
       SUM(total_amount)               AS revenue,
       ROUND(AVG(total_amount), 2)     AS avg_order,
       COUNT(*) FILTER (WHERE status = 'cancelled') AS cancelled_count
FROM orders
GROUP BY TO_CHAR(created_at, 'YYYY-MM')
ORDER BY month;

-- Товары, цена которых выше средней цены в их категории
SELECT p.product_id,
       p.name,
       p.price,
       cat.name AS category,
       (SELECT ROUND(AVG(p2.price), 2)
        FROM products p2
        WHERE p2.category_id = p.category_id) AS avg_in_category
FROM products p
JOIN categories cat ON cat.category_id = p.category_id
WHERE p.price > (SELECT AVG(p2.price)
                 FROM products p2
                 WHERE p2.category_id = p.category_id)
ORDER BY cat.name, p.price DESC;

-- Покупатели, у которых есть хотя бы один доставленный заказ
SELECT c.customer_id, c.full_name, c.email
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
      AND o.status = 'delivered'
)
ORDER BY c.customer_id;


-- Товары, которые ни разу не были куплены (нет ни одной позиции заказа)
SELECT p.product_id, p.name, p.price, p.stock_qty, p.sku
FROM products p
WHERE NOT EXISTS (
    SELECT 1
    FROM order_items oi
    WHERE oi.product_id = p.product_id
)
ORDER BY p.product_id;


-- Для каждого покупателя: количество его заказов и доля от общего числа заказов
SELECT c.customer_id,
       c.full_name,
       (SELECT COUNT(*) FROM orders o WHERE o.customer_id = c.customer_id) AS my_orders,
       ROUND(
           100.0 * (SELECT COUNT(*) FROM orders o WHERE o.customer_id = c.customer_id)
                 / (SELECT COUNT(*) FROM orders),
           2) AS percent_of_total
FROM customers c
ORDER BY my_orders DESC, c.customer_id;


WITH line_stats AS (
    -- Этап 1: выручка по каждой позиции заказа
    SELECT oi.order_id,
           oi.product_id,
           oi.quantity * oi.unit_price AS line_revenue,
           o.created_at,
           p.category_id
    FROM order_items oi
    JOIN orders   o ON o.order_id   = oi.order_id
    JOIN products p ON p.product_id = oi.product_id
    WHERE o.status <> 'cancelled'          -- отменённые не считаем
),
category_month AS (
    -- Этап 2: агрегация по (категория, месяц)
    SELECT cat.name                              AS category,
           TO_CHAR(ls.created_at, 'YYYY-MM')     AS month,
           SUM(ls.line_revenue)                  AS revenue,
           COUNT(DISTINCT ls.order_id)           AS orders_count,
           ROUND(AVG(ls.line_revenue), 2)        AS avg_line
    FROM line_stats ls
    JOIN categories cat ON cat.category_id = ls.category_id
    GROUP BY cat.name, TO_CHAR(ls.created_at, 'YYYY-MM')
),
ranked AS (
    -- Этап 3: ранг категории внутри месяца по выручке
    SELECT cm.*,
           RANK() OVER (PARTITION BY cm.month ORDER BY cm.revenue DESC) AS rank_in_month,
           ROUND(
               100.0 * cm.revenue
                     / SUM(cm.revenue) OVER (PARTITION BY cm.month),
               2) AS percent_of_month
    FROM category_month cm
)
-- Этап 4: итоговый отчёт
SELECT month,
       rank_in_month,
       category,
       revenue,
       orders_count,
       avg_line,
       percent_of_month
FROM ranked
ORDER BY month, rank_in_month;