use ss06;

-- Tính trung bình theo từng dòng sản phẩm. Trung bình mỗi sản phẩm trong đơn hàng đó là bao nhiêu tiền
SELECT 
    c.fullName, 
    o.orderId, 
    COUNT(oi.productId) AS TotalItems,
    SUM(oi.quantity * p.price) AS TotalAmount,
    SUM(oi.quantity * p.price) / COUNT(oi.productId) AS AvgOrderAmount
FROM Customers c
JOIN Orders o ON o.customerId = c.customerId
JOIN OrderItems oi ON oi.orderId = o.orderId
JOIN Products p ON p.productId = oi.productId
WHERE o.status <> 'cancelled'
GROUP BY c.fullName, o.orderId
HAVING TotalAmount > 20
ORDER BY TotalAmount DESC;










