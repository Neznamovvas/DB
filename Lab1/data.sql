BEGIN;

TRUNCATE order_items, orders, products, manufacturers, categories, customers
    RESTART IDENTITY CASCADE;

INSERT INTO categories (name, description) VALUES
('Ноутбуки',   'Портативные компьютеры'),
('Смартфоны',  'Мобильные телефоны'),
('Аксессуары', 'Кабели, чехлы, зарядки'),
('Периферия',  'Мыши, клавиатуры, мониторы');

INSERT INTO manufacturers (name, country) VALUES
('Apple',    'США'),
('Samsung',  'Южная Корея'),
('Lenovo',   'Китай'),
('Logitech', 'Швейцария');

INSERT INTO products (name, category_id, manufacturer_id, price, stock_qty, sku) VALUES
('MacBook Air M3',        (SELECT category_id FROM categories WHERE name='Ноутбуки'),
                          (SELECT manufacturer_id FROM manufacturers WHERE name='Apple'),
                          129990.00, 10, 'APP-MBA-M3'),
('Samsung Galaxy S24',    (SELECT category_id FROM categories WHERE name='Смартфоны'),
                          (SELECT manufacturer_id FROM manufacturers WHERE name='Samsung'),
                           89990.00, 25, 'SAM-S24'),
('Lenovo ThinkPad X1',    (SELECT category_id FROM categories WHERE name='Ноутбуки'),
                          (SELECT manufacturer_id FROM manufacturers WHERE name='Lenovo'),
                          149990.00,  5, 'LEN-X1'),
('Logitech MX Master 3',  (SELECT category_id FROM categories WHERE name='Периферия'),
                          (SELECT manufacturer_id FROM manufacturers WHERE name='Logitech'),
                            9990.00, 40, 'LOG-MX3'),
('Logitech K380',         (SELECT category_id FROM categories WHERE name='Периферия'),
                          (SELECT manufacturer_id FROM manufacturers WHERE name='Logitech'),
                            3490.00, 60, 'LOG-K380'),
('USB-C Cable 2m',        (SELECT category_id FROM categories WHERE name='Аксессуары'),
                          (SELECT manufacturer_id FROM manufacturers WHERE name='Samsung'),
                             990.00,100, 'SAM-USBC-2M'),
('iPhone 15',             (SELECT category_id FROM categories WHERE name='Смартфоны'),
                          (SELECT manufacturer_id FROM manufacturers WHERE name='Apple'),
                           99990.00, 15, 'APP-IP15'),
('iPad Pro 11',           (SELECT category_id FROM categories WHERE name='Ноутбуки'),
                          (SELECT manufacturer_id FROM manufacturers WHERE name='Apple'),
                          109990.00,  7, 'APP-IPAD11'),
('Galaxy Tab S9',         (SELECT category_id FROM categories WHERE name='Ноутбуки'),
                          (SELECT manufacturer_id FROM manufacturers WHERE name='Samsung'),
                           79990.00, 12, 'SAM-TABS9'),
('Xiaomi 14',             (SELECT category_id FROM categories WHERE name='Смартфоны'),
                          (SELECT manufacturer_id FROM manufacturers WHERE name='Samsung'),
                           59990.00, 30, 'SAM-XIA14'),
('ThinkPad T14',          (SELECT category_id FROM categories WHERE name='Ноутбуки'),
                          (SELECT manufacturer_id FROM manufacturers WHERE name='Lenovo'),
                          119990.00,  8, 'LEN-T14'),
('IdeaPad 5',             (SELECT category_id FROM categories WHERE name='Ноутбуки'),
                          (SELECT manufacturer_id FROM manufacturers WHERE name='Lenovo'),
                           54990.00, 20, 'LEN-IP5'),
('MX Keys',               (SELECT category_id FROM categories WHERE name='Периферия'),
                          (SELECT manufacturer_id FROM manufacturers WHERE name='Logitech'),
                            8990.00, 35, 'LOG-MXK'),
('C920 Webcam',           (SELECT category_id FROM categories WHERE name='Периферия'),
                          (SELECT manufacturer_id FROM manufacturers WHERE name='Logitech'),
                            7490.00, 25, 'LOG-C920'),
('USB Hub 4-port',        (SELECT category_id FROM categories WHERE name='Аксессуары'),
                          (SELECT manufacturer_id FROM manufacturers WHERE name='Lenovo'),
                            1990.00, 80, 'LEN-HUB4'),
('Lightning Cable 1m',    (SELECT category_id FROM categories WHERE name='Аксессуары'),
                          (SELECT manufacturer_id FROM manufacturers WHERE name='Apple'),
                            1490.00, 90, 'APP-LT1M'),
('Wireless Charger',      (SELECT category_id FROM categories WHERE name='Аксессуары'),
                          (SELECT manufacturer_id FROM manufacturers WHERE name='Samsung'),
                            2990.00, 45, 'SAM-WCH'),
