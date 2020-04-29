-- Group 98
-- Author: 
-- 		Bonan Liu  490219874
-- 		Dayun Liu  490536519
-- 		Qijing Yan 490332368
-- Date: 29/04/2020


CREATE TABLE Courier(
	-- SET CourierId as primary key
	CourierId INTEGER PRIMARY KEY,
	Name VARCHAR(50) NOT NULL,
	Address VARCHAR(100),
	Mobile INTEGER
);

CREATE TABLE Delivery(
	-- SET DeliveryId as primary key
	DeliveryId INTEGER PRIMARY KEY,
	TimeReady TIMESTAMP NOT NULL,
	TimeDelivered TIMESTAMP NOT NULL,
	-- Set CourierId as FK
	-- Set ON DELETE on CourierId
	-- Delete CourierId and the delivery will also deleted
	CourierId INTEGER NOT NULL,
	CONSTRAINT FK_CourierId FOREIGN KEY (CourierId) 
							REFERENCES Courier
							ON DELETE CASCADE,
	CONSTRAINT Time_Check CHECK (TimeReady < TimeDelivered)
);

CREATE TABLE Staff(
	--table Staff--
	--set StaffID as PRIMARY KEY--
	StaffID INTEGER PRIMARY KEY,
	Name VARCHAR(50) NOT NULL,
	Position VARCHAR(50)
);


CREATE TABLE Places(
	--table Places--
	--set CustomerID, OrderID as PRIMARY KEY--
	--set StaffID as FOREIGN KEY--
	--set DeliveryID as FOREIGN KEY--
	CustomerID INTEGER,
	OrderID INTEGER,
	StaffID INTEGER NOT NULL,
	DeliveryID INTEGER NOT NULL,
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	MobileNumber VARCHAR(50) NOT NULL,
	DateTime TIMESTAMP NOT NULL,
	Address VARCHAR(100),
	TotalCharge REAL NOT NULL,
	PRIMARY KEY (CustomerID, OrderID),
	FOREIGN KEY (StaffID) REFERENCES Staff,
	FOREIGN KEY (DeliveryID) REFERENCES Delivery
);


CREATE TABLE MenuItem(
	--SET MenuItemID as PK
	--SET Integrity Constraint on Type
	MenuItemID INTEGER PRIMARY KEY,
	Name VARCHAR(50) NOT NULL,
	Price REAL NOT NULL,
	Description VARCHAR(50),
	Type VARCHAR(50) NOT NULL CHECK(Type IN('Main', 'Side', 'Dessert'))
);

CREATE TABLE Menu(
	--SET MenuID as PK
	--SET MenuItemID as FK
	--SET ON DELETE clause on MenuItemID
	MenuID INTEGER PRIMARY KEY,
	Description VARCHAR(50),
	MenuItemID INTEGER NOT NULL,
	CONSTRAINT FK_MenuItem FOREIGN KEY (MenuItemID) REFERENCES MenuItem ON DELETE CASCADE
);

CREATE TABLE OrderItem(
	--SET Composite primary key (OrderID, OrderItemID)
	--SET MenuItemID as FK
	--SET OrderID as FK
	OrderID INTEGER,
	CustomerID INTEGER,
	OrderItemID INTEGER,
	Quantity INTEGER NOT NULL,
	Charge REAL NOT NULL,
	MenuItemID INTEGER NOT NULL,
	PRIMARY KEY (OrderID, OrderItemID),
	FOREIGN KEY (MenuItemID) REFERENCES MenuItem(MenuItemID),
	FOREIGN KEY (OrderID,CustomerID) REFERENCES Places(OrderID,CustomerID)
);


-- Insert value for Courier
INSERT INTO Courier VALUES (001,'David', '5 Hume Rd', 0427983610);
INSERT INTO Courier VALUES (002,'Liam', '52 River Rd', 0433627983);
INSERT INTO Courier VALUES (003,'Aria', '72 Harmony St', 0427983622);
INSERT INTO Courier VALUES (004,'Luna', '1 Unwin St', 0427983615);
INSERT INTO Courier VALUES (005,'Oliver', '8 Mint Rd', 0479833611);

-- Insert value for Delivery
INSERT INTO Delivery VALUES (001, TO_TIMESTAMP ('10-SEP-2019 14:00','DD-MON-RRRR HH24:MI'),
							 TO_TIMESTAMP ('10-SEP-2019 14:30','DD-MON-RRRR HH24:MI'),001);
