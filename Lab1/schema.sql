
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS manufacturers CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS customers CASCADE;

CREATE TABLE customers (
    customer_id   SERIAL       PRIMARY KEY,
    email         VARCHAR(255) NOT NULL UNIQUE,
    full_name     VARCHAR(200) NOT NULL,
    phone         VARCHAR(30),
    created_at    TIMESTAMP    NOT NULL DEFAULT NOW(),
    CONSTRAINT chk_customers_email CHECK (email ~* '^[^@\s]+@[^@\s]+\.[^@\s]+$')
);

CREATE TABLE categories (
    category_id  SERIAL       PRIMARY KEY,
    name         VARCHAR(100) NOT NULL UNIQUE,
    description  TEXT
);

CREATE TABLE manufacturers (
    manufacturer_id SERIAL       PRIMARY KEY,
    name            VARCHAR(150) NOT NULL UNIQUE,
    country         VARCHAR(80)  NOT NULL
);

CREATE TABLE products (
    product_id      SERIAL        PRIMARY KEY,
    name            VARCHAR(200)  NOT NULL,
    category_id     INT           NOT NULL REFERENCES categories(category_id)
                                  ON DELETE RESTRICT,
    manufacturer_id INT           NOT NULL REFERENCES manufacturers(manufacturer_id)
                                  ON DELETE RESTRICT,
    price           NUMERIC(12,2) NOT NULL,
    stock_qty       INT           NOT NULL DEFAULT 0,
    sku             VARCHAR(50)   NOT NULL UNIQUE,
    CONSTRAINT chk_products_price     CHECK (price > 0),
    CONSTRAINT chk_products_stock     CHECK (stock_qty >= 0),
    CONSTRAINT uq_products_name_manuf UNIQUE (name, manufacturer_id)
);

CREATE TABLE orders (
    order_id         SERIAL        PRIMARY KEY,
    customer_id      INT           NOT NULL REFERENCES customers(customer_id)
                                   ON DELETE RESTRICT,
    status           VARCHAR(20)   NOT NULL DEFAULT 'new',
    delivery_address VARCHAR(300)  NOT NULL,
    created_at       TIMESTAMP     NOT NULL DEFAULT NOW(),
    total_amount     NUMERIC(12,2) NOT NULL DEFAULT 0,
    CONSTRAINT chk_orders_status CHECK
        (status IN ('new','paid','shipped','delivered','cancelled')),
    CONSTRAINT chk_orders_total  CHECK (total_amount >= 0)
);

CREATE TABLE order_items (
    order_id    INT           NOT NULL REFERENCES orders(order_id)
                              ON DELETE CASCADE,
    product_id  INT           NOT NULL REFERENCES products(product_id)
                              ON DELETE RESTRICT,
    quantity    INT           NOT NULL,
    unit_price  NUMERIC(12,2) NOT NULL,
    PRIMARY KEY (order_id, product_id),
    CONSTRAINT chk_items_qty   CHECK (quantity > 0),
    CONSTRAINT chk_items_price CHECK (unit_price > 0)
);