('Monitor 27 4K',         (SELECT category_id FROM categories WHERE name='Периферия'),
                          (SELECT manufacturer_id FROM manufacturers WHERE name='Lenovo'),
                           39990.00,  6, 'LEN-MON27'),
('Mechanical Keyboard',   (SELECT category_id FROM categories WHERE name='Периферия'),
                          (SELECT manufacturer_id FROM manufacturers WHERE name='Logitech'),
                           12990.00, 18, 'LOG-MK'),
('Power Bank 20000',      (SELECT category_id FROM categories WHERE name='Аксессуары'),
                          (SELECT manufacturer_id FROM manufacturers WHERE name='Samsung'),
                            3490.00, 50, 'SAM-PB20');

INSERT INTO customers (email, full_name, phone) VALUES
('ivanov@mail.ru',       'Иван Иванов',        '+79001112233'),
('petrova@yandex.ru',    'Анна Петрова',       '+79002223344'),
('sidorov@gmail.com',    'Пётр Сидоров',       '+79003334455'),
('kuznetsova@mail.ru',   'Мария Кузнецова',    '+79004445566'),
('smirnov@bk.ru',        'Олег Смирнов',       NULL),
('a.volkov@mail.ru',     'Алексей Волков',     '+79011110001'),
('b.morozova@yandex.ru', 'Белла Морозова',     '+79011110002'),
('v.lebedev@gmail.com',  'Виктор Лебедев',     '+79011110003'),
('g.orlova@mail.ru',     'Галина Орлова',      '+79011110004'),
('d.kozlov@bk.ru',       'Дмитрий Козлов',     NULL),
('e.novikova@mail.ru',   'Елена Новикова',     '+79011110006'),
('zh.chernyh@yandex.ru', 'Жанна Чёрных',       '+79011110007'),
('z.romanov@gmail.com',  'Захар Романов',      '+79011110008'),
('i.belova@mail.ru',     'Ирина Белова',       NULL),
('k.titov@bk.ru',        'Кирилл Титов',       '+79011110010'),
('l.egorova@mail.ru',    'Лариса Егорова',     '+79011110011'),
('m.bykov@yandex.ru',    'Максим Быков',       '+79011110012'),
('n.zaytseva@gmail.com', 'Нина Зайцева',       '+79011110013'),
('o.pavlov@mail.ru',     'Олег Павлов',        NULL),
('p.sokolova@bk.ru',     'Полина Соколова',    '+79011110015'),
('r.fedorov@mail.ru',    'Роман Фёдоров',      '+79011110016'),
('s.antonova@yandex.ru', 'Светлана Антонова',  '+79011110017'),
('t.mironov@gmail.com',  'Тимур Миронов',      '+79011110018'),
('u.karpova@mail.ru',    'Ульяна Карпова',     '+79011110019'),
('f.gusev@bk.ru',        'Фёдор Гусев',        NULL);