INSERT INTO Delivery VALUES (002, TO_TIMESTAMP ('01-MAY-2012 11:00','DD-MON-RRRR HH24:MI'),
							 TO_TIMESTAMP ('01-MAY-2012 11:30','DD-MON-RRRR HH24:MI'),002);
INSERT INTO Delivery VALUES (003, TO_TIMESTAMP ('11-FEB-2019 14:00','DD-MON-RRRR HH24:MI'),
							 TO_TIMESTAMP ('11-FEB-2019 14:30','DD-MON-RRRR HH24:MI'),003);							 
INSERT INTO Delivery VALUES (004, TO_TIMESTAMP ('10-DEC-2019 14:00','DD-MON-RRRR HH24:MI'),
							 TO_TIMESTAMP ('10-DEC-2019 14:30','DD-MON-RRRR HH24:MI'),004);							 		 
INSERT INTO Delivery VALUES (005, TO_TIMESTAMP ('10-SEP-2019 14:00','DD-MON-RRRR HH24:MI'),
							 TO_TIMESTAMP ('10-SEP-2019 14:30','DD-MON-RRRR HH24:MI'),005);

--insert value for staff
INSERT INTO Staff VALUES(001,'JK','Manager');
INSERT INTO Staff VALUES(002,'Scarlet','Leader');
INSERT INTO Staff VALUES(003,'Wesley','worker');
INSERT INTO Staff VALUES(004,'Adam','Worker');
INSERT INTO Staff VALUES(005,'Lucy','Worker');

--insert value for table
INSERT INTO Places VALUES(001,001,001,001,'Bonan','Liu',0433945099,TO_TIMESTAMP('10-DEC-2019','DD-MON-RRRR'),'17 Levey Street',30.23);
INSERT INTO Places VALUES(002,002,002,002,'Wesley','Wu',0433975099,TO_TIMESTAMP ('10-DEC-2019','DD-MON-RRRR'),'18 Levey Street',00.23);
INSERT INTO Places VALUES(003,003,003,003,'Cherry','Sun',0433325099,TO_TIMESTAMP ('10-DEC-2019','DD-MON-RRRR'),'19 Levey Street',21.27);
INSERT INTO Places VALUES(004,004,004,004,'Henny','Zhou',0432945099,TO_TIMESTAMP ('10-DEC-2019','DD-MON-RRRR'),'20 Levey Street',40.21);
INSERT INTO Places VALUES(005,005,005,005,'Louis','Li',0433785099,TO_TIMESTAMP ('10-DEC-2019','DD-MON-RRRR'),'07 Levey Street',32.23);

--Insert values for MenuItem
INSERT INTO MenuItem VALUES (1, 'Big Breakfast', 18.5, 'Signature Brunch', 'Main');
INSERT INTO MenuItem VALUES (2, 'Egg Benedict', 12.5, 'Most Popolar', 'Main');
INSERT INTO MenuItem VALUES (3, 'Rice Noodle', 15.5, 'Signature Dish', 'Main');
INSERT INTO MenuItem VALUES (4, 'Toast', 5.5, 'Gluten Free', 'Side');
INSERT INTO MenuItem VALUES (9, 'Pancake', 10.5, 'Signature Sweet', 'Dessert');
INSERT INTO MenuItem VALUES (10, 'Waffle', 12.5, 'Signature Sweet', 'Dessert');

--Insert values for Menu
INSERT INTO Menu VALUES (5001, 'Hot', 1);
INSERT INTO Menu VALUES (5002, 'Recommend', 3 );
INSERT INTO Menu VALUES (5003, 'Specialty of Today', 9);
INSERT INTO Menu VALUES (5004, 'New', 10);
INSERT INTO Menu VALUES (5016, 'On Sale', 4);

--insert value for OrderItem
INSERT INTO OrderItem VALUES (001,001,20,30.10,1);
INSERT INTO OrderItem VALUES (002,002,19,14.52,2);
INSERT INTO OrderItem VALUES (003,003,8,52.13,3);
INSERT INTO OrderItem VALUES (004,004,38,7.40,4);
INSERT INTO OrderItem VALUES (005,005,29,13.13,9);
