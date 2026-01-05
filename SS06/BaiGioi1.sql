use ss06;

SELECT orderDate, sum(totalAmount)
FROM Orders
GROUP BY orderDate;

SELECT orderDate, count(orderId)
FROM Orders
GROUP BY orderDate;

SELECT orderDate, sum(totalAmount) as totalDate
FROM Orders
GROUP BY orderDate
HAVING totalDate > 15;