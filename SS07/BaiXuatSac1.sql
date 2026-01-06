use ss07;

SELECT * FROM customers;
SELECT * FROM orders;
SELECT * FROM orderitems;
SELECT * FROM products;

SELECT *
FROM customers c
WHERE c.customerId IN (
    SELECT o.customerId
    FROM orders o
    GROUP BY o.customerId
    HAVING sum(totalAmount) = (
        SELECT max(totalSum)
        FROM (
            SELECT sum(o1.totalAmount) AS totalSum
            FROM orders o1
            GROUP BY o1.customerId
        ) AS total
    )
);
