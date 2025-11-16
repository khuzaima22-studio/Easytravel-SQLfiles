

CREATE DATABASE Easytravel;
-- Table no: 1
CREATE TABLE Customer (
    CustomerID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(20),
    AccountType VARCHAR(20) CHECK (AccountType IN ('Regular', 'Loyalty Member')) NOT NULL,
    LoyaltyPoints INT DEFAULT 0,
    Username VARCHAR(50) UNIQUE NOT NULL,
    Password TEXT NOT NULL
);
--Table no: 2
CREATE TABLE Booking (
    BookingID SERIAL PRIMARY KEY,
    CustomerID INT NOT NULL,
    HolidayPackageID INT NOT NULL,
    AccommodationID INT NOT NULL,
    FlightID INT NOT NULL,
    BookingDate DATE NOT NULL,
    TotalPrice DECIMAL(10,2) NOT NULL,
    PaymentStatus VARCHAR(20) CHECK (PaymentStatus IN ('Paid', 'Pending', 'Cancelled')) NOT NULL,
    BookingStatus VARCHAR(20) CHECK (BookingStatus IN ('Confirmed', 'Pending', 'Cancelled')) NOT NULL,
    PaymentMethod VARCHAR(20) CHECK (PaymentMethod IN ('Credit Card', 'Bank Transfer', 'Loyalty Points')) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON DELETE CASCADE,
    FOREIGN KEY (HolidayPackageID) REFERENCES HolidayPackage(HolidayPackageID) ON DELETE CASCADE,
    FOREIGN KEY (AccommodationID) REFERENCES Accommodation(AccommodationID) on DELETE CASCADE,
    FOREIGN KEY (Flight) REFERENCES Flight(FlightID) ON DELETE CASCADE
);
--Table no: 3
CREATE TABLE Flight (
    FlightID SERIAL PRIMARY KEY,
    Airline VARCHAR(100) NOT NULL,
    FlightNumber VARCHAR(20) UNIQUE NOT NULL,
    DepartureDateTime TIMESTAMP NOT NULL,
    ArrivalDateTime TIMESTAMP NOT NULL,
    DepartureAirport VARCHAR(100) NOT NULL,
    ArrivalAirport VARCHAR(100) NOT NULL,
    SeatingCapacity INT CHECK (SeatingCapacity > 0) NOT NULL,
    AvailableSeats INT CHECK (AvailableSeats >= 0) NOT NULL,
    PricePerSeat DECIMAL(10,2) NOT NULL,
    FlightClass VARCHAR(20) CHECK (FlightClass IN ('Economy', 'Business', 'First-Class')) NOT NULL
);

--Table no: 4
CREATE TABLE Accommodation (
    AccommodationID SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Location VARCHAR(255) NOT NULL,
    AccommodationType VARCHAR(50) CHECK (AccommodationType IN ('Hotel', 'Vacation Home', 'Resort')) NOT NULL,
    RoomType VARCHAR(50) CHECK (RoomType IN ('Single', 'Double', 'Suite')) NOT NULL,
    PricePerNight DECIMAL(10,2) NOT NULL,
    Amenities TEXT,
    SeasonalPricing DECIMAL(10,2)
);

--Table no: 5
CREATE TABLE Payment (
    PaymentID SERIAL PRIMARY KEY,
    BookingID INT NOT NULL,
    PaymentDate DATE NOT NULL,
    AmountPaid DECIMAL(10,2) NOT NULL,
    PaymentMethod VARCHAR(20) CHECK (PaymentMethod IN ('Credit Card', 'Bank Transfer', 'Loyalty Points')) NOT NULL,
    PaymentStatus VARCHAR(20) CHECK (PaymentStatus IN ('Success', 'Failed', 'Pending')) NOT NULL,
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID) ON DELETE CASCADE
);
--Table no: 6
CREATE TABLE HolidayPackage (
    PackageID SERIAL PRIMARY KEY,
    PromotionID INT NOT NULL,
    PackageName VARCHAR (100) NOT NULL,
    Description TEXT,
    Price DECIMAL (10,2) NOT NULL,
    IncludedDestinations TEXT,
    IncludedFlights TEXT,
    IncludedAccommodations TEXT,
    FOREIGN KEY (PromotionID) REFERENCES Promotion(PromotionID) ON DELETE CASCADE
);


--Table no: 7
CREATE TABLE Feedback (
    FeedbackID SERIAL PRIMARY KEY,
    CustomerID INT NOT NULL,
    BookingID INT NOT NULL,
    DestinationRating INT CHECK (DestinationRating BETWEEN 1 AND 5) NOT NULL,
    FlightRating INT CHECK (FlightRating BETWEEN 1 AND 5),
    AccommodationRating INT CHECK (AccommodationRating BETWEEN 1 AND 5),
    AdditionalComments TEXT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON DELETE CASCADE,
    FOREIGN KEY (BookingID) REFERENCES Booking(BookingID) ON DELETE CASCADE
);
--Table no: 8 
CREATE TABLE Promotion (
    PromotionID SERIAL PRIMARY KEY,
    PromotionName VARCHAR(100) NOT NULL,
    DiscountPercentage DECIMAL(5,2) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    EligibleCustomers VARCHAR(30) CHECK (EligibleCustomers IN ('All', 'Loyalty Members Only')) NOT NULL,
    ApplicablePackages TEXT
);

