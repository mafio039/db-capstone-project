CREATE TABLE Bookings(BookingID int auto_increment primary key, BookingDate date, TableNumber int, CustomerID int);

INSERT INTO Bookings (BookingDate, TableNumber, CustomerID)
VALUES
('2022-10-10', 5, 1),
('2022-11-12', 3, 3),
('2022-10-11', 2, 2),
('2022-10-13', 2, 1);

SELECT * FROM littlelemondb.bookings;


DELIMITER //

CREATE PROCEDURE CheckBooking(IN booking_date date, IN table_number int)
BEGIN
	DECLARE table_status int;
    SELECT COUNT(*) INTO table_status
    FROM Bookings 
    WHERE BookingDate = booking_date AND TableNumber = table_number;
    
    IF table_status > 0 THEN
		SELECT CONCAT('Table ', table_number, ' is already booked on ', booking_date) AS message;
	ELSE 	
		SELECT CONCAT('Table ', table_number, ' is available on ', booking_date) AS message;
	END IF;
END //

DELIMITER ;

CALL CheckBooking("2022-10-10", 5);

DELIMITER //

CREATE PROCEDURE AddValidBooking(IN Booking_date date, IN Table_number int)
BEGIN
	DECLARE table_count int;
    START TRANSACTION;
    
    SELECT COUNT(*) INTO table_count
    FROM Bookings
    WHERE BookingDate = Booking_date AND TableNumber = Table_number;
    
    INSERT INTO Bookings(BookingDate, TableNumber, CustomerID) VALUES (Booking_date, Table_number, 4);
    
    IF table_count > 0 THEN
		ROLLBACK;
		SELECT CONCAT('Table ', Table_number, ' is already booked on ', Booking_date, ' -booking cancelled ') AS message;
    ELSE 
		COMMIT;
        SELECT concat('Booking successful for table ', Table_number, ' on ', Booking_date) AS message;
	END IF;
END //

DELIMITER ;
	
CALL AddValidBooking('2022-10-11', 1);		

DELIMITER //

CREATE PROCEDURE AddBooking(IN Booking_date date, Table_number int, Customer_id int)
BEGIN
INSERT INTO Bookings(BookingDate, TableNumber, CustomerID) VALUES (Booking_date, Table_number, Customer_id);
SELECT('New booking added') AS message;
END //

DELIMITER ;

CALL AddBooking('2022-12-30', 7, 5);


DELIMITER //

CREATE PROCEDURE UpdateBooking(IN Booking_id int, IN Booking_date date)
BEGIN
UPDATE Bookings SET BookingDate = Booking_date WHERE BookingID = Booking_id;
SELECT CONCAT('Booking number ', Booking_id, ' updated.') AS message;
END //

DELIMITER ;

CALL UpdateBooking(9, '2022-12-17');

DELIMITER //

CREATE PROCEDURE CancelBooking(IN Booking_id int)
BEGIN
DELETE FROM Bookings WHERE BookingID = Booking_id;
SELECT CONCAT('Booking number ', Booking_id, ' cancelled.') AS message;
END //

DELIMITER ;

CALL CancelBooking(9); 



		
    
    