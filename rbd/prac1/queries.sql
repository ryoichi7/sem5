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
