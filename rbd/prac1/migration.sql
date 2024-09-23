CREATE TABLE users (
                       user_id SERIAL PRIMARY KEY,
                       username VARCHAR(100) NOT NULL UNIQUE,
                       email VARCHAR(100) NOT NULL UNIQUE,
                       password_hash VARCHAR(255) NOT NULL,
                       first_name VARCHAR(50),
                       last_name VARCHAR(50),
                       phone_number VARCHAR(20),
                       address TEXT,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE categories (
                            category_id SERIAL PRIMARY KEY,
                            category_name VARCHAR(100) NOT NULL,
                            description TEXT
);

CREATE TABLE products (
                          product_id SERIAL PRIMARY KEY,
                          category_id INT REFERENCES categories(category_id) ON DELETE SET NULL,
                          product_name VARCHAR(255) NOT NULL,
                          description TEXT,
                          price NUMERIC(10, 2) NOT NULL,
                          stock_quantity INT NOT NULL,
                          created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE carts (
                       cart_id SERIAL PRIMARY KEY,
                       user_id INT REFERENCES users(user_id) ON DELETE CASCADE,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE cart_items (
                            cart_item_id SERIAL PRIMARY KEY,
                            cart_id INT REFERENCES carts(cart_id) ON DELETE CASCADE,
                            product_id INT REFERENCES products(product_id) ON DELETE CASCADE,
                            quantity INT NOT NULL
);

CREATE TABLE orders (
                        order_id SERIAL PRIMARY KEY,
                        user_id INT REFERENCES users(user_id) ON DELETE CASCADE,
                        total_price NUMERIC(10, 2) NOT NULL,
                        status VARCHAR(50) DEFAULT 'pending',
                        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE order_items (
                             order_item_id SERIAL PRIMARY KEY,
                             order_id INT REFERENCES orders(order_id) ON DELETE CASCADE,
                             product_id INT REFERENCES products(product_id) ON DELETE CASCADE,
                             quantity INT NOT NULL,
                             price NUMERIC(10, 2) NOT NULL
);

CREATE TABLE reviews (
                         review_id SERIAL PRIMARY KEY,
                         user_id INT REFERENCES users(user_id) ON DELETE CASCADE,
                         product_id INT REFERENCES products(product_id) ON DELETE CASCADE,
                         rating INT CHECK (rating BETWEEN 1 AND 5),
                         comment TEXT,
                         created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE payments (
                          payment_id SERIAL PRIMARY KEY,
                          order_id INT REFERENCES orders(order_id) ON DELETE CASCADE,
                          payment_method VARCHAR(50) NOT NULL,
                          payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                          amount NUMERIC(10, 2) NOT NULL
);

CREATE TABLE companies (
                           company_id SERIAL PRIMARY KEY,
                           company_name VARCHAR(255) NOT NULL,
                           company_description TEXT,
                           created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE products
    ADD COLUMN company_id INT REFERENCES companies(company_id) ON DELETE SET NULL;

CREATE TABLE replies (
                         reply_id SERIAL PRIMARY KEY,
                         review_id INT REFERENCES reviews(review_id) ON DELETE CASCADE,
                         company_id INT REFERENCES companies(company_id) ON DELETE CASCADE,
                         reply_text TEXT NOT NULL,
                         replied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);