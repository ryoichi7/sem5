select * from users;

select user_id
from users;

select concat(first_name, ' ', last_name) as name
from users;

select * from orders;

select *
from products
order by product_name;

select *
from products
where price > 200
order by price desc;

alter table users add column is_banned boolean default false;

select username, is_banned from users;

update users
set is_banned = true
where username LIKE 'ivan%';

delete from users
where user_id = 1;

CREATE OR REPLACE FUNCTION count_products_by_category(cat_id INT)
    RETURNS INT AS $$
DECLARE
    product_count INT;
BEGIN
    SELECT COUNT(*) INTO product_count
    FROM products
    WHERE category_id = cat_id;

    RETURN product_count;
END;
$$ LANGUAGE plpgsql;

DO $$
    DECLARE
        cat_record RECORD;
        prod_count INT;
        cat_cursor CURSOR FOR
            SELECT category_id, category_name FROM categories;
    BEGIN
        FOR cat_record IN cat_cursor LOOP
                prod_count := count_products_by_category(cat_record.category_id);
                RAISE NOTICE 'Category: %, Number of products: %', cat_record.category_name, prod_count;
            END LOOP;
    END;
$$;