USE Demo
--SELECT CustomerID, FirstName, LastName, REPLACE(PaymentNumber,RIGHT(PaymentNumber,10),REPLICATE('*',10)) FROM Customers

SELECT CustomerID, FirstName, LastName, LEFT(PaymentNumber,6) + REPLICATE('*' ,LEN(PaymentNumber)-6) FROM Customers