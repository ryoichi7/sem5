select product_name from products;

select * from products
where company_id is not null;

select product_name, username
from products, users
where product_id == user_id;


select username, count(product_name)
from products
join order_items on products.product_id = order_items.product_id
join orders on order_items.order_id = orders.order_id
join users on orders.user_id = users.user_id
where product_name = 'Носки'
group by username;


SELECT user_id FROM orders
INTERSECT
SELECT user_id FROM reviews;

SELECT user_id FROM orders
EXCEPT
SELECT user_id FROM reviews;

SELECT product_id, AVG(rating) AS average_rating
FROM reviews
GROUP BY product_id;

SELECT product_name, price
FROM products
ORDER BY price DESC;

SELECT u.user_id, u.username
FROM users u
WHERE NOT EXISTS (
    SELECT p.product_id
    FROM products p
    WHERE p.category_id = 1
      AND NOT EXISTS (
        SELECT oi.product_id
        FROM orders o
                 JOIN order_items oi ON o.order_id = oi.order_id
        WHERE o.user_id = u.user_id
          AND oi.product_id = p.product_id
    )
);

CREATE VIEW user_orders AS
SELECT u.user_id, u.username, COUNT(o.order_id) AS total_orders
FROM users u
         LEFT JOIN orders o ON u.user_id = o.user_id
GROUP BY u.user_id, u.username;

select * from user_orders;


-- function
CREATE OR REPLACE FUNCTION update_stock_quantity()
    RETURNS TRIGGER AS $$
DECLARE
    current_stock INT;
BEGIN
    SELECT stock_quantity INTO current_stock
    FROM products
    WHERE product_id = NEW.product_id;

    IF TG_OP = 'INSERT' THEN
        UPDATE products
        SET stock_quantity = current_stock - NEW.quantity
        WHERE product_id = NEW.product_id;

    ELSIF TG_OP = 'UPDATE' THEN
        UPDATE products
        SET stock_quantity = current_stock - NEW.quantity + OLD.quantity
        WHERE product_id = NEW.product_id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- trigger
CREATE TRIGGER trg_update_stock_quantity
    AFTER INSERT OR UPDATE ON order_items
    FOR EACH ROW
EXECUTE FUNCTION update_stock_quantity();