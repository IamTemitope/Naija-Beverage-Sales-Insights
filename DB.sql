-- ============================
-- BEVERAGECO NIGERIA SCHEMA
-- ============================

-- PRODUCTS TABLE
CREATE TABLE Products (
    ProductID SERIAL PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    PackSize VARCHAR(20) NOT NULL,
    PackType VARCHAR(30) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL
);

-- CUSTOMERS (OUTLETS)
CREATE TABLE Customers (
    OutletID SERIAL PRIMARY KEY,
    OutletName VARCHAR(100) NOT NULL,
    OutletType VARCHAR(50) NOT NULL, -- e.g. Supermarket, Kiosk, Bar, Restaurant
    Region VARCHAR(50) NOT NULL,     -- e.g. Lagos, Abuja, Kano
    Address TEXT
);

-- DISTRIBUTORS
CREATE TABLE Distributors (
    DistributorID SERIAL PRIMARY KEY,
    DistributorName VARCHAR(100) NOT NULL,
    Territory VARCHAR(50) NOT NULL
);

-- ORDERS
CREATE TABLE Orders (
    OrderID SERIAL PRIMARY KEY,
    OutletID INT NOT NULL,
    DistributorID INT NOT NULL,
    OrderDate DATE NOT NULL,
    DeliveryDate DATE,
    Status VARCHAR(20) NOT NULL CHECK (Status IN ('Delivered', 'Pending', 'Cancelled')),
    FOREIGN KEY (OutletID) REFERENCES Customers(OutletID),
    FOREIGN KEY (DistributorID) REFERENCES Distributors(DistributorID)
);

-- ORDER DETAILS
CREATE TABLE OrderDetails (
    OrderDetailID SERIAL PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    UnitPrice DECIMAL(10,2) NOT NULL,
    Discount DECIMAL(5,2) DEFAULT 0.00,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- PROMOTIONS
CREATE TABLE Promotions (
    PromoID SERIAL PRIMARY KEY,
    ProductID INT,
    Category VARCHAR(50),
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    DiscountRate DECIMAL(5,2) NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- INVENTORY
CREATE TABLE Inventory (
    InventoryID SERIAL PRIMARY KEY,
    ProductID INT NOT NULL,
    DistributorID INT NOT NULL,
    StockLevel INT NOT NULL,
    LastRestockDate DATE NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (DistributorID) REFERENCES Distributors(DistributorID)
);
