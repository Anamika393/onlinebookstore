-- 1) Total number of books sold per genre:
SELECT b.Genre, SUM(o.Quantity) AS Total_Books_Sold
FROM Orders o JOIN Books b ON b.Book_ID = o.Book_ID
GROUP BY b.Genre;

-- 2) Average price of Fantasy books:
SELECT AVG(Price) AS Average_Price FROM Books WHERE Genre = 'Fantasy';

-- 3) Customers with at least 2 orders:
SELECT C.Customer_ID, COUNT(O.Order_ID) AS Order_Count
FROM Customers C JOIN Orders O ON O.Customer_ID = C.Customer_ID
GROUP BY C.Customer_ID
HAVING COUNT(O.Order_ID) >= 2;

-- 4) Most frequently ordered book:
SELECT o.Book_ID, b.Title, COUNT(o.Order_ID) AS Order_Count
FROM Orders o JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY o.Book_ID, b.Title
ORDER BY Order_Count DESC LIMIT 1;

-- 5) Top 3 most expensive books in Fantasy genre:
SELECT Book_ID, Title, Price FROM Books WHERE Genre = 'Fantasy'
ORDER BY Price DESC LIMIT 3;

-- 6) Total quantity sold by author:
SELECT b.Author, SUM(o.Quantity) AS Total_Books_Sold
FROM Orders o JOIN Books b ON o.Book_ID = b.Book_ID
GROUP BY b.Author
ORDER BY Total_Books_Sold DESC;

-- 7) Cities of customers spending over $30:
SELECT DISTINCT c.City
FROM Orders o JOIN Customers c ON o.Customer_ID = c.Customer_ID
WHERE o.Total_Amount > 30;

-- 8) Top spending customer:
SELECT c.Customer_ID, c.Cname, SUM(o.Total_Amount) AS Total_Spent
FROM Orders o JOIN Customers c ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_ID, c.Cname
ORDER BY Total_Spent DESC LIMIT 1;

-- 9) Remaining stock after all orders:
SELECT b.Book_ID, b.Title, b.Stock,
       COALESCE(SUM(o.Quantity), 0) AS Order_Quantity,
       b.Stock - COALESCE(SUM(o.Quantity), 0) AS Remaining_Quantity
FROM Books b LEFT JOIN Orders o ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID
ORDER BY b.Book_ID;
