use ss06;

ALTER Table Orders
ADD COLUMN totalAmount decimal(10,2);

UPDATE Orders
SET totalAmount = CASE orderId
    WHEN 101 THEN 5
    WHEN 102 THEN  10
    WHEN 103 THEN 15
    WHEN 104 THEN  20
    WHEN 105 THEN  25
END;

SELECT c.fullName, sum(o.totalAmount) AS customerAmount
FROM Orders o
JOIN Customers c ON c.customerId = o.customerId
GROUP BY c.fullName;

SELECT c.fullName, max(o.totalAmount) AS maxOrder
FROM Orders o
JOIN Customers c ON c.customerId = o.customerId
GROUP BY c.fullName;

SELECT c.fullName, sum(o.totalAmount) AS customerAmount
FROM Orders o
JOIN Customers c ON c.customerId = o.customerId
GROUP BY c.fullName
ORDER BY customerAmount DESC;
