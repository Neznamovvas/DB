
INSERT INTO customers (email, full_name)
VALUES ('ivanov@mail.ru', 'Другой Иван');

INSERT INTO orders (customer_id, status, delivery_address)
VALUES (1, 'unknown_status', 'Адрес');

INSERT INTO products (name, category_id, manufacturer_id, price, stock_qty, sku)
VALUES ('Бесплатный товар', 1, 1, 0, 5, 'FREE-001');

INSERT INTO products (name, category_id, manufacturer_id, price, stock_qty, sku)
VALUES ('MacBook Air M3', 1, 1, 100000, 1, 'APP-MBA-DUP');

INSERT INTO orders (customer_id, status, delivery_address)
VALUES (9999, 'new', 'Неизвестный адрес');

INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES (1, 2, 0, 89990.00);

INSERT INTO order_items (order_id, product_id, quantity, unit_price)
VALUES (1, 1, 2, 129990.00);

INSERT INTO customers (email, full_name)
VALUES ('x@y.ru', NULL);

DELETE FROM customers WHERE customer_id = 1;

INSERT INTO customers (email, full_name)
VALUES ('not-an-email', 'Безымянный');