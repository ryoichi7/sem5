SELECT
    oi.order_item_id,
    oi.order_id,
    oi.product_id,
    p.product_name,
    oi.quantity,
    COUNT(*) OVER (PARTITION BY oi.product_id) AS total_orders_with_product
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id;

SELECT
    oi.order_item_id,
    oi.order_id,
    oi.product_id,
    p.product_name,
    oi.quantity,
    AVG(oi.quantity) OVER (PARTITION BY oi.product_id) AS avg_quantity
FROM order_items oi
         JOIN products p
              ON oi.product_id = p.product_id;


SELECT
    oi.order_item_id,
    oi.order_id,
    oi.product_id,
    p.product_name,
    oi.quantity,
    SUM(oi.quantity) OVER (ORDER BY oi.quantity) AS total_quantity_sold
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id;

SELECT
    oi.order_item_id,
    oi.order_id,
    oi.product_id,
    p.product_name,
    oi.quantity,
    MAX(oi.quantity) OVER (PARTITION BY oi.product_id) AS max_quantity_in_order
FROM order_items oi
         JOIN products p
              ON oi.product_id = p.product_id;

SELECT
    oi.order_item_id,
    oi.order_id,
    oi.product_id,
    p.product_name,
    oi.quantity,
    MIN(oi.quantity) OVER (PARTITION BY oi.product_id) AS min_quantity_in_order
FROM order_items oi
         JOIN products p
              ON oi.product_id = p.product_id;

SELECT
    p.category_id,
    c.category_name,
    p.product_id,
    p.product_name,
    SUM(oi.quantity) AS total_quantity_sold,
    ROW_NUMBER() OVER (
        PARTITION BY p.category_id
        ORDER BY SUM(oi.quantity) DESC
    ) AS product_rank
FROM products p
         JOIN order_items oi ON p.product_id = oi.product_id
         JOIN categories c ON p.category_id = c.category_id
GROUP BY p.category_id, c.category_name, p.product_id, p.product_name
ORDER BY p.category_id, product_rank;

SELECT
    u.user_id,
    u.username,
    SUM(oi.quantity * oi.price) AS total_spent,
    RANK() OVER (
        ORDER BY SUM(oi.quantity * oi.price) DESC
    ) AS user_rank
FROM users u
         JOIN orders o ON u.user_id = o.user_id
         JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY u.user_id, u.username
ORDER BY user_rank;

SELECT
    p.product_id,
    p.product_name,
    AVG(r.rating) AS average_rating,
    DENSE_RANK() OVER (
        ORDER BY AVG(r.rating) DESC
    ) AS rating_rank
FROM products p
JOIN reviews r ON p.product_id = r.product_id
GROUP BY p.product_id, p.product_name
ORDER BY rating_rank;

SELECT
    u.user_id,
    u.username,
    COUNT(o.order_id) AS total_orders,
    NTILE(4) OVER (
        ORDER BY COUNT(o.order_id) DESC
    ) AS order_quartile
FROM users u
         LEFT JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.username
ORDER BY order_quartile, total_orders DESC;

SELECT
    o.user_id,
    u.username,
    o.order_id,
    o.created_at AS current_order_date,
    LAG(o.created_at) OVER (
        PARTITION BY o.user_id
        ORDER BY o.created_at
        ) AS previous_order_date,
    EXTRACT(
            DAY FROM o.created_at - LAG(o.created_at) OVER (
        PARTITION BY o.user_id
        ORDER BY o.created_at
    )
    ) AS days_since_last_order
FROM orders o
         JOIN users u ON o.user_id = u.user_id
ORDER BY o.user_id, o.created_at;

SELECT
    o.order_id,
    o.user_id,
    o.created_at AS current_order_date,
    LAG(o.created_at) OVER (ORDER BY o.created_at) AS previous_order_date
FROM orders o
ORDER BY o.created_at;

SELECT
    p.product_id,
    p.product_name,
    p.price AS current_price,
    LEAD(p.price) OVER (ORDER BY p.price) AS next_higher_price
FROM products p
ORDER BY p.price;

SELECT
    oi.order_id,
    oi.order_item_id,
    p.product_name,
    FIRST_VALUE(p.product_name) OVER (
        PARTITION BY oi.order_id
        ORDER BY oi.order_item_id
    ) AS first_product_in_order
FROM order_items oi
         JOIN products p ON oi.product_id = p.product_id
ORDER BY oi.order_id, oi.order_item_id;

SELECT
    oi.order_id,
    oi.order_item_id,
    p.product_name,
    LAST_VALUE(p.product_name) OVER (
        PARTITION BY oi.order_id
        ORDER BY oi.order_item_id
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) AS last_product_in_order
FROM order_items oi
         JOIN products p ON oi.product_id = p.product_id
ORDER BY oi.order_id, oi.order_item_id;


SELECT
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_name = 'users';

SELECT
    product_id,
    category_id,
    ROW_NUMBER() OVER (PARTITION BY category_id ORDER BY created_at) AS row_num
FROM
    products;

SELECT
    product_id,
    category_id,
    price,
    RANK() OVER (PARTITION BY category_id ORDER BY price DESC) AS rank_in_category
FROM
    products;

SELECT
    product_id,
    category_id,
    price,
    NTILE(4) OVER (PARTITION BY category_id ORDER BY price) AS ntile_quartile
FROM
    products;

SELECT
    product_id,
    category_id,
    LEAD(price) OVER (PARTITION BY category_id ORDER BY created_at) AS previous_price
FROM
    products;