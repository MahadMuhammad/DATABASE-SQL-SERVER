Create database TravelingAgencyDB;
go
use TravelingAgencyDB;
go
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(200)
);
go
INSERT INTO Customers (customer_id, first_name, last_name, email, phone, address)
VALUES
    (1, 'John', 'Doe', 'john.doe@example.com', '1234567890', '123 Main St'),
    (2, 'Jane', 'Smith', 'jane.smith@example.com', '9876543210', '456 Elm St'),
    (3, 'Michael', 'Johnson', 'michael.johnson@example.com', '4561237890', '789 Oak Ave');
go
CREATE TABLE Destinations (
    destination_id INT PRIMARY KEY,
    destination_name VARCHAR(100),
    country VARCHAR(100),
    description TEXT
);
go
INSERT INTO Destinations (destination_id, destination_name, country, description)
VALUES
    (1, 'Paris', 'France', 'Experience the charm of the City of Lights.'),
    (2, 'New York', 'United States', 'Discover the bustling streets of the Big Apple.'),
    (3, 'Tokyo', 'Japan', 'Immerse yourself in the vibrant culture of Tokyo.');
go
CREATE TABLE Hotels  (
    hotel_id INT PRIMARY KEY,
    hotel_name VARCHAR(100),
    destination_id INT,
    address VARCHAR(200),
    rating DECIMAL(2, 1),
    FOREIGN KEY (destination_id) REFERENCES Destinations(destination_id)
);
go
INSERT INTO Hotels (hotel_id, hotel_name, destination_id, address, rating)
VALUES
    (1, 'Hotel ABC', 1, '456 Elm St', 4.5),
    (2, 'Hotel XYZ', 2, '789 Oak Ave', 4.0),
    (3, 'Hotel 123', 3, '123 Main St', 4.2);
go
CREATE TABLE Flights  (
    flight_id INT PRIMARY KEY,
    flight_number VARCHAR(10),
    origin VARCHAR(100),
    destination VARCHAR(100),
    departure_time DATETIME,
    arrival_time DATETIME
);
go
INSERT INTO Flights (flight_id, flight_number, origin, destination, departure_time, arrival_time)
VALUES
    (1, 'FL123', 'New York', 'Paris', '2023-05-17 10:00:00', '2023-05-17 16:00:00'),
    (2, 'FL456', 'Paris', 'New York', '2023-05-18 12:00:00', '2023-05-18 18:00:00'),
    (3, 'FL789', 'Tokyo', 'New York', '2023-05-19 09:00:00', '2023-05-19 22:00:00');
go
CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    customerId INT,
    destinationId INT,
    hotelId INT,
    flightId INT,
    booking_date DATE,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (customerId) REFERENCES Customers(customer_id),
    FOREIGN KEY (destinationId) REFERENCES Destinations(destination_id),
    FOREIGN KEY (hotelId) REFERENCES Hotels(hotel_id),
    FOREIGN KEY (flightId) REFERENCES Flights(flight_id)
);
go
INSERT INTO Bookings (booking_id, customerId, destinationId, hotelId, flightId, booking_date, total_amount)
VALUES
    (1, 1, 1, 1, 1, '2023-05-16', 1500.00),
    (2, 2, 2, 2, 2, '2023-05-17', 2000.00),
    (3, 3, 3, 3, 3, '2023-05-18', 1800.00);
go
select * from  Flights 
select * from Hotels 
select * from  Destinations
select * from  Bookings 
select * from  Customers
