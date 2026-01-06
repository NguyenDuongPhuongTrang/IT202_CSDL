use ss07;

SELECT *
FROM customers c
WHERE c.customerId IN (
    SELECT o.customerId
    FROM orders o
    GROUP BY o.customerId
    HAVING sum(o.totalAmount) > (
        SELECT avg(total)
        FROM (
            SELECT sum(o1.totalAmount) AS total
            FROM orders o1
            GROUP BY o1.customerId
        ) AS temp
    )
);
