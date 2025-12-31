use ss05;

ALTER Table product
ADD COLUMN soldQuantity int;

UPDATE product SET soldQuantity = 15 WHERE productId = 1;
UPDATE product SET soldQuantity = 40 WHERE productId = 2;
UPDATE product SET soldQuantity = 20 WHERE productId = 3;
UPDATE product SET soldQuantity = 35 WHERE productId = 4;
UPDATE product SET soldQuantity = 8  WHERE productId = 5;
UPDATE product SET soldQuantity = 60 WHERE productId = 6;
UPDATE product SET soldQuantity = 25 WHERE productId = 7;
UPDATE product SET soldQuantity = 12 WHERE productId = 8;
UPDATE product SET soldQuantity = 30 WHERE productId = 9;
UPDATE product SET soldQuantity = 5  WHERE productId = 10;

SELECT * FROM product
ORDER BY soldQuantity DESC
LIMIT 10;

SELECT * FROM product
ORDER BY soldQuantity DESC
LIMIT 5 OFFSET 10;

SELECT * FROM product WHERE price < 2000000
ORDER BY soldQuantity DESC;
