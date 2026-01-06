use ss07;

SELECT 
    c.customerName,
    (	SELECT COUNT(*)
		FROM orders o
        WHERE o.customerId = c.customerId) AS totalOrders
FROM customers c;
