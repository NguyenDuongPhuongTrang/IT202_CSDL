use ss06;

-- Tính trung bình theo từng dòng sản phẩm. Trung bình mỗi sản phẩm trong đơn hàng đó là bao nhiêu tiền
SELECT 
	p.productName, 
    sum(oi.quantity) TotalQuantity,
    sum(oi.quantity * p.price) as TotalAmount,
    sum(oi.quantity * p.price) / sum(oi.quantity) as AvgPrice
FROM OrderItems oi
JOIN Products p ON p.productId = oi.productId
GROUP BY p.productName
HAVING TotalQuantity >= 1
ORDER BY TotalAmount DESC
LIMIT 3;










