INSERT INTO users (username, email, password_hash, first_name, last_name, phone_number, address)
VALUES
    ('ivan_ivanov', 'ivan@example.com', 'hash1', 'Иван', 'Иванов', '+79161234567', 'Москва, ул. Ленина, 10'),
    ('petr_petrov', 'petr@example.com', 'hash2', 'Петр', 'Петров', '+79161234568', 'Санкт-Петербург, ул. Мира, 20'),
    ('sergey_sergeev', 'sergey@example.com', 'hash3', 'Сергей', 'Сергеев', '+79161234569', 'Новосибирск, ул. Лесная, 5'),
    ('maria_smirnova', 'maria@example.com', 'hash4', 'Мария', 'Смирнова', '+79161234570', 'Екатеринбург, ул. Центральная, 15'),
    ('anna_kuznetsova', 'anna@example.com', 'hash5', 'Анна', 'Кузнецова', '+79161234571', 'Казань, ул. Гоголя, 8'),
    ('oleg_ivanov', 'oleg@example.com', 'hash6', 'Олег', 'Иванов', '+79161234572', 'Нижний Новгород, ул. Чехова, 12'),
    ('elena_petrova', 'elena@example.com', 'hash7', 'Елена', 'Петрова', '+79161234573', 'Челябинск, ул. Комсомольская, 6'),
    ('dmitry_sidorov', 'dmitry@example.com', 'hash8', 'Дмитрий', 'Сидоров', '+79161234574', 'Ростов-на-Дону, ул. Пушкина, 18'),
    ('viktor_fedorov', 'viktor@example.com', 'hash9', 'Виктор', 'Федоров', '+79161234575', 'Самара, ул. Куйбышева, 2'),
    ('olga_morozova', 'olga@example.com', 'hash10', 'Ольга', 'Морозова', '+79161234576', 'Волгоград, ул. Карла Маркса, 4');

INSERT INTO categories (category_name, description)
VALUES
    ('Одежда', 'Одежда для мужчин и женщин'),
    ('Мебель', 'Домашняя мебель'),
    ('Электроника', 'Бытовая электроника'),
    ('Книги', 'Художественная и учебная литература'),
    ('Продукты', 'Продукты питания');

INSERT INTO products (category_id, product_name, description, price, stock_quantity)
VALUES
    (1, 'Носки', 'Мягкие и теплые носки', 199.99, 100),
    (2, 'Табуретка', 'Деревянная табуретка для кухни', 599.99, 50),
    (3, 'Смартфон', 'Современный смартфон с большим экраном', 29999.99, 30),
    (4, 'Книга: Война и мир', 'Роман Льва Толстого', 499.99, 20),
    (5, 'Хлеб', 'Свежий хлеб из пекарни', 49.99, 200);

INSERT INTO carts (user_id)
VALUES
    (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

INSERT INTO cart_items (cart_id, product_id, quantity)
VALUES
    (1, 1, 3),
    (1, 2, 1),
    (2, 3, 1),
    (3, 4, 2),
    (4, 5, 5),
    (5, 1, 2),
    (6, 3, 1),
    (7, 2, 2),
    (8, 4, 1),
    (9, 5, 3);

INSERT INTO orders (user_id, total_price, status)
VALUES
    (1, 799.98, 'completed'),
    (2, 29999.99, 'pending'),
    (3, 999.98, 'shipped'),
    (4, 249.95, 'pending'),
    (5, 399.98, 'completed');

INSERT INTO order_items (order_id, product_id, quantity, price)
VALUES
    (1, 1, 4, 199.99),
    (1, 2, 1, 599.99),
    (2, 3, 1, 29999.99),
    (3, 4, 2, 499.99),
    (4, 5, 5, 49.99),
    (5, 1, 2, 199.99);

INSERT INTO reviews (user_id, product_id, rating, comment)
VALUES
    (1, 1, 5, 'Очень хорошие носки, рекомендую!'),
    (2, 3, 4, 'Смартфон отличный, но дороговат'),
    (3, 4, 5, 'Любимая книга, качество издания на высоте!');

INSERT INTO payments (order_id, payment_method, amount)
VALUES
    (1, 'credit_card', 799.98),
    (2, 'paypal', 29999.99),
    (3, 'credit_card', 999.98);
