CREATE TABLE Customers (
    Customer_ID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    CreatedDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    House_Number VARCHAR(10) NOT NULL,
    Street_Name VARCHAR(100) NOT NULL,
    Pincode VARCHAR(10) NOT NULL,
    City VARCHAR(50) NOT NULL
);

CREATE TABLE Products (
    Product_ID INT AUTO_INCREMENT PRIMARY KEY,
    Product_Name VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE Category (
    Category_ID INT AUTO_INCREMENT PRIMARY KEY,
    Category_Name VARCHAR(100) NOT NULL,
    Super_Category VARCHAR(100) NOT NULL
);

CREATE TABLE Sales (
    SalesID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    Status VARCHAR(50) NOT NULL,
    SalesAmount DECIMAL(10, 2) NOT NULL,
    PaymentMethod VARCHAR(50) NOT NULL,
    SalesDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (CustomerID) REFERENCES Customers(Customer_ID) ON DELETE SET NULL
);

CREATE TABLE Review (
    ReviewID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    Rating INT NOT NULL CHECK (Rating BETWEEN 1 AND 5),  
    ReviewText TEXT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(Customer_ID) ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(Product_ID) ON DELETE CASCADE
);


CREATE TABLE Inventory (
    Inventory_ID INT AUTO_INCREMENT PRIMARY KEY,
    Product_ID INT NOT NULL,
    Stock_Level INT NOT NULL,
    DateChanged DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID) ON DELETE CASCADE
);

CREATE TABLE PRODUCT_SALES (
    Product_ID INT NOT NULL,
    Sales_ID INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    Quantity INT NOT NULL,
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID) ON DELETE CASCADE,
    FOREIGN KEY (Sales_ID) REFERENCES Sales(SalesID) ON DELETE CASCADE,
    PRIMARY KEY (Product_ID, Sales_ID)  -- Composite primary key
);

CREATE TABLE PRODUCT_CATEGORY (
    Product_ID INT NOT NULL,
    Category_ID INT NOT NULL,
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID) ON DELETE CASCADE,
    FOREIGN KEY (Category_ID) REFERENCES Category(Category_ID) ON DELETE CASCADE,
    PRIMARY KEY (Product_ID, Category_ID)  -- Composite primary key
);

CREATE TABLE Customer_Phone (
    Customer_ID INT NOT NULL,
    Phone_Number VARCHAR(15) NOT NULL,
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID) ON DELETE CASCADE,
    PRIMARY KEY (Customer_ID, Phone_Number)  -- Composite primary key
);


INSERT INTO Customers (FirstName, LastName, Email, CreatedDate, House_Number, Street_Name, Pincode, City)
VALUES 
('John', 'Doe', 'john.doe@example.com', '2023-10-01', '123', 'Main St', '12345', 'New York'),
('Jane', 'Smith', 'jane.smith@example.com', '2023-10-02', '456', 'Oak St', '23456', 'Los Angeles'),
('Alice', 'Johnson', 'alice.johnson@example.com', '2023-10-03', '789', 'Pine St', '34567', 'Chicago'),
('Bob', 'Brown', 'bob.brown@example.com', '2023-10-04', '101', 'Maple St', '45678', 'Houston'),
('Charlie', 'Davis', 'charlie.davis@example.com', '2023-10-05', '202', 'Elm St', '56789', 'Phoenix'),
('Eve', 'Williams', 'eve.williams@example.com', '2023-10-06', '303', 'Birch St', '67890', 'Philadelphia'),
('Frank', 'Miller', 'frank.miller@example.com', '2023-10-07', '404', 'Cedar St', '78901', 'San Antonio'),
('Grace', 'Wilson', 'grace.wilson@example.com', '2023-10-08', '505', 'Walnut St', '89012', 'San Diego'),
('Hank', 'Moore', 'hank.moore@example.com', '2023-10-09', '606', 'Chestnut St', '90123', 'Dallas'),
('Ivy', 'Taylor', 'ivy.taylor@example.com', '2023-10-10', '707', 'Ash St', '01234', 'San Jose');


-- Consumer Electronics
INSERT INTO Category (Category_Name, Super_Category) VALUES ('Smartphones', 'Consumer Electronics');
INSERT INTO Category (Category_Name, Super_Category) VALUES ('Laptops', 'Consumer Electronics');
INSERT INTO Category (Category_Name, Super_Category) VALUES ('Desktops', 'Consumer Electronics');
INSERT INTO Category (Category_Name, Super_Category) VALUES ('Tablets', 'Consumer Electronics');
INSERT INTO Category (Category_Name, Super_Category) VALUES ('Consoles', 'Consumer Electronics');
INSERT INTO Category (Category_Name, Super_Category) VALUES ('Gaming PCs', 'Consumer Electronics');
INSERT INTO Category (Category_Name, Super_Category) VALUES ('Headphones', 'Consumer Electronics');
INSERT INTO Category (Category_Name, Super_Category) VALUES ('Speakers', 'Consumer Electronics');
INSERT INTO Category (Category_Name, Super_Category) VALUES ('TVs', 'Consumer Electronics');

-- Tech Accessories
INSERT INTO Category (Category_Name, Super_Category) VALUES ('Cases', 'Tech Accessories');
INSERT INTO Category (Category_Name, Super_Category) VALUES ('Chargers', 'Tech Accessories');
INSERT INTO Category (Category_Name, Super_Category) VALUES ('Power Banks', 'Tech Accessories');
INSERT INTO Category (Category_Name, Super_Category) VALUES ('Cables', 'Tech Accessories');
INSERT INTO Category (Category_Name, Super_Category) VALUES ('Adapters', 'Tech Accessories');
INSERT INTO Category (Category_Name, Super_Category) VALUES ('Screen Protectors', 'Tech Accessories');
INSERT INTO Category (Category_Name, Super_Category) VALUES ('Stylus Pens', 'Tech Accessories');

-- Wearables
INSERT INTO Category (Category_Name, Super_Category) VALUES ('Smartwatches', 'Wearables');
INSERT INTO Category (Category_Name, Super_Category) VALUES ('Fitness Trackers', 'Wearables');
INSERT INTO Category (Category_Name, Super_Category) VALUES ('Smart Glasses', 'Wearables');
INSERT INTO Category (Category_Name, Super_Category) VALUES ('Hearables', 'Wearables');

-- Home Electronics
INSERT INTO Category (Category_Name, Super_Category) VALUES ('Smart Home Devices', 'Home Electronics');
INSERT INTO Category (Category_Name, Super_Category) VALUES ('Home Theater Systems', 'Home Electronics');
INSERT INTO Category (Category_Name, Super_Category) VALUES ('Kitchen Appliances', 'Home Electronics');
INSERT INTO Category (Category_Name, Super_Category) VALUES ('Home Security Systems', 'Home Electronics');


-- Inserting Products for Smartphones
INSERT INTO Products (Product_Name, Price) VALUES ('Apple iPhone', 999.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Samsung Galaxy', 899.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Google Pixel', 799.99);

