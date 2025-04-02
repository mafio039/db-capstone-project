CREATE VIEW OrdersView AS SELECT Order_ID, Quantity, Bill_Amount FROM orders WHERE Quantity > 2;

SELECT * FROM ordersview;

SELECT b.Customer_ID, c.Name, o.Order_ID, o.Bill_Amount, m.Menu_Name, mi.Course_Name, mi.Starter_Name FROM customers AS c INNER JOIN bookings AS b ON c.Customer_ID = b.Customer_ID INNER JOIN orders AS o ON b.Booking_ID = o.Booking_ID INNER JOIN menus AS m ON o.Menu_ID = m.Menu_ID INNER JOIN menu_items AS mi ON m.Menu_Items_ID = mi.Menu_Items_ID WHERE o.Bill_Amount > 150 ORDER BY o.Bill_Amount ASC;

SELECT Menu_Name FROM menus WHERE Menu_ID = ANY (SELECT Menu_ID FROM orders WHERE Quantity > 2);

CREATE PROCEDURE GetMaxQuantity() SELECT MAX(Quantity) FROM orders;

CALL GetMaxQuantity;

PREPARE GetOrderDetail FROM 'SELECT Order_ID, Quantity, Bill_Amount FROM orders WHERE Booking_ID = ?';

SET @booking_id = 1;

EXECUTE GetOrderDetail USING @booking_id;

CREATE PROCEDURE CancelOrder(IN order_id int) DELETE FROM orders WHERE Order_ID = order_id;
 
CALL CancelOrder(6);