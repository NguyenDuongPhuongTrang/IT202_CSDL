use ss05;

SELECT * FROM product 
WHERE status = 'active' and price between 1000000 and 3000000
ORDER BY price ASC
LIMIT 10 OFFSET 0;

SELECT * FROM product 
WHERE status = 'active' and price between 1000000 and 3000000
ORDER BY price ASC
LIMIT 10 OFFSET 10;
