
--Queries for our Database "Easytravel"--

-- Query no: 1 with LEFT JOIN
-- Retrieve all customer details along with their total bookings
SELECT c.CustomerID, c.FirstName, c.LastName, COUNT(b.BookingID) AS TotalBookings
FROM Customer c
LEFT JOIN Booking b ON c.CustomerID = b.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName;
--Querty no: 2
-- Retrieve highest and lowest payment amounts along with their respective booking IDs
SELECT MIN(AmountPaid) AS MinPayment, MAX(AmountPaid) AS MaxPayment, AVG(AmountPaid) AS AvgPayment
FROM Payment;
--Query no: 3
-- Retrieve the top 5 most expensive holiday packages
SELECT PackageName, Price FROM HolidayPackage ORDER BY Price DESC LIMIT 5;
--Query no: 4
-- Show payments with status details using CASE statement
SELECT PaymentID, AmountPaid, PaymentStatus,
    CASE 
        WHEN PaymentStatus = 'Success' THEN 'Payment Processed'
        WHEN PaymentStatus = 'Failed' THEN 'Payment Declined'
        ELSE 'Payment Pending'
    END AS PaymentDetails
FROM Payment;
--Query no: 5
-- Retrieve total payments per payment method
SELECT PaymentMethod, COUNT(*) AS TotalTransactions, SUM(AmountPaid) AS TotalRevenue
FROM Payment
GROUP BY PaymentMethod;
--Query no: 5
-- Retrieve successful transactions with Right Join
SELECT b.BookingID, p.AmountPaid, p.PaymentStatus
FROM Booking b
RIGHT JOIN Payment p ON b.BookingID = p.BookingID
WHERE p.PaymentStatus = 'Success';
--Query no: 6
-- Retrieve customers who have made bookings but payments are pending
SELECT c.CustomerID, c.FirstName, c.LastName
FROM Customer c
JOIN Booking b ON c.CustomerID = b.CustomerID
JOIN Payment p ON b.BookingID = p.BookingID
WHERE p.PaymentStatus = 'Pending';
--Query no: 7
-- Implementing a transaction  
BEGIN;
UPDATE Booking SET BookingStatus = 'Cancelled' WHERE BookingID = 45;
UPDATE Payment SET PaymentStatus = 'Failed' WHERE BookingID = 45;
COMMIT;
SELECT * FROM Booking WHERE BookingID = 45;
SELECT * FROM Payment WHERE BookingID = 45;
--Query no: 8
-- Find customers with the most loyalty points
SELECT FirstName, LastName, LoyaltyPoints
FROM Customer
ORDER BY LoyaltyPoints DESC LIMIT 10;

-- Adjust the Access level 

--readonly_user
CREATE ROLE readonly_user WITH LOGIN PASSWORD 'securepassword';
GRANT CONNECT ON DATABASE 'Easytravel' TO readonly_user;
--Giving access 
GRANT USAGE ON SCHEMA public TO readonly_user;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly_user;


--readonly_user
-- Allow login to database
GRANT CONNECT ON DATABASE "Easytravel" TO readonly_user;

-- Allow browsing schema and tables
GRANT USAGE ON SCHEMA public TO readonly_user;

-- Make sure they cannot read data
REVOKE SELECT ON ALL TABLES IN SCHEMA public FROM readonly_user;

-- Block future SELECT privileges
ALTER DEFAULT PRIVILEGES IN SCHEMA public 
    REVOKE SELECT ON TABLES FROM readonly_user;


--Admin_user
CREATE ROLE admin_user WITH LOGIN PASSWORD 'strongpassword';
GRANT ALL PRIVILEGES ON DATABASE 'Easytravel' TO admin_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO admin_user;
GRANT CREATE ON SCHEMA public TO admin_user;
  






