INSERT INTO customers (email, full_name, phone) VALUES
('ivanov@mail.ru',     'Иван Иванов',    '+79001112233'),
('petrova@yandex.ru',  'Анна Петрова',   '+79002223344'),
('sidorov@gmail.com',  'Пётр Сидоров',   '+79003334455'),
('kuznetsova@mail.ru', 'Мария Кузнецова','+79004445566'),
('smirnov@bk.ru',      'Олег Смирнов',   NULL);

INSERT INTO categories (name, description) VALUES
('Ноутбуки',        'Портативные компьютеры'),
('Смартфоны',       'Мобильные телефоны'),
('Аксессуары',      'Кабели, чехлы, зарядки'),
('Периферия',       'Мыши, клавиатуры, мониторы');

INSERT INTO manufacturers (name, country) VALUES
('Apple',   'США'),
('Samsung', 'Южная Корея'),
('Lenovo',  'Китай'),
('Logitech','Швейцария');

INSERT INTO products (name, category_id, manufacturer_id, price, stock_qty, sku) VALUES
('MacBook Air M3',        1, 1, 129990.00, 10, 'APP-MBA-M3'),
('Samsung Galaxy S24',    2, 2,  89990.00, 25, 'SAM-S24'),
('Lenovo ThinkPad X1',    1, 3, 149990.00,  5, 'LEN-X1'),
('Logitech MX Master 3',  4, 4,   9990.00, 40, 'LOG-MX3'),
('Logitech K380',         4, 4,   3490.00, 60, 'LOG-K380'),
('USB-C Cable 2m',        3, 2,    990.00,100, 'SAM-USBC-2M');

INSERT INTO orders (customer_id, status, delivery_address, total_amount) VALUES
(1, 'delivered', 'Москва, ул. Ленина, 1',     139980.00),
(2, 'paid',      'СПб, Невский пр., 10',       89990.00),
(3, 'new',       'Казань, ул. Баумана, 5',     3490.00),
(1, 'shipped',   'Москва, ул. Ленина, 1',      9990.00),
(4, 'cancelled', 'Новосибирск, ул. Мира, 3',   1980.00);

INSERT INTO order_items (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 129990.00),
(1, 4, 1,   9990.00),
(2, 2, 1,  89990.00),
(3, 5, 1,   3490.00),
(4, 4, 1,   9990.00),
(5, 6, 2,    990.00);