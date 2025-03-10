#	In this exercise I will be using data from https://www.linkedin.com/learning/mysql-for-non-programmers/keys-and-constraints?autoSkip=true&resume=false
# 	to analyze sales data in a relational database. 5 different tables are in this database that include characteristics for customer, salesperson, order, order item, and product traits. 
#	The products being sold are Mineral Waters of different flavors, in both 32oz and 20oz sizes.

Use Hplus;

##############################################################################################################################################
##############################################################################################################################################
##############################################################################################################################################
##############################################################################################################################################


#	Find for each product the price, quantity sold, and a calculation for total revenue. Include the names of the products.

#		Since there isn't a key provided for describing each variable, there is some uncertainty as to how Orders.TotalDue is to be interpreted. It appears to signify revenue, but price x quantity 
#		calculations do not return values equal to Orders.TotalDue. To handle this uncertainity, two different approaches are used. 
#			1. In the first one, Orders.TotalDue is assumed to be a revenue indicator of some sort, and price is calculated from it. 
#			2. Orders.TotalDue is omitted. We instead use OrderItem.Quantity and Product.Price

SELECT * FROM Orders                                                               # view the relevant tables and how they connect
INNER JOIN OrderItem ON OrderItem.OrderID = Orders.OrderID 
INNER JOIN Product ON Product.ProductID = OrderItem.ProductID;

#		Version 1
SELECT OrderItem.ProductID, Product.ProductName, Product.Variety, Product.Size, Sum(OrderItem.Quantity) AS "UnitsSold", 
ROUND( SUM(Orders.TotalDue) / SUM(OrderItem.Quantity) , 2) as "Price", ROUND(Sum(Orders.TotalDue), 2) AS "SalesRevenue"
FROM OrderItem
INNER JOIN Orders ON OrderItem.OrderID = Orders.OrderID
INNER JOIN Product ON OrderItem.ProductID = Product.ProductID
GROUP BY OrderItem.ProductID
ORDER BY ProductID ASC; 

#		Version 2
SELECT OrderItem.ProductID, Product.ProductName, Product.Variety, Product.size, Product.Price, Sum(OrderItem.Quantity) AS "UnitsSold",  ROUND( Sum(OrderItem.Quantity * Product.Price), 2) as "SalesRevenue"
FROM OrderItem
INNER JOIN Product ON OrderItem.ProductID = Product.ProductID
GROUP BY OrderItem.ProductID
ORDER BY SalesRevenue DESC;

#	In the end, I prefer Version 2, as the price variable used here looks more believable for the items (mineral waters) being sold. This format for revenue will therefore
#	be used in the subsequent analysis. 

#	Version 2 gives us a top-seller of 32oz Lemon Lime, which had 919 units sold at $3.69 and brought in $3391.11 in revenue. 
#	The number 1 seller in terms of quantity, however, was 20oz Orange, which sold 1312 units at $1.79. Revenue for this product was lower though at $2348.48. 

#	The worst performer in terms of both units sold and revenue was 20oz Cranberry, which only sold 391 units at $1.79 for $699.89. 

##############################################################################################################################################
##############################################################################################################################################
##############################################################################################################################################
##############################################################################################################################################


#	Find the top 10 customers by spending, and how much these customers are spending. Once you have that, provide a spending-breakdown of the top customer. 

SELECT Customer.CustomerID, Customer.FirstName, Customer.LastName, ROUND( Sum(OrderItem.Quantity * Product.Price), 2 ) as "CustomerSpending"
FROM Customer
INNER JOIN Orders ON Customer.CustomerID = Orders.CustomerID
INNER JOIN OrderItem ON Orders.OrderID = OrderItem.OrderID
INNER JOIN Product ON OrderItem.ProductID = Product.ProductID
GROUP BY Customer.CustomerID, Customer.FirstName, Customer.LastName
ORDER BY CustomerSpending DESC
LIMIT 10;                                                                 

Select Customer.CustomerID, Customer.FirstName, Customer.LastName, Product.ProductName, Product.Variety, Product.Size, OrderItem.Quantity, Product.Price, ROUND( OrderItem.Quantity * Product.Price, 2) AS "OrderAmount"
From Customer
INNER JOIN Orders ON Orders.CustomerID = Customer.CustomerID                                                                           
INNER JOIN OrderItem ON Orders.OrderID = OrderItem.OrderID
INNER JOIN Product ON OrderItem.ProductID = Product.ProductID
WHERE Customer.CustomerID = 660
ORDER BY OrderAmount DESC;