-- ---------------------------------------------------------
-- 5. Заказы (37) — 3 месяца, 5 статусов, нулевой заказ
--    customer_id берём подзапросами по email.
--    created_at — явные даты в 2026-01..2026-03.
-- ---------------------------------------------------------
INSERT INTO orders (customer_id, status, delivery_address, created_at, total_amount) VALUES
-- январь
((SELECT customer_id FROM customers WHERE email='ivanov@mail.ru'),      'delivered','Москва, ул. Ленина, 1',       '2026-01-05 10:00', 139980.00),
((SELECT customer_id FROM customers WHERE email='petrova@yandex.ru'),   'delivered','СПб, Невский пр., 10',        '2026-01-07 12:30',  89990.00),
((SELECT customer_id FROM customers WHERE email='sidorov@gmail.com'),   'delivered','Казань, ул. Баумана, 5',      '2026-01-10 09:15',   3490.00),
((SELECT customer_id FROM customers WHERE email='kuznetsova@mail.ru'),  'delivered','Екатеринбург, ул. Мира, 8',   '2026-01-12 15:40',  99990.00),
((SELECT customer_id FROM customers WHERE email='smirnov@bk.ru'),       'cancelled','Новосибирск, ул. Кирова, 2',  '2026-01-15 11:00',   1980.00),
((SELECT customer_id FROM customers WHERE email='a.volkov@mail.ru'),    'delivered','Москва, ул. Тверская, 20',    '2026-01-18 14:20', 129980.00),
((SELECT customer_id FROM customers WHERE email='b.morozova@yandex.ru'),'delivered','СПб, Лиговский пр., 50',      '2026-01-20 16:10',  79990.00),
((SELECT customer_id FROM customers WHERE email='v.lebedev@gmail.com'), 'delivered','Москва, ул. Арбат, 12',       '2026-01-22 10:45', 109990.00),
((SELECT customer_id FROM customers WHERE email='g.orlova@mail.ru'),    'delivered','Казань, ул. Пушкина, 3',      '2026-01-25 13:00',   8990.00),
((SELECT customer_id FROM customers WHERE email='d.kozlov@bk.ru'),      'delivered','Самара, ул. Гагарина, 7',     '2026-01-28 17:30',   7490.00),
-- февраль
((SELECT customer_id FROM customers WHERE email='ivanov@mail.ru'),      'delivered','Москва, ул. Ленина, 1',       '2026-02-02 09:00',  59990.00),
((SELECT customer_id FROM customers WHERE email='petrova@yandex.ru'),   'delivered','СПб, Невский пр., 10',        '2026-02-05 11:20', 119990.00),
((SELECT customer_id FROM customers WHERE email='sidorov@gmail.com'),   'cancelled','Казань, ул. Баумана, 5',      '2026-02-08 14:00',   2990.00),
((SELECT customer_id FROM customers WHERE email='kuznetsova@mail.ru'),  'delivered','Екатеринбург, ул. Мира, 8',   '2026-02-10 10:30',  54990.00),
((SELECT customer_id FROM customers WHERE email='smirnov@bk.ru'),       'delivered','Новосибирск, ул. Кирова, 2',  '2026-02-12 12:45',   8990.00),
((SELECT customer_id FROM customers WHERE email='a.volkov@mail.ru'),    'delivered','Москва, ул. Тверская, 20',    '2026-02-15 15:15',  39990.00),
((SELECT customer_id FROM customers WHERE email='b.morozova@yandex.ru'),'shipped',  'СПб, Лиговский пр., 50',      '2026-02-18 09:40',  12990.00),
((SELECT customer_id FROM customers WHERE email='v.lebedev@gmail.com'), 'shipped',  'Москва, ул. Арбат, 12',       '2026-02-20 13:25',   3490.00),
((SELECT customer_id FROM customers WHERE email='g.orlova@mail.ru'),    'delivered','Казань, ул. Пушкина, 3',      '2026-02-22 16:50', 109990.00),
((SELECT customer_id FROM customers WHERE email='d.kozlov@bk.ru'),      'delivered','Самара, ул. Гагарина, 7',     '2026-02-25 11:10',   1990.00),
((SELECT customer_id FROM customers WHERE email='e.novikova@mail.ru'),  'delivered','Уфа, ул. Ленина, 15',         '2026-02-27 14:35',   8990.00),
((SELECT customer_id FROM customers WHERE email='zh.chernyh@yandex.ru'),'delivered','Пермь, ул. Мира, 4',          '2026-02-28 10:05',   7490.00),
-- март
((SELECT customer_id FROM customers WHERE email='z.romanov@gmail.com'), 'delivered','Воронеж, ул. Кольцовская, 9','2026-03-02 09:30',  99990.00),
((SELECT customer_id FROM customers WHERE email='i.belova@mail.ru'),    'delivered','Ростов-на-Дону, ул. Садовая, 6','2026-03-05 12:00',54990.00),
((SELECT customer_id FROM customers WHERE email='k.titov@bk.ru'),       'delivered','Краснодар, ул. Красная, 18', '2026-03-07 15:20',  12990.00),
((SELECT customer_id FROM customers WHERE email='l.egorova@mail.ru'),   'shipped',  'Москва, ул. Новый Арбат, 3', '2026-03-10 10:15',  39990.00),
((SELECT customer_id FROM customers WHERE email='m.bykov@yandex.ru'),   'shipped',  'СПб, Московский пр., 22',    '2026-03-12 13:45',   3490.00),
((SELECT customer_id FROM customers WHERE email='ivanov@mail.ru'),      'paid',     'Москва, ул. Ленина, 1',       '2026-03-15 11:30',  99990.00),
((SELECT customer_id FROM customers WHERE email='petrova@yandex.ru'),   'paid',     'СПб, Невский пр., 10',        '2026-03-18 14:00',  79990.00),
((SELECT customer_id FROM customers WHERE email='sidorov@gmail.com'),   'new',      'Казань, ул. Баумана, 5',      '2026-03-20 16:20',   8990.00),
((SELECT customer_id FROM customers WHERE email='kuznetsova@mail.ru'),  'new',      'Екатеринбург, ул. Мира, 8',   '2026-03-22 09:50',  12990.00),
((SELECT customer_id FROM customers WHERE email='smirnov@bk.ru'),       'new',      'Новосибирск, ул. Кирова, 2',  '2026-03-25 12:10',   3490.00),
((SELECT customer_id FROM customers WHERE email='a.volkov@mail.ru'),    'cancelled','Москва, ул. Тверская, 20',    '2026-03-27 15:40',   1990.00),
((SELECT customer_id FROM customers WHERE email='b.morozova@yandex.ru'),'new',      'СПб, Лиговский пр., 50',      '2026-03-28 10:00',   7490.00),
((SELECT customer_id FROM customers WHERE email='v.lebedev@gmail.com'), 'new',      'Москва, ул. Арбат, 12',       '2026-03-29 11:25', 109990.00),
((SELECT customer_id FROM customers WHERE email='g.orlova@mail.ru'),    'new',      'Казань, ул. Пушкина, 3',      '2026-03-30 13:55',  59990.00),
((SELECT customer_id FROM customers WHERE email='d.kozlov@bk.ru'),      'new',      'Самара, ул. Гагарина, 7',     '2026-03-31 16:30',   8990.00),
-- нулевой заказ (пограничное значение)
((SELECT customer_id FROM customers WHERE email='n.zaytseva@gmail.com'),'new',     'Тюмень, ул. Республики, 1',   '2026-03-31 17:00',      0.00);

