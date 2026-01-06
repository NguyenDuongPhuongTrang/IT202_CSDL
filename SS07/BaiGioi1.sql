use ss07;

SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM orderitems;
SELECT * FROM products;

UPDATE orders o
SET totalAmount = IFNULL((
    SELECT SUM(oi.quantity * p.price)
    FROM orderItems oi, products p
    WHERE oi.productId = p.productId
      AND oi.orderId = o.orderId
), 0);

SELECT * FROM orders
WHERE totalAmount > (SELECT avg(totalAmount) FROM orders);