#		Our top spending customer is found to be Virginia Porter (660), who has spent a total of $638.29. Her most purchased drink flavor was 32oz Raspberry (45),
#		which as closely followed by 32oz Blueberry (44). These two are both $3.69, and garnered $166.05 and $162.36 in sales from her repectively. 


##############################################################################################################################################
##############################################################################################################################################
##############################################################################################################################################
##############################################################################################################################################

#		Now provide a geographical analysis of the customer base. 


SELECT Customer.City, Customer.State, ROUND( Sum(OrderItem.Quantity * Product.Price), 2 ) as "CustomerSpending"
FROM Customer
INNER JOIN Orders ON Customer.CustomerID = Orders.CustomerID
INNER JOIN OrderItem ON Orders.OrderID = OrderItem.OrderID
INNER JOIN Product ON OrderItem.ProductID = Product.ProductID
GROUP BY Customer.City, Customer.State
ORDER BY CustomerSpending DESC;

SELECT Customer.State, COUNT(DISTINCT Customer.City) AS CityCount, ROUND( Sum(OrderItem.Quantity * Product.Price), 2 ) as "CustomerSpending"
FROM Customer
INNER JOIN Orders ON Customer.CustomerID = Orders.CustomerID
INNER JOIN OrderItem ON Orders.OrderID = OrderItem.OrderID
INNER JOIN Product ON OrderItem.ProductID = Product.ProductID
GROUP BY Customer.State
ORDER BY CustomerSpending DESC;

#		Washington DC is the city that drives the most sales, and is 5th highest in state sales rankings 
#		Texas is the highest selling state, with 12 cities contributing $3970 in revenue together. 
#		The 4 following states in terms of sales are New York ($3279.44), Florida (3276.95), California ($3206.28), and Washington DC ($2031.29). 
#		Together, these 5 states comprise about 46% of total revenue. 


##############################################################################################################################################
##############################################################################################################################################
##############################################################################################################################################
##############################################################################################################################################

#	Find the top 10 best-selling sales representatives, and how much they are selling. Once you have that, provide a sales-breakdown of the top seller.

SELECT Salesperson.SalespersonID, Salesperson.FirstName, Salesperson.LastName, ROUND( Sum(OrderItem.Quantity * Product.Price), 2 ) as "TotalSales", 
COUNT(Orders.OrderID) AS "SalesMade", SUM(OrderItem.Quantity) AS "UnitsSold",
ROUND(SUM(OrderItem.Quantity * Product.Price) / SUM(OrderItem.Quantity), 2) AS "AveragePrice"
FROM Salesperson
INNER JOIN Orders ON Salesperson.SalespersonID = Orders.SalespersonID
INNER JOIN OrderItem ON Orders.OrderID = OrderItem.OrderID
INNER JOIN Product ON OrderItem.ProductID = Product.ProductID
GROUP BY Salesperson.SalespersonID, Salesperson.FirstName, Salesperson.LastName
ORDER BY TotalSales DESC
LIMIT 10;

Select Salesperson.SalespersonID, Salesperson.FirstName, Salesperson.LastName, Product.ProductName, Product.Variety, Product.Size, OrderItem.Quantity, Product.Price, 
ROUND( OrderItem.Quantity * Product.Price, 2) AS "OrderAmount"
From Salesperson
INNER JOIN Orders ON Orders.SalespersonID = Salesperson.SalespersonID                                                                           
INNER JOIN OrderItem ON Orders.OrderID = OrderItem.OrderID
INNER JOIN Product ON OrderItem.ProductID = Product.ProductID
WHERE Salesperson.SalespersonID = 140
ORDER BY OrderAmount DESC;

#	The top seller is Tina Holmes, who made 18 sales, sold 481 units, and brought in $1531.69 in revenue.  
#	Her best-selling item was 32oz Lemon-Lime, which she sold 50 units of at $3.69 for $184.5 in revenue. 
# 	32oz Mango came in a close second, with 48 units sold at $3.69 for a sales total of $177.12. 