-- ---------------------------------------------------------
-- 6. Позиции заказов (37)
--    order_id и product_id — через подзапросы по естественным ключам.
-- ---------------------------------------------------------
INSERT INTO order_items (order_id, product_id, quantity, unit_price)
SELECT o.order_id, p.product_id, v.qty, v.price
FROM (VALUES
    ('2026-01-05 10:00', 'MacBook Air M3',       1, 129990.00),
    ('2026-01-05 10:00', 'Logitech MX Master 3', 1,   9990.00),
    ('2026-01-07 12:30', 'Samsung Galaxy S24',   1,  89990.00),
    ('2026-01-10 09:15', 'Logitech K380',        1,   3490.00),
    ('2026-01-12 15:40', 'iPhone 15',            1,  99990.00),
    ('2026-01-15 11:00', 'USB-C Cable 2m',       2,    990.00),
    ('2026-01-18 14:20', 'MacBook Air M3',       1, 129990.00),
    ('2026-01-20 16:10', 'Lenovo ThinkPad X1',   1,  79990.00),
    ('2026-01-22 10:45', 'iPad Pro 11',          1, 109990.00),
    ('2026-01-25 13:00', 'MX Keys',              1,   8990.00),
    ('2026-01-28 17:30', 'C920 Webcam',          1,   7490.00),
    ('2026-02-02 09:00', 'Xiaomi 14',            1,  59990.00),
    ('2026-02-05 11:20', 'ThinkPad T14',         1, 119990.00),
    ('2026-02-08 14:00', 'Wireless Charger',     1,   2990.00),
    ('2026-02-10 10:30', 'IdeaPad 5',            1,  54990.00),
    ('2026-02-12 12:45', 'MX Keys',              1,   8990.00),
    ('2026-02-15 15:15', 'Monitor 27 4K',        1,  39990.00),
    ('2026-02-18 09:40', 'Mechanical Keyboard',  1,  12990.00),
    ('2026-02-20 13:25', 'Power Bank 20000',     1,   3490.00),
    ('2026-02-22 16:50', 'iPad Pro 11',          1, 109990.00),
    ('2026-02-25 11:10', 'USB Hub 4-port',       1,   1990.00),
    ('2026-02-27 14:35', 'MX Keys',              1,   8990.00),
    ('2026-02-28 10:05', 'C920 Webcam',          1,   7490.00),
    ('2026-03-02 09:30', 'iPhone 15',            1,  99990.00),
    ('2026-03-05 12:00', 'IdeaPad 5',            1,  54990.00),
    ('2026-03-07 15:20', 'Mechanical Keyboard',  1,  12990.00),
    ('2026-03-10 10:15', 'Monitor 27 4K',        1,  39990.00),
    ('2026-03-12 13:45', 'Logitech K380',        1,   3490.00),
    ('2026-03-15 11:30', 'iPhone 15',            1,  99990.00),
    ('2026-03-18 14:00', 'Galaxy Tab S9',        1,  79990.00),
    ('2026-03-20 16:20', 'MX Keys',              1,   8990.00),
    ('2026-03-22 09:50', 'Mechanical Keyboard',  1,  12990.00),
    ('2026-03-25 12:10', 'Power Bank 20000',     1,   3490.00),
    ('2026-03-27 15:40', 'USB Hub 4-port',       1,   1990.00),
    ('2026-03-28 10:00', 'C920 Webcam',          1,   7490.00),
    ('2026-03-29 11:25', 'iPad Pro 11',          1, 109990.00),
    ('2026-03-30 13:55', 'Xiaomi 14',            1,  59990.00),
    ('2026-03-31 16:30', 'MX Keys',              1,   8990.00)
) AS v(order_created_at, product_name, qty, price)
JOIN orders   o ON o.created_at = v.order_created_at::timestamp
JOIN products p ON p.name       = v.product_name;

COMMIT;