use ss05;

SELECT * FROM orders WHERE status <> 'cancelled'
ORDER BY orderDate DESC
LIMIT 5 OFFSET 0;

SELECT * FROM orders WHERE status <> 'cancelled'
ORDER BY orderDate DESC
LIMIT 5 OFFSET 5;

SELECT * FROM orders WHERE status <> 'cancelled'
ORDER BY orderDate DESC
LIMIT 5 OFFSET 10;