-- Inserting Products for Laptops
INSERT INTO Products (Product_Name, Price) VALUES ('Apple MacBook', 1299.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Dell XPS', 1099.99);
INSERT INTO Products (Product_Name, Price) VALUES ('HP Spectre', 1199.99);

-- Inserting Products for Desktops
INSERT INTO Products (Product_Name, Price) VALUES ('Lenovo ThinkPad', 999.99);
INSERT INTO Products (Product_Name, Price) VALUES ('HP Omen', 1299.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Dell Inspiron', 799.99);

-- Inserting Products for Tablets
INSERT INTO Products (Product_Name, Price) VALUES ('Apple iPad', 499.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Samsung Galaxy Tab', 399.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Microsoft Surface Pro', 799.99);

-- Inserting Products for Consoles
INSERT INTO Products (Product_Name, Price) VALUES ('Sony PlayStation', 499.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Microsoft Xbox', 499.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Nintendo Switch', 299.99);

-- Inserting Products for Gaming PCs
INSERT INTO Products (Product_Name, Price) VALUES ('Alienware Gaming PC', 1999.99);
INSERT INTO Products (Product_Name, Price) VALUES ('HP Omen Gaming PC', 1499.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Razer Gaming PC', 1599.99);

-- Inserting Products for Headphones
INSERT INTO Products (Product_Name, Price) VALUES ('Bose QuietComfort', 349.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Sony WH-1000XM4', 299.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Sennheiser HD 660S', 399.99);

-- Inserting Products for Speakers
INSERT INTO Products (Product_Name, Price) VALUES ('JBL Charge', 149.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Bose SoundLink', 199.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Sonos One', 199.99);

-- Inserting Products for TVs
INSERT INTO Products (Product_Name, Price) VALUES ('Sony Bravia', 999.99);
INSERT INTO Products (Product_Name, Price) VALUES ('LG OLED TV', 1299.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Samsung QLED TV', 1099.99);

-- Inserting Products for Cases
INSERT INTO Products (Product_Name, Price) VALUES ('OtterBox', 49.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Spigen', 29.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Caseology', 39.99);

-- Inserting Products for Chargers
INSERT INTO Products (Product_Name, Price) VALUES ('Anker Power Bank', 39.99);
INSERT INTO Products (Product_Name, Price) VALUES ('RAVPower', 29.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Belkin Charger', 24.99);

-- Inserting Products for Power Banks
INSERT INTO Products (Product_Name, Price) VALUES ('Aukey Power Bank', 34.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Mophie Power Bank', 49.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Zendure Power Bank', 59.99);

-- Inserting Products for Cables
INSERT INTO Products (Product_Name, Price) VALUES ('Anker Cable', 19.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Belkin Cable', 14.99);
INSERT INTO Products (Product_Name, Price) VALUES ('UGREEN Cable', 12.99);

-- Inserting Products for Adapters
INSERT INTO Products (Product_Name, Price) VALUES ('AmazonBasics Adapter', 9.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Apple USB-C Adapter', 19.99);
INSERT INTO Products (Product_Name, Price) VALUES ('UGREEN Adapter', 15.99);

-- Inserting Products for Screen Protectors
INSERT INTO Products (Product_Name, Price) VALUES ('ZAGG Glass', 29.99);
INSERT INTO Products (Product_Name, Price) VALUES ('amFilm Glass', 19.99);
INSERT INTO Products (Product_Name, Price) VALUES ('JETech Glass', 15.99);

-- Inserting Products for Stylus Pens
INSERT INTO Products (Product_Name, Price) VALUES ('Apple Pencil', 99.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Wacom Bamboo Stylus', 59.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Logitech Crayon', 69.99);

-- Inserting Products for Smartwatches
INSERT INTO Products (Product_Name, Price) VALUES ('Apple Watch', 399.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Samsung Galaxy Watch', 349.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Garmin Forerunner', 299.99);

-- Inserting Products for Fitness Trackers
INSERT INTO Products (Product_Name, Price) VALUES ('Fitbit Charge', 149.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Garmin Vivosmart', 129.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Xiaomi Mi Band', 99.99);

-- Inserting Products for Smart Glasses
INSERT INTO Products (Product_Name, Price) VALUES ('Google Glass', 999.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Vuzix Blade', 799.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Bose Frames', 299.99);

-- Inserting Products for Hearables
INSERT INTO Products (Product_Name, Price) VALUES ('Apple AirPods', 199.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Samsung Galaxy Buds', 149.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Sony WF-1000XM5', 249.99);

-- Inserting Products for Smart Home Devices
INSERT INTO Products (Product_Name, Price) VALUES ('Amazon Echo', 99.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Google Nest', 129.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Ring Doorbell', 199.99);

-- Inserting Products for Home Theater Systems
INSERT INTO Products (Product_Name, Price) VALUES ('Sonos One', 199.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Bose Soundbar 700', 799.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Yamaha AVENTAGE', 999.99);

-- Inserting Products for Kitchen Appliances
INSERT INTO Products (Product_Name, Price) VALUES ('Samsung Family Hub', 2999.99);
INSERT INTO Products (Product_Name, Price) VALUES ('LG InstaView', 1999.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Keurig K-Elite', 149.99);

-- Inserting Products for Home Security Systems
INSERT INTO Products (Product_Name, Price) VALUES ('Ring Cameras', 199.99);
INSERT INTO Products (Product_Name, Price) VALUES ('Arlo Security Cameras', 249.99);
INSERT INTO Products (Product_Name, Price) VALUES ('ADT Alarms', 299.99);
INSERT INTO Products (Product_Name, Price) VALUES ('SimpliSafe Systems', 399.99);

-- Mapping Products to Categories
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (1, 1);  -- Apple iPhone
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (2, 1);  -- Samsung Galaxy
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (3, 1);  -- Google Pixel
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (4, 2);  -- Apple MacBook
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (5, 2);  -- Dell XPS
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (6, 2);  -- HP Spectre
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (7, 3);  -- Lenovo ThinkPad
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (8, 3);  -- HP Omen
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (9, 3);  -- Dell Inspiron
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (10, 4); -- Apple iPad
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (11, 4); -- Samsung Galaxy Tab
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (12, 4); -- Microsoft Surface Pro
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (13, 5); -- Sony PlayStation
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (14, 5); -- Microsoft Xbox
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (15, 5); -- Nintendo Switch
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (16, 6); -- Alienware Gaming PC
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (17, 6); -- HP Omen Gaming PC
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (18, 6); -- Razer Gaming PC
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (19, 7); -- Bose QuietComfort
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (20, 7); -- Sony WH-1000XM4
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (21, 7); -- Sennheiser HD 660S
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (22, 8); -- JBL Charge
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (23, 8); -- Bose SoundLink
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (24, 8); -- Sonos One
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (25, 9); -- Sony Bravia
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (26, 9); -- LG OLED TV
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (27, 9); -- Samsung QLED TV
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (28, 10); -- OtterBox
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (29, 10); -- Spigen
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (30, 10); -- Caseology
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (31, 11); -- Portonics
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (32, 11); -- RAVPower
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (33, 11); -- Belkin Charger
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (34, 12); -- Aukey Power Bank
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (35, 12); -- Mophie Power Bank
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (36, 12); -- Zendure Power Bank
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (37, 13); -- Anker Cable
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (38, 13); -- Belkin Cable
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (39, 13); -- UGREEN Cable
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (40, 14); -- AmazonBasics Adapter
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (41, 14); -- Apple USB-C Adapter
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (42, 14); -- UGREEN Adapter
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (43, 15); -- ZAGG Glass
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (44, 15); -- amFilm Glass
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (45, 15); -- JETech Glass
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (46, 16); -- Apple Pencil
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (47, 16); -- Wacom Bamboo Stylus
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (48, 16); -- Logitech Crayon
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (49, 17); -- Apple Watch
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (50, 17); -- Samsung Galaxy Watch
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (51, 17); -- Garmin Forerunner
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (52, 18); -- Fitbit Charge
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (53, 18); -- Garmin Vivosmart
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (54, 18); -- Xiaomi Mi Band
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (55, 19); -- Google Glass
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (56, 19); -- Vuzix Blade
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (57, 19); -- Bose Frames
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (58, 20); -- Apple AirPods
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (59, 20); -- Samsung Galaxy Buds
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (60, 20); -- Sony WF-1000XM5
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (61, 21); -- Amazon Echo
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (62, 21); -- Google Nest
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (63, 21); -- Ring Doorbell
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (64, 22); -- Sonos One
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (65, 22); -- Bose Soundbar 700
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (66, 22); -- Yamaha AVENTAGE
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (67, 23); -- Samsung Family Hub
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (68, 23); -- LG InstaView
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (69, 23); -- Keurig K-Elite
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (70, 24); -- Ring Cameras
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (71, 24); -- Arlo Security Cameras
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (72, 24); -- ADT Alarms
INSERT INTO Product_Category (Product_ID, Category_ID) VALUES (73, 24); -- SimpliSafe Systems


ALTER TABLE Sales
DROP COLUMN Status;


INSERT INTO Sales (CustomerID, SalesAmount, PaymentMethod, SalesDate) VALUES
(1, 999.99, 'Credit Card', '2023-10-01 10:00:00'), -- John Doe
(1, 899.99, 'PayPal', '2023-10-05 15:30:00'),    -- John Doe
(2, 1299.99, 'Debit Card', '2023-10-02 11:15:00'), -- Jane Smith
(3, 799.99, 'Credit Card', '2023-10-03 09:00:00'), -- Alice Johnson
(4, 499.99, 'Cash', '2023-10-04 13:45:00'),       -- Bob Brown
(5, 1199.99, 'Credit Card', '2023-10-06 14:00:00'), -- Charlie Davis
(6, 299.99, 'Debit Card', '2023-10-07 16:30:00'),  -- Eve Williams
(7, 399.99, 'PayPal', '2023-10-08 12:00:00'),      -- Frank Miller
(8, 149.99, 'Credit Card', '2023-10-09 10:30:00'),  -- Grace Wilson
(9, 999.99, 'Cash', '2023-10-10 11:00:00'),         -- Hank Moore
(10, 399.99, 'Debit Card', '2023-10-11 14:15:00'),  -- Ivy Taylor
(1, 499.99, 'Credit Card', '2023-10-12 09:45:00'),  -- John Doe
(2, 1299.99, 'Cash', '2023-10-13 10:30:00'),        -- Jane Smith
(3, 249.99, 'PayPal', '2023-10-14 16:30:00'),       -- Alice Johnson
(4, 599.99, 'Debit Card', '2023-10-15 11:15:00'),   -- Bob Brown
(5, 49.99, 'Credit Card', '2023-10-16 12:00:00'),   -- Charlie Davis
(6, 149.99, 'PayPal', '2023-10-17 13:00:00'),       -- Eve Williams
(7, 299.99, 'Cash', '2023-10-18 14:30:00'),         -- Frank Miller
(8, 199.99, 'Debit Card', '2023-10-19 15:00:00'),    -- Grace Wilson
(9, 249.99, 'Credit Card', '2023-10-20 10:45:00');   -- Hank Moore


INSERT INTO PRODUCT_SALES (Product_ID, Sales_ID, UnitPrice, Quantity) VALUES
(1, 1, 999.99, 2),   -- Apple iPhone in Sale 1
(2, 1, 899.99, 1),   -- Samsung Galaxy in Sale 1
(3, 1, 799.99, 1),   -- Google Pixel in Sale 1

(4, 2, 1299.99, 1),  -- Apple MacBook in Sale 2
(5, 2, 499.99, 2),   -- Apple iPad in Sale 2

(6, 3, 1199.99, 1),  -- HP Spectre in Sale 3
(7, 3, 299.99, 1),   -- Nintendo Switch in Sale 3
(8, 3, 399.99, 2),   -- Dell Inspiron in Sale 3

(9, 4, 499.99, 1),   -- Sony PlayStation in Sale 4
(10, 4, 299.99, 3),  -- JBL Charge in Sale 4
(1, 4, 999.99, 1),   -- Apple iPhone in Sale 4

(11, 5, 399.99, 2),  -- Samsung Galaxy Buds in Sale 5
(12, 5, 499.99, 1),  -- Apple iPad in Sale 5

(2, 6, 799.99, 2),   -- Samsung Galaxy in Sale 6
(4, 6, 1299.99, 1),  -- Apple MacBook in Sale 6

(3, 7, 249.99, 1),   -- Google Pixel in Sale 7
(5, 7, 49.99, 2),    -- OtterBox in Sale 7

(6, 8, 149.99, 3),   -- Anker Power Bank in Sale 8
(8, 8, 249.99, 1),   -- Apple AirPods in Sale 8

(9, 9, 199.99, 1),   -- Amazon Echo in Sale 9
(10, 9, 199.99, 2),  -- Amazon Echo in Sale 9

(1, 10, 999.99, 1),  -- Apple iPhone in Sale 10
(2, 10, 899.99, 1);  -- Samsung Galaxy in Sale 10


INSERT INTO Review (CustomerID, ProductID, Rating, ReviewText) VALUES
(1, 1, 5, 'Absolutely love my new iPhone!'),
(1, 2, 4, 'The Samsung Galaxy is great, but a bit overpriced.'),
(2, 3, 5, 'The Google Pixel has an amazing camera!'),
(3, 4, 3, 'MacBook is good, but I expected better performance.'),
(4, 5, 4, 'PlayStation is a must-have for gamers!'),
(5, 6, 2, 'HP Spectre has a nice design, but battery life could be better.'),
(6, 7, 5, 'The Nintendo Switch is so much fun!'),
(7, 8, 3, 'Dell Inspiron is decent, but I have had some issues.'),
(8, 9, 4, 'JBL Charge has great sound quality!'),
(9, 10, 5, 'The Galaxy Buds are perfect for workouts!'),
(10, 1, 4, 'I really like the iPhone, but it has some limitations.'),
(1, 11, 5, 'The AirPods are life-changing!'),
(2, 12, 3, 'The MacBook is okay but lacks some features.'),
(3, 13, 5, 'Amazing camera quality on the Pixel!'),
(4, 14, 2, 'Not the best experience with this laptop.'),
(5, 15, 4, 'Fantastic gaming experience with the PlayStation!'),
(6, 16, 5, 'The new Anker Power Bank is a lifesaver!'),
(7, 17, 4, 'Fitbit is good for tracking fitness.'),
(8, 18, 3, 'AirPods sound good but could fit better.'),
(9, 19, 4, 'Great sound from the Amazon Echo!'),
(10, 20, 5, 'The LG OLED TV has stunning picture quality!');


ALTER TABLE Customers
ADD COLUMN Password VARCHAR(255) NOT NULL;


UPDATE Customers
SET Password = 'password123';


CREATE TABLE Admins (
    AdminID INT AUTO_INCREMENT PRIMARY KEY,  -- Unique identifier for each admin
    email VARCHAR(255) NOT NULL UNIQUE,      -- Admin's email address
    password VARCHAR(255) NOT NULL          -- Admin's password (hashed)
) ; 


INSERT INTO Admins (email, password) 
VALUES ('admin@example.com', 'adminpasskey123');

CREATE TABLE CART (
    CartID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    Product_ID INT,
    Quantity INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(Customer_ID),
    FOREIGN KEY (Product_ID) REFERENCES PRODUCTS(Product_ID)
);

--Stored Procedure for Adding to Cart
-- Change the delimiter
DELIMITER //

CREATE PROCEDURE AddToCart(IN p_CustomerID INT, IN p_ProductID INT, IN p_Quantity INT)
BEGIN
    DECLARE stockLevel INT;

    -- Start transaction
    START TRANSACTION;

    -- Check stock level
    SELECT Stock_Level INTO stockLevel FROM Inventory WHERE Product_ID = p_ProductID;

    IF stockLevel >= p_Quantity THEN
        -- Add item to cart
        INSERT INTO CART (CustomerID, Product_ID, Quantity) VALUES (p_CustomerID, p_ProductID, p_Quantity);
        
        -- Decrement stock level
        UPDATE Inventory SET Stock_Level = Stock_Level - p_Quantity WHERE Product_ID = p_ProductID;
        
        -- Commit transaction
        COMMIT;

        -- Return success message
        SELECT 'Success: Item has been added to the cart.' AS Message;
    ELSE
        -- Rollback transaction
        ROLLBACK;

        -- Return out of stock message
        SELECT 'Error: Product is out of stock.' AS Message;
    END IF;
END //

-- Restore the delimiter
DELIMITER ;

--- Creating a View (Products + Carts ) ( To simplify Retrieval )
CREATE VIEW CartView AS
SELECT c.CartID, c.CustomerID, p.Product_ID, p.Product_Name, p.Price, c.Quantity
FROM CART c
JOIN PRODUCTS p ON c.Product_ID = p.Product_ID;

--Stored Procedure For Retrieving Cart Details
DELIMITER //
CREATE PROCEDURE GetCustomerCart(IN id INT)
BEGIN
    SELECT Product_Name, Product_ID, Quantity, Price, (Quantity * Price) AS Total_Price
    FROM CartView
    WHERE CustomerID = id;
END //
DELIMITER ;

--StoredProcedure to Update Cart Quantity
DELIMITER //

CREATE PROCEDURE UpdateCartQuantity(IN p_CustomerID INT, IN p_ProductID INT, IN p_NewQuantity INT)
BEGIN
    DECLARE stockLevel INT;
    DECLARE currentQuantity INT;

    -- Start transaction
    START TRANSACTION;

    -- Get current quantity in the cart
    SELECT Quantity INTO currentQuantity
    FROM CART
    WHERE CustomerID = p_CustomerID AND Product_ID = p_ProductID;

    -- Check if the item exists in the cart
    IF currentQuantity IS NOT NULL THEN
        -- Get stock level for the product
        SELECT Stock_Level INTO stockLevel
        FROM Inventory
        WHERE Product_ID = p_ProductID;

        -- Check if there's enough stock to update the cart
        IF stockLevel + currentQuantity >= p_NewQuantity THEN
            -- Update quantity in the cart
            UPDATE CART
            SET Quantity = p_NewQuantity
            WHERE CustomerID = p_CustomerID AND Product_ID = p_ProductID;

            -- Adjust stock level in inventory
            UPDATE Inventory
            SET Stock_Level = stockLevel - (p_NewQuantity - currentQuantity)
            WHERE Product_ID = p_ProductID;

            -- Commit transaction
            COMMIT;

            -- Return success message
            SELECT 'Success: Cart quantity updated.' AS Message;
        ELSE
            -- Rollback transaction if not enough stock
            ROLLBACK;

            -- Return out of stock message
            SELECT 'Error: Not enough stock available.' AS Message;
        END IF;
    ELSE
        -- Rollback transaction if item not found in the cart
        ROLLBACK;

        -- Return error message
        SELECT 'Error: Item not found in the cart.' AS Message;
    END IF;
END //

DELIMITER ;
--StoredProcedure(DeletefromCart)
DELIMITER //

CREATE PROCEDURE DeleteFromCart(IN p_CustomerID INT, IN p_ProductID INT)
BEGIN
    DECLARE currentQuantity INT;

    -- Start transaction
    START TRANSACTION;

    -- Get current quantity in the cart
    SELECT Quantity INTO currentQuantity
    FROM CART
    WHERE CustomerID = p_CustomerID AND Product_ID = p_ProductID;

    -- Check if the item exists in the cart
    IF currentQuantity IS NOT NULL THEN
        -- Adjust stock level in inventory
        UPDATE Inventory
        SET Stock_Level = Stock_Level + currentQuantity
        WHERE Product_ID = p_ProductID;

        -- Delete item from the cart
        DELETE FROM CART
        WHERE CustomerID = p_CustomerID AND Product_ID = p_ProductID;

        -- Commit transaction
        COMMIT;

        -- Return success message
        SELECT 'Success: Item removed from the cart.' AS Message;
    ELSE
        -- Rollback transaction if item not found in the cart
        ROLLBACK;

        -- Return error message
        SELECT 'Error: Item not found in the cart.' AS Message;
    END IF;
END //

DELIMITER ;

--MostImportantStoredProcedure(ConfirmingOrder)
DELIMITER //

CREATE PROCEDURE ConfirmOrder(
    IN p_CustomerID INT,
    IN p_PaymentMethod VARCHAR(255),
    OUT p_SalesID INT
)
BEGIN
    DECLARE v_SalesAmount DECIMAL(10,2);
    
    -- Calculate the total sales amount from the cart
    SELECT SUM(Price*Quantity) INTO v_SalesAmount
    FROM CartView
    WHERE CustomerID = p_CustomerID;

    -- Start transaction
    START TRANSACTION;

    -- Insert into Sales table
    INSERT INTO Sales (CustomerID, SalesAmount, PaymentMethod, SalesDate)
    VALUES (p_CustomerID, v_SalesAmount, p_PaymentMethod, NOW());
    
    -- Get the last inserted SalesID
    SET p_SalesID = LAST_INSERT_ID();

    -- Insert into product_sales table
    INSERT INTO product_sales (Product_ID, Sales_ID, UnitPrice, Quantity)
    SELECT Product_ID, p_SalesID, Price, Quantity
    FROM CartView
    WHERE CustomerID = p_CustomerID;

    -- Delete entries from CART table
    DELETE FROM CART WHERE CustomerID = p_CustomerID;

    -- Commit transaction
    COMMIT;
END //

DELIMITER ;

-- Insert inventory entries with a default stock level of 100 for each product

INSERT INTO Inventory (Product_ID, Stock_Level) VALUES (1, 100);  -- Apple iPhone
INSERT INTO Inventory (Product_ID, Stock_Level) VALUES (2, 100);  -- Samsung Galaxy
INSERT INTO Inventory (Product_ID, Stock_Level) VALUES (3, 100);  -- Google Pixel

INSERT INTO Inventory (Product_ID, Stock_Level) VALUES (4, 100);  -- Apple MacBook
INSERT INTO Inventory (Product_ID, Stock_Level) VALUES (5, 100);  -- Dell XPS
INSERT INTO Inventory (Product_ID, Stock_Level) VALUES (6, 100);  -- HP Spectre

INSERT INTO Inventory (Product_ID, Stock_Level) VALUES (7, 100);  -- Lenovo ThinkPad
INSERT INTO Inventory (Product_ID, Stock_Level) VALUES (8, 100);  -- HP Omen
INSERT INTO Inventory (Product_ID, Stock_Level) VALUES (9, 100);  -- Dell Inspiron

INSERT INTO Inventory (Product_ID, Stock_Level) VALUES (10, 100); -- Apple iPad
INSERT INTO Inventory (Product_ID, Stock_Level) VALUES (11, 100); -- Samsung Galaxy Tab
INSERT INTO Inventory (Product_ID, Stock_Level) VALUES (12, 100); -- Microsoft Surface Pro

INSERT INTO Inventory (Product_ID, Stock_Level) VALUES (13, 100); -- Sony PlayStation
INSERT INTO Inventory (Product_ID, Stock_Level) VALUES (14, 100); -- Microsoft Xbox
INSERT INTO Inventory (Product_ID, Stock_Level) VALUES (15, 100); -- Nintendo Switch

INSERT INTO Inventory (Product_ID, Stock_Level) VALUES (16, 100); -- Alienware Gaming PC
INSERT INTO Inventory (Product_ID, Stock_Level) VALUES (17, 100); -- HP Omen Gaming PC
INSERT INTO Inventory (Product_ID, Stock_Level) VALUES (18, 100); -- Razer Gaming PC

INSERT INTO Inventory (Product_ID, Stock_Level) VALUES (19, 100); -- Bose QuietComfort 35
INSERT INTO Inventory (Product_ID, Stock_Level) VALUES (20, 100); -- Sony WH-1000XM4
--Stored Procedure For Sign Up
DELIMITER //

CREATE PROCEDURE SignUp(
    IN p_FirstName VARCHAR(255),
    IN p_LastName VARCHAR(255),
    IN p_Email VARCHAR(255),
    IN p_House_Number VARCHAR(50),
    IN p_Street_Name VARCHAR(255),
    IN p_Pincode VARCHAR(10),
    IN p_City VARCHAR(255),
    IN p_Password VARCHAR(255),
    IN p_PhoneNumbers TEXT  -- This should be a comma-separated list of phone numbers
)
BEGIN
    DECLARE new_Customer_ID INT;
    DECLARE phone_number VARCHAR(15);
    
    -- Declare the cursor for splitting phone numbers
    DECLARE phone_numbers_cursor CURSOR FOR
        SELECT TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(p_PhoneNumbers, ',', numbers.n), ',', -1)) 
        FROM (
            SELECT 1 AS n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5
            UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10
        ) numbers
        WHERE CHAR_LENGTH(p_PhoneNumbers) - CHAR_LENGTH(REPLACE(p_PhoneNumbers, ',', '')) >= numbers.n - 1;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET phone_number = NULL;

    -- Insert into the Customer table
    INSERT INTO Customers (FirstName, LastName, Email, CreatedDate, House_Number, Street_Name, Pincode, City, Password)
    VALUES (p_FirstName, p_LastName, p_Email, NOW(), p_House_Number, p_Street_Name, p_Pincode, p_City, p_Password);
    
    -- Get the last inserted Customer_ID
    SET new_Customer_ID = LAST_INSERT_ID();

    -- Insert phone numbers into the Phone table
    IF p_PhoneNumbers IS NOT NULL THEN
        OPEN phone_numbers_cursor;

        read_loop: LOOP
            FETCH phone_numbers_cursor INTO phone_number;
            IF phone_number IS NULL THEN
                LEAVE read_loop;
            END IF;

            INSERT INTO CUSTOMER_PHONE (Customer_ID, Phone_Number)
            VALUES (new_Customer_ID, phone_number);
        END LOOP;

        CLOSE phone_numbers_cursor;
    END IF;

END //

DELIMITER ;

--Stored procedure for Adding Reviews
DELIMITER //

CREATE PROCEDURE AddReview(
    IN p_CustomerID INT,
    IN p_ProductID INT,
    IN p_Rating INT,
    IN p_ReviewText TEXT
)
BEGIN
    -- Insert the new review into the REVIEW table
    INSERT INTO REVIEW (CustomerID, ProductID, Rating, ReviewText)
    VALUES (p_CustomerID, p_ProductID, p_Rating, p_ReviewText);

    -- Return success message
    SELECT 'Success: Review added.' AS Message;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE AddProductAndInventory(
    IN p_Product_Name VARCHAR(255),
    IN p_Quantity INT,
    IN p_Price DECIMAL(10, 2)
)
BEGIN
    DECLARE last_id INT;

    -- Insert into Products table
    INSERT INTO Products (Product_Name, Price) VALUES (p_Product_Name, p_Price);
    
    -- Get the last inserted Product_ID
    SET last_id = LAST_INSERT_ID();

    -- Insert into Inventory table
    INSERT INTO Inventory (Product_ID, Stock_Level, DateChanged) VALUES (last_id, p_Quantity, NOW());
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE UpdateProductInventory(
    IN p_Product_ID INT,
    IN p_New_Quantity INT,
    IN p_New_Product_Name VARCHAR(255),
    IN p_New_Price DECIMAL(10, 2)
)
BEGIN
    -- Update the Inventory table
    UPDATE Inventory 
    SET Stock_Level = p_New_Quantity, DateChanged = NOW()
    WHERE Product_ID = p_Product_ID;

    -- Update the Products table
    UPDATE Products 
    SET Product_Name = p_New_Product_Name, Price = p_New_Price
    WHERE Product_ID = p_Product_ID;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE AddProductWithCategory(
    IN p_Product_Name VARCHAR(255),
    IN p_Quantity INT,
    IN p_Price DECIMAL(10, 2),
    IN p_Super_Category VARCHAR(255),
    IN p_Category_Name VARCHAR(255),
    IN p_Image VARCHAR(255)  -- New parameter for image link
)
BEGIN
    DECLARE last_id INT;
    DECLARE cat_id INT;

    -- Insert into Products table with image link
    INSERT INTO Products (Product_Name, Price, Image) VALUES (p_Product_Name, p_Price, p_Image);
    -- Get the last inserted Product_ID
    SET last_id = LAST_INSERT_ID();

    -- Debugging outputs for parameters
    SELECT TRIM(p_Super_Category) AS DebugSuperCategory, 
           TRIM(p_Category_Name) AS DebugCategoryName;

    -- Retrieve the Category_ID based on Super_Category and Category_Name	
    SELECT Category_ID INTO cat_id
    FROM Category
    WHERE Super_Category = p_Super_Category 
      AND Category_Name = p_Category_Name;
 
    -- Debug output for Category_ID
    SELECT cat_id AS DebugCategoryID;  -- Output the category_id

    -- If category is found, insert into PRODUCT_CATEGORY table
    IF cat_id IS NOT NULL THEN
        INSERT INTO PRODUCT_CATEGORY (Product_ID, Category_ID) VALUES (last_id, cat_id);
    ELSE
        -- Handle the case where category is not found
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Category not found';
    END IF;

    -- Insert into Inventory table
    INSERT INTO Inventory (Product_ID, Stock_Level, DateChanged) VALUES (last_id, p_Quantity, NOW());
END //

DELIMITER ;

DELIMITER ;

ALTER TABLE Products
ADD COLUMN image VARCHAR(250);

UPDATE Products
SET image = "https://pngimg.com/d/iphone_12_PNG36.png"
WHERE product_id = 1;

UPDATE Products
SET image = " https://purepng.com/public/uploads/large/samsung-galaxy-s10-prism-front-6bx.png"
WHERE product_id = 2;

 UPDATE Products set IMAGE="https://www.pngarts.com/files/11/Android-Google-Pixel-Phone-PNG-Image-Background.png"
WHERE PRODUCT_ID=3;

UPDATE Products set IMAGE="https://i.pinimg.com/originals/b2/39/21/b2392123978a9779bb008b049c57fbec.png" WHERE PRODUCT_ID=4;


UPDATE Products set IMAGE= "https://png.pngitem.com/pimgs/s/297-2978265_dell-laptop-png-images-dell-xps-15-9570.png" WHERE PRODUCT_ID=5;


UPDATE Products set IMAGE= "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8f/Dell_XPS_13_%282018%29.png/627px-Dell_XPS_13_%282018%29.png" WHERE PRODUCT_ID=5;


UPDATE Products set IMAGE= "https://ssl-product-images.www8-hp.com/digmedialib/prodimg/lowres/c08881381.png?impolicy=Png_Res&imwidth=270&imdensity=1" WHERE PRODUCT_ID=6;


UPDATE Products set IMAGE= "https://www.pngfind.com/pngs/b/123-1233475_2796-pngwe-lenovo-laptop-thinkpad-l580-hero-lenovo.png" WHERE PRODUCT_ID=7;


UPDATE Products set IMAGE= "https://in-media.apjonlinecdn.com/catalog/product/cache/b3b166914d87ce343d4dc5ec5117b502/c/0/c08509690_1_1_6.png" WHERE PRODUCT_ID=8;

UPDATE Products set IMAGE= "https://i.dell.com/is/image/DellContent/content/dam/images/products/laptops-and-2-in-1s/inspiron/15-3505-non-touch/in3505nt-cnb-00000ff090-gr.psd?qlt=95&fit=constrain,1&hei=2122&wid=3679&fmt=png-alpha" WHERE PRODUCT_ID=9;

 UPDATE Products set IMAGE= "https://store.storeimages.cdn-apple.com/8756/as-images.apple.com/is/ipad-2022-hero-silver-wifi-select_FMT_WHH?wid=940&hei=1112&fmt=png-alpha&.v=1664387253605" WHERE PRODUCT_ID=10;

  UPDATE Products set IMAGE= "https://img.us.news.samsung.com/us/wp-content/uploads/2017/02/14162235/Galaxy-Tab-S3_001.png" WHERE PRODUCT_ID=11;
 UPDATE Products set IMAGE= "https://5.imimg.com/data5/SELLER/Default/2021/2/BU/RS/XF/122278461/microsoft-surface-pro-7.png" WHERE PRODUCT_ID=12;

 UPDATE Products set IMAGE= "https://media.croma.com/image/upload/v1697022147/Croma%20Assets/Gaming/Gaming%20Consoles/Images/265330_0_t7qy1t.png" WHERE PRODUCT_ID=13;

UPDATE Products set IMAGE= "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/Xbox-360-Pro-wController.png/1370px-Xbox-360-Pro-wController.png" WHERE PRODUCT_ID=14;

UPDATE Products set IMAGE= "https://upload.wikimedia.org/wikipedia/commons/b/bc/Nintendo-Switch-wJoyCons-BlRd-Standing-FL.png"
 WHERE PRODUCT_ID=15;

UPDATE Products set IMAGE= "https://media.alienwarearena.com/media/2022/09/Picture1.png" WHERE PRODUCT_ID=16;

 UPDATE Products set IMAGE= "https://au-files.apjonlinecdn.com/landingpages/content-pages/visid-rich-content/hp-omen-25l-desktop/images/w100_product_highlight.png" WHERE PRODUCT_ID=17;

  UPDATE Products set IMAGE= "https://www.empoweredpc.com/wp-content/uploads/2024/03/Panorama_angle_aqua_1200-600x674.png" WHERE PRODUCT_ID=18;

 UPDATE Products set IMAGE= "https://assets.bose.com/content/dam/cloudassets/Bose_DAM/Web/consumer_electronics/global/products/headphones/qc-headphonearn/product_silo_image/AEM_qc-headphonearn_PDP_GALLERY_BLACK-1.png/_jcr_content/renditions/cq5dam.web.320.320.png" WHERE PRODUCT_ID=19;

  UPDATE Products set IMAGE= "https://www.sony.co.in/image/f3f1e4cde7ef052790bfd64ce85f39bb?fmt=png-alpha&wid=1200" WHERE PRODUCT_ID=20;   

UPDATE Products set IMAGE= "https://www.sennheiser.com/globalassets/digizuite/38361-en-hd_280_pro_product_shot_cutout_isofront.png.png/SennheiserFullWidth" WHERE PRODUCT_ID=21;


UPDATE Products set IMAGE= "https://www.pngplay.com/wp-content/uploads/6/JBL-Audio-Speakers-Transparent-PNG.png" WHERE PRODUCT_ID=22;


UPDATE Products set IMAGE= "https://assets.bose.com/content/dam/Bose_DAM/Web/consumer_electronics/global/products/speakers/bose_portable_home_speaker/product_silo_images/bose_portable_home_speaker_black_EC_hero.psd/_jcr_content/renditions/cq5dam.web.320.320.png" WHERE PRODUCT_ID=23;


UPDATE Products set IMAGE= "https://media.sonos.com/images/znqtjj88/production/029f523de980751d0ea6b1866e7f3b4bc806277d-2000x1362.png?w=3840&q=100&fit=clip&auto=format" WHERE PRODUCT_ID=24;           


UPDATE Products set IMAGE= "https://www.sony-asia.com/image/60fc808004d6860e433b5a4cafeb60d2?fmt=png-alpha&resMode=bisharp&wid=384" WHERE PRODUCT_ID=25;


UPDATE Products set IMAGE= "https://media.croma.com/image/upload/v1714043192/Croma%20Assets/Entertainment/Television/Images/303778_0_vsshc9.png" WHERE PRODUCT_ID=26;

UPDATE Products set Product_Name="LG TV" WHERE Product_ID=26;


UPDATE Products set IMAGE= "https://images.samsung.com/is/image/samsung/p6pim/in/qa55q60daulxl/gallery/in-qled-q60d-qa55q60daulxl-539976106?$650_519_PNG$" WHERE PRODUCT_ID=27;

UPDATE Products set IMAGE= "https://www.otterbox.com/on/demandware.static/-/Sites-ob_us-Library/default/dwa9396fbf/2024_Files/series_tiles/defender-xt-iphd23-black-2.png" WHERE PRODUCT_ID=28;


UPDATE Products set IMAGE= "https://media-ik.croma.com/prod/https://media.croma.com/image/upload/v1686842583/Croma%20Assets/Communication/Mobile%20Accessories/Images/264143_0_iqf17f.png" WHERE PRODUCT_ID=29;



UPDATE Products set IMAGE= "https://media-ik.croma.com/prod/https://media.croma.com/image/upload/v1718868411/Croma%20Assets/Communication/Mobile%20Accessories/Images/305942_rzmu41.png" WHERE PRODUCT_ID=30;

 update products set product_name="Portonics" where Product_ID=31;


 UPDATE Products set IMAGE= "https://www.ravpower.com/cdn/shop/files/RP-PC151_png_1f102174-b175-4efb-975d-827321b8d62b.png?v=1697529205" WHERE PRODUCT_ID=32;


UPDATE Products set IMAGE= "https://media.croma.com/image/upload/v1675859289/Croma%20Assets/Communication/Chargers%20and%20Batteries/Images/250442_0_q27pog.png" WHERE PRODUCT_ID=31;


UPDATE Products set IMAGE= "https://media.croma.com/image/upload/v1689152382/Croma%20Assets/Computers%20Peripherals/Chargers%20and%20Batteries/Images/271261_0_eotlnt.png" WHERE PRODUCT_ID=33;


UPDATE Products set IMAGE= "https://lh4.googleusercontent.com/proxy/nSOwP9HF6OP-itPHBnHJkjp26uJLX27FIqGHea-dDAvuSswxOLi0nAj21R3stJs1Cx66f_CUlL-sNcx1wude6FCDgYlEJCKC" WHERE PRODUCT_ID=34;


UPDATE Products set IMAGE= "https://www.pngarts.com/files/9/Smartphone-Power-Bank-Transparent-Images.png" WHERE PRODUCT_ID=35;



 UPDATE Products set IMAGE="https://media.croma.com/image/upload/v1703082699/Croma%20Assets/Communication/PowerBank/Images/275990_9_qwir4y.png" WHERE PRODUCT_ID=36;

 UPDATE Products set IMAGE="https://cdn.shopify.com/s/files/1/0765/2137/3999/products/A8843011-Anker_762_USB-C_to_Lightning_Cable_3ft_6ft_Nylon_1.png?v=1683859277" WHERE PRODUCT_ID=37;

 UPDATE Products set IMAGE="https://cdn.shopify.com/s/files/1/0765/2137/3999/products/A8843011-Anker_762_USB-C_to_Lightning_Cable_3ft_6ft_Nylon_1.png?v=1683859277" WHERE PRODUCT_ID=37;


 UPDATE Products set IMAGE="https://media-ik.croma.com/prod/https://media.croma.com/image/upload/v1696518308/Croma%20Assets/Communication/Cables%20and%20Connectors/Images/236195_0_m9jkzt.png" WHERE PRODUCT_ID=38;


 UPDATE Products set IMAGE="https://eu.ugreen.com/cdn/shop/products/ugreen-usb-c-usb-c-charging-cable-100w-double-angle-plug-pd-30-qc-40-757297.png?v=1697187428" WHERE PRODUCT_ID=39;
 UPDATE Products set IMAGE="https://png.pngtree.com/png-clipart/20211017/original/pngtree-mobile-phone-charger-stereo-black-png-image_6855506.png" WHERE PRODUCT_ID=40;


UPDATE Products set IMAGE="https://png.pngtree.com/png-vector/20240625/ourmid/pngtree-usb-charger-3d-pic-png-image_12843887.png" WHERE PRODUCT_ID=41;


 UPDATE Products set IMAGE="https://www.mtech.am/assets/images/75/75d90d_ugreen-usb-c-to-ethernet-adapter-642856.png" WHERE PRODUCT_ID=42;
 
 UPDATE Products set IMAGE="https://cdn.shoplightspeed.com/shops/645668/files/53880946/image.jpg" WHERE PRODUCT_ID=43;
 
 UPDATE Products set IMAGE="https://m.media-amazon.com/images/I/7192eSVBsGL.jpg" WHERE PRODUCT_ID=44;
 
  UPDATE Products set IMAGE="https://images-cdn.ubuy.co.in/63c6eaf5c41ea11c75185a93-jetech-screen-protector-for-iphone-11.jpg" WHERE PRODUCT_ID=45;
  
  UPDATE Products set IMAGE="https://store.storeimages.cdn-apple.com/4668/as-images.apple.com/is/apple-pencil-pro-splitter-202405_FMT_WHH?wid=448&hei=800&fmt=png-alpha&.v=1713420587746" WHERE PRODUCT_ID=46;

    UPDATE Products set IMAGE="https://cdn-media.wacom.com/-/media/images/carousels/homepage-a-slots/2020/2020-image-redux/bamboo-ink-plus-m-mobile.jpg?h=450&iar=0&w=726&rev=ebc21d9c2acd4d1fa53e3f6e9620f8f9&hash=8F3844FC87BE8FF37222FB6D4D709F52" WHERE PRODUCT_ID=47;

    UPDATE Products set IMAGE="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTU5fdqa-fiTUl7eW5DOBaiaFirPIfd2Rky7g&s" WHERE PRODUCT_ID=48;
    
        UPDATE Products set IMAGE="https://www.pngplay.com/wp-content/uploads/9/Apple-Watch-Transparent-Free-PNG.png" WHERE PRODUCT_ID=49;
        
           UPDATE Products set IMAGE="https://images.samsung.com/is/image/samsung/p6pim/in/2208/gallery/in-galaxy-watch5-40mm-sm-r900nzsainu-533186491?$650_519_PNG$" WHERE PRODUCT_ID=50;
           
	UPDATE Products set IMAGE="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTJnu4fJI5COWXCfVGHW4njOGJfTm1VLXUy_w&s" WHERE PRODUCT_ID=51;          
           
                   UPDATE Products set IMAGE="https://www.fitbit.com/global/content/dam/fitbit/global/pdp/devices/charge-5/hero-static/charge5-black-device-3qtr.png" WHERE PRODUCT_ID=52;
                   
				UPDATE Products set IMAGE="https://ph.garmin.com/m/ph/g/products/vivosmart4-black-iamge-01.png" WHERE PRODUCT_ID=53;    
                
                	UPDATE Products set IMAGE="https://png.pngtree.com/png-vector/20240802/ourmid/pngtree-xiaomi-mi-smart-band-png-image_13320417.png" WHERE PRODUCT_ID=54;    
                    
                    	UPDATE Products set IMAGE="https://i.pcmag.com/imagery/articles/02hgFllAGyzcSi6NOuOkI9c-1.fit_lim.size_1938x1092.v_1569470686.jpg" WHERE PRODUCT_ID=55;    
                        
			UPDATE Products set IMAGE="https://www.vuzix.com/cdn/shop/products/Blade-ALpng-LowLQuarter_f56be174-947e-4daf-9eb4-e13a55094595.png?v=1687370745" WHERE PRODUCT_ID=56;
            
            UPDATE Products set IMAGE="https://assets.bose.com/content/dam/cloudassets/Bose_DAM/Web/consumer_electronics/global/products/wearables/bose_frames_tempo/product_silo_images/tempo_product_page_ec_hero_1200x1022.png/jcr:content/renditions/cq5dam.web.1920.1920.png" WHERE PRODUCT_ID=57;
            
            UPDATE Products set IMAGE="https://png.pngtree.com/png-clipart/20230508/original/pngtree-airpods-png-image_9149137.png" WHERE PRODUCT_ID=58;
            
            UPDATE Products set IMAGE="https://atlas-content-cdn.pixelsquid.com/stock-images/samsung-galaxy-buds-live-earphones-koaqx33-600.jpg" WHERE PRODUCT_ID=59;
            
            UPDATE Products set IMAGE="https://media-ik.croma.com/prod/https://media.croma.com/image/upload/v1718788316/Croma%20Assets/Entertainment/Wireless%20Earbuds/Images/301580_0_eu3o0d.png?tr=w-600" WHERE PRODUCT_ID=60;
            
            UPDATE Products set IMAGE="https://media.croma.com/image/upload/v1675867689/Croma%20Assets/Entertainment/Speakers%20and%20Media%20Players/Images/230161_0_arf7hi.png" WHERE PRODUCT_ID=61;
            
            UPDATE Products set IMAGE="https://lh3.googleusercontent.com/Eg_xq-CBLO2X7br8h7Beuk8mQ0C2PfiPSKrBxfWpbdBwAvlWFWnN_IApunu881OVRnDg=w250" WHERE PRODUCT_ID=62;
            
            UPDATE Products set IMAGE="https://www.pngitem.com/pimgs/m/412-4120713_ring-video-doorbell-png-transparent-png.png" WHERE PRODUCT_ID=63;
            
            UPDATE Products set IMAGE="https://www.homemedialimited.co.uk/wp-content/uploads/2019/01/one-feature-blk.png" WHERE PRODUCT_ID=64;
            
            UPDATE Products set IMAGE="https://assets.bose.com/content/dam/Bose_DAM/Web/consumer_electronics/global/general/Datacapture/bose_soundbar_700_black_EC_hero.psd/_jcr_content/renditions/cq5dam.web.320.320.png" WHERE PRODUCT_ID=65;
            
            UPDATE Products set IMAGE="https://avshack.in/cdn/shop/products/411820_2_a4cd_jpg.png?v=1645615544&width=1214" WHERE PRODUCT_ID=66;
            
            UPDATE Products set IMAGE="https://images.samsung.com/is/image/samsung/p6pim/in/rs7fcg8113slhl/gallery/in-side-by-side-family-hub-rs7fcg8113slhl-535086472?$650_519_PNG$" WHERE PRODUCT_ID=67;
            
            UPDATE Products set IMAGE="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdRHvQ9fupA7LTb8amdUqhTD5IBpCQcgmzdA&s" WHERE PRODUCT_ID=68;
            
            UPDATE Products set IMAGE="https://images.keurig.com/is/image/keurig/K-Elite-Single-Serve-Coffee-Maker_5000359832?fmt=png-alpha" WHERE PRODUCT_ID=69;
            
            UPDATE Products set IMAGE="https://atlas-content-cdn.pixelsquid.com/stock-images/ring-video-doorbell-XllBq82-600.jpg" WHERE PRODUCT_ID=70;
            
            UPDATE Products set IMAGE="https://www.arlo.com/dw/image/v2/BDFZ_PRD/on/demandware.static/-/Sites-master-catalog-arlo/default/dwbdbaf08b/Products/HiRes%20Images/Go/2023/04%20-%20GO%202%20LTE%20-%20Wireless%20Camera.png?sw=375&sh=323&sm=fit" WHERE PRODUCT_ID=71;
            
            UPDATE Products set IMAGE="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfe9uAUCjCJ9gY7puGM9z-ZAJ-lEnXq_YQeQ&s" WHERE PRODUCT_ID=72;
            
            UPDATE Products set IMAGE="https://www.security.org/app/uploads/2019/07/SimpliSafe-Home-Security-System.png" WHERE PRODUCT_ID=73;

UPDATE SALES
SET SalesDate = DATE_ADD(SalesDate, INTERVAL 1 YEAR)
WHERE YEAR(SalesDate) = 2023;
-- CUSTOMERSALESOVERVIEW
CREATE VIEW CustomerSalesOverview AS
SELECT 
    C.Customer_ID,
    C.FirstName,
    C.LastName,
    C.Email,
    C.House_Number,
    C.Street_Name,
    C.City,
    C.Pincode,
    COUNT(S.SalesID) AS NumberOfSales,
    SUM(S.SalesAmount) AS TotalSpent,
    MAX(S.SalesDate) AS LastPurchaseDate
FROM 
    CUSTOMERS C
LEFT JOIN 
    SALES S ON C.Customer_ID = S.CustomerID
GROUP BY 
    C.Customer_ID;


-- Stored Procedure for Customer Report Generation
DELIMITER $$

CREATE PROCEDURE GenerateCustomerReport(
    IN reportType VARCHAR(50)  -- Removed customer_ID parameter as it's no longer needed
)
BEGIN
    CASE reportType
        -- Customer Demographic Report
        WHEN 'CustomerDemographic' THEN
            SELECT City, COUNT(Customer_ID) AS NumberOfCustomers
            FROM CustomerSalesOverview
            GROUP BY City
            ORDER BY NumberOfCustomers DESC
            LIMIT 10;

        -- Top Customers by Amount
        WHEN 'TopCustomersByAmount' THEN
            SELECT FirstName, LastName, Email, TotalSpent
            FROM CustomerSalesOverview
            ORDER BY TotalSpent DESC
            LIMIT 10;

        -- Frequent Customers by Sales
        WHEN 'FrequentCustomers' THEN
            SELECT FirstName, LastName, Email, NumberOfSales
            FROM CustomerSalesOverview
            ORDER BY NumberOfSales DESC
            LIMIT 10;

        -- All Customers Report
        WHEN 'AllCustomers' THEN
            SELECT FirstName, LastName, Email, House_Number, Street_Name , City , Pincode
            FROM CustomerSalesOverview;

        -- Inactive Customers Report
        WHEN 'InactiveCustomers' THEN
            SELECT FirstName,LastName,Email
            FROM CustomerSalesOverview
            WHERE LastPurchaseDate < DATE_SUB(CURRENT_DATE, INTERVAL 1 MONTH) 
             OR LastPurchaseDate IS NULL;

        ELSE
            SELECT 'Invalid report type.' AS ErrorMessage;
    END CASE;
END $$

DELIMITER ;


-- StoredProcedure For Product Report Generation
DELIMITER $$

CREATE PROCEDURE GetProductReports(
    IN reportType VARCHAR(50),
    IN startDate DATE,
    IN endDate DATE
)
BEGIN
    CASE reportType
        -- All Products (Ignore Date)
        WHEN 'AllProducts' THEN
            SELECT p.Product_ID, p.Product_Name, p.Price
            FROM PRODUCTS p;

        -- Top Selling Products (With Date Filter)
        WHEN 'TopSelling' THEN
            SELECT p.Product_ID, p.Product_Name, SUM(ps.Quantity) AS TotalSold
            FROM PRODUCTS p
            JOIN PRODUCT_SALES ps ON p.Product_ID = ps.Product_ID
            WHERE ps.Sales_ID IN (SELECT SalesID FROM SALES WHERE SalesDate BETWEEN startDate AND endDate)
            GROUP BY p.Product_ID
            ORDER BY TotalSold DESC
            LIMIT 10;  -- Adjust the limit as necessary

        -- Worst Selling Products (With Date Filter)
        WHEN 'WorstSelling' THEN
            SELECT p.Product_ID, p.Product_Name, IFNULL(SUM(ps.Quantity), 0) AS TotalSold
            FROM PRODUCTS p
            LEFT JOIN PRODUCT_SALES ps ON p.Product_ID = ps.Product_ID
            LEFT JOIN SALES s ON ps.Sales_ID = s.SalesID AND s.SalesDate BETWEEN startDate AND endDate
            GROUP BY p.Product_ID
            ORDER BY TotalSold ASC
            LIMIT 10;

        -- Products with Best Reviews (Ignore Date)
        WHEN 'BestReviews' THEN
            SELECT p.Product_ID, p.Product_Name, IFNULL(AVG(r.Rating), 0) AS AverageRating
            FROM PRODUCTS p
            JOIN REVIEW r ON p.Product_ID = r.ProductID
            GROUP BY p.Product_ID
            ORDER BY AverageRating DESC
            LIMIT 10;  -- Adjust the limit as necessary

        -- Products with Worst Reviews (Ignore Date)
        WHEN 'WorstReviews' THEN
            SELECT p.Product_ID, p.Product_Name, IFNULL(AVG(r.Rating), 0) AS AverageRating
            FROM PRODUCTS p
            JOIN REVIEW r ON p.Product_ID = r.ProductID
            GROUP BY p.Product_ID
            ORDER BY AverageRating ASC
            LIMIT 10;  -- Adjust the limit as necessary

        ELSE
            SELECT 'Invalid report type' AS ErrorMessage;
    END CASE;
END $$

DELIMITER ;
-- Trigger For Deleting Sales
DELIMITER //

CREATE TRIGGER delete_related_product_sales
AFTER DELETE ON Sales
FOR EACH ROW
BEGIN
    DELETE FROM Product_Sales WHERE sales_id = OLD.salesid;
END //

DELIMITER ;

-- View For CategoryReports
CREATE VIEW ProductSalesWithCategories AS
SELECT
    s.SalesID,
    s.CustomerID,
    s.SalesAmount,
    s.SalesDate,
    ps.Product_ID,
    ps.Quantity,
    ps.UnitPrice,
    (ps.Quantity * ps.UnitPrice) AS TotalSaleAmount,
    c.Category_Name AS SubCategory,
    c.Super_Category AS MainCategory
FROM
    SALES s
JOIN
    PRODUCT_SALES ps ON s.SalesID = ps.Sales_ID
JOIN
    PRODUCTS p ON ps.Product_ID = p.Product_ID
JOIN
    PRODUCT_CATEGORY pc ON p.Product_ID = pc.Product_ID
JOIN
    CATEGORY c ON pc.Category_ID = c.Category_ID;


-- StoredProcedure For Categories
DELIMITER //

CREATE PROCEDURE GetCategoryReports(
    IN reportType VARCHAR(50),
    IN startDate DATE,
    IN endDate DATE
)
BEGIN

    -- Query for All Categories
    IF reportType = 'AllCategories' THEN
        SELECT DISTINCT 
            c.Super_Category AS Category
        FROM 
            CATEGORY c;

    -- Query for All Subcategories
    ELSEIF reportType = 'AllSubcategories' THEN
        SELECT 
            c.Category_Name AS SubCategory
        FROM 
            CATEGORY c;

    -- Query for Top-Selling Categories (Main Categories) with date filtering
    ELSEIF reportType = 'TopSellingCategories' THEN
        SELECT
            MainCategory,
            SUM(TotalSaleAmount) AS TotalSales
        FROM
            ProductSalesWithCategories
        WHERE
            SalesDate BETWEEN startDate AND endDate
        GROUP BY
            MainCategory
        ORDER BY
            TotalSales DESC
        LIMIT 10;  -- Adjust limit as needed

    -- Query for Top-Selling Subcategories with date filtering
    ELSEIF reportType = 'TopSellingSubcategories' THEN
        SELECT
            SubCategory AS CATEGORY,
            SUM(TotalSaleAmount) AS TotalSales
        FROM
            ProductSalesWithCategories
        WHERE
            SalesDate BETWEEN startDate AND endDate
        GROUP BY
            MainCategory, SubCategory
        ORDER BY
            TotalSales DESC
        LIMIT 10;  -- Adjust limit as needed

    ELSE
        SELECT 'Invalid report type' AS ErrorMessage;
    END IF;
END //

DELIMITER ;

-- StoredProcedure for SalesReportGeneration
DELIMITER //

CREATE PROCEDURE GetSalesReports(
    IN reportType VARCHAR(50),
    IN startDate DATE,
    IN endDate DATE
)
BEGIN
    IF reportType = 'AllSales' THEN
        SELECT *
        FROM Sales
        WHERE SalesDate BETWEEN startDate AND endDate;

    ELSEIF reportType = 'DemographicSales' THEN
        SELECT
            c.City,
            COUNT(s.SalesID) AS NumberOfSales,
            SUM(s.SalesAmount) AS TotalSalesAmount
        FROM Sales s
        JOIN Customers c ON s.CustomerID = c.Customer_ID
        WHERE s.SalesDate BETWEEN startDate AND endDate
        GROUP BY c.City
        ORDER BY NumberOfSales DESC;

    ELSEIF reportType = 'BestSales' THEN
        SELECT *
        FROM Sales
        WHERE SalesDate BETWEEN startDate AND endDate
        ORDER BY SalesAmount DESC
        LIMIT 10;

    ELSEIF reportType = 'SalesByPaymentMethod' THEN
        SELECT
            PaymentMethod,
            COUNT(SalesID) AS NumberOfSales,
            SUM(SalesAmount) AS TotalSalesAmount
        FROM Sales
        WHERE SalesDate BETWEEN startDate AND endDate
        GROUP BY PaymentMethod;

    ELSEIF reportType = 'SalesSummary' THEN
        SELECT
            COUNT(SalesID) AS TotalTransactions,
            SUM(SalesAmount) AS TotalSalesAmount,
            AVG(SalesAmount) AS AverageAmountPerTransaction
        FROM Sales
        WHERE SalesDate BETWEEN startDate AND endDate;

    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid report type specified.';
    END IF;
END //

DELIMITER ;