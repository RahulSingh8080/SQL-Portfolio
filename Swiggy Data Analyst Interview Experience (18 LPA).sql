
Create database Interview_Prep;

Use Interview_Prep;

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    UserID INT,
    City VARCHAR(50),
    DeliveryZone VARCHAR(50),
    OrderDate DATE,
    DeliveryTimeMinutes INT
);

INSERT INTO Orders (OrderID, UserID, City, DeliveryZone, OrderDate, DeliveryTimeMinutes) VALUES
(1, 101, 'Mumbai', 'Andheri', '2025-10-02', 32),
(2, 102, 'Delhi', 'Connaught Place', '2025-10-03', 45),
(3, 103, 'Bangalore', 'Whitefield', '2025-10-04', 30),
(4, 101, 'Mumbai', 'Bandra', '2025-10-05', 40),
(5, 104, 'Delhi', 'Saket', '2025-10-06', 55),
(6, 105, 'Mumbai', 'Andheri', '2025-10-07', 28),
(7, 106, 'Delhi', 'Saket', '2025-10-08', 60),
(8, 107, 'Bangalore', 'Indiranagar', '2025-10-09', 35),
(9, 108, 'Mumbai', 'Bandra', '2025-10-10', 45),
(10, 109, 'Delhi', 'Connaught Place', '2025-10-11', 50),
(11, 110, 'Mumbai', 'Andheri', '2025-10-12', 25),
(12, 111, 'Bangalore', 'Whitefield', '2025-10-13', 38),
(13, 112, 'Delhi', 'Saket', '2025-10-14', 58),
(14, 113, 'Bangalore', 'Indiranagar', '2025-10-15', 42),
(15, 114, 'Mumbai', 'Andheri', '2025-10-16', 30);


--1️ Find Top 5 Delivery Zones by Total Order Count in a Month
Select TOP 5 DeliveryZone,  Count(*) as TotalOrders
from orders where MONTH(OrderDate) = 10
Group by deliveryZone
order by TotalOrders DESC;

--2️ Identify Users Who Haven’t Placed an Order in the Last 30 Days
SELECT DISTINCT UserID from orders where userID NOT IN (Select DISTINCT UserID from orders
where OrderDate >= DATEADD(Day, 30, GETDATE()));

--3️ Calculate Average Delivery Time per City

Select City, AVG(DeliveryTimeMinutes) as AVGDeliveryTime
from orders
Group by City 
Order by AVGDeliveryTime;

--4️ Case: “Swiggy’s delivery time has increased by 10% — how will you diagnose the issue?”

--Answer Approach:

--Compare last month’s vs current month’s average delivery time per city and zone.

--Identify outliers (zones with >15% increase).

--Check if the issue correlates with:

--Surge in order volume (too many orders per delivery person).

--Weather / traffic impact.

--New restaurants with slower prep times.

--Change in delivery partner assignments or working hours.

--Weekend vs weekday pattern shifts.

SELECT 
    City,
    DeliveryZone,
    AVG(CASE WHEN MONTH(OrderDate) = 9 THEN DeliveryTimeMinutes END) AS AvgTime_Sept,
    AVG(CASE WHEN MONTH(OrderDate) = 10 THEN DeliveryTimeMinutes END) AS AvgTime_Oct,
    (AVG(CASE WHEN MONTH(OrderDate) = 10 THEN DeliveryTimeMinutes END) -
     AVG(CASE WHEN MONTH(OrderDate) = 9 THEN DeliveryTimeMinutes END)) * 100.0 /
     AVG(CASE WHEN MONTH(OrderDate) = 9 THEN DeliveryTimeMinutes END) AS PercentageIncrease
FROM Orders
GROUP BY City, DeliveryZone;

