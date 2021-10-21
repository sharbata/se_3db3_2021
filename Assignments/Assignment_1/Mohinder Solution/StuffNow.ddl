connect to SE3DB3;

------------------------------------------------
--  DDL Statements for table Person
------------------------------------------------
create table Person(
	FirstName varchar(60) not null,
	LastName varchar(60) not null,
	DateOfBirth date  not null,
	Sex varchar(60),
	PostalCode varchar(60),
	Street varchar(60),
	City varchar(60),
	Country varchar(60),
	primary key (FirstName, LastName, DateOfBirth)
);

------------------------------------------------
--  DDL Statements for table Phone
------------------------------------------------
create table Phone(
	FirstName varchar(60) not null,
	LastName varchar(60) not null,
	DateOfBirth date not null,
	Number bigint not null,
	Type varchar(60),
	primary key (Number),
	foreign key (FirstName, LastName, DateOfBirth) references Person (FirstName, LastName, DateOfBirth) on delete cascade
);

------------------------------------------------
--  DDL Statements for table Product
------------------------------------------------
create table Product(
	ProductID varchar(60) not null,
	ModelNumber varchar(60) not null ,
	SellerID varchar(60) not null,
	URL varchar(60) not null,
	WarrantyID varchar(60) not null,
	Name varchar(60),
	Brand varchar(60),
	Price real,
	Description varchar(60),
	primary key (ProductID, ModelNumber), 
	foreign key (SellerID, URL) references Seller (SellerID, URL) on delete cascade,
	foreign key (WarrantyID) references Warranty (WarrantyID) on delete cascade
);

------------------------------------------------
--  DDL Statements for table Product Category
------------------------------------------------
create table Category(
	Identifier varchar(60) not null,
	CategoryName varchar(60) ,
	Description varchar(60),
	primary key (Identifier)
);

------------------------------------------------
--  DDL Statements for table Belongs to (many to many relationship between Category and Product)
------------------------------------------------
create table BelongsToRel(
	ProductID varchar(60) not null,
	ModelNumber varchar(60) not null,
	Identifier varchar(60) not null,
	foreign key (ProductID, ModelNumber) references Product (ProductID, ModelNumber) on delete cascade, 
	foreign key (Identifier) references Category (Identifier) on delete cascade
);

------------------------------------------------
--  DDL Statements for table Contains (many to many relationship between Order and Product)
------------------------------------------------
---create table Contains(
	---ProductID varchar(60) not null,
	---ModelNumber varchar(60) not null,
	---OrderID varchar(60) not null,
	----foreign key (ProductID, ModelNumber) references Product (ProductID, ModelNumber) on delete cascade, 
	---foreign key (OrderID) references Orders (OrderID) on delete cascade
---);


------------------------------------------------
--  DDL Statements for table Includes (one to many relationship between weak entity set Promotion and Product) 
------------------------------------------------
create table Includes(
	ProductID varchar(60) not null,
	ModelNumber varchar(60) not null,
	PromoName varchar(60) not null,
	StartDate date not null ,
	EndDate date not null,
	foreign key (ProductID, ModelNumber) references Product (ProductID, ModelNumber) on delete cascade, 
	foreign key (PromoName, StartDate, EndDate) references Promotion (PromoName, StartDate, EndDate) on delete cascade
);
------------------------------------------------
--  DDL Statements for table Warranty
------------------------------------------------
create table Warranty(
	WarrantyID varchar(60) not null,
	WarrantyType varchar(60) ,
	Duration time,
	primary key (WarrantyID), 
	CHECK (WarrantyType = 'express' OR WarrantyType = 'implied' OR WarrantyType = 'extended' OR WarrantyType = 'special')
);

------------------------------------------------
--  DDL Statements for table Promotion
------------------------------------------------
create table Promotion(
	PromoName varchar(60) not null,
	StartDate date not null,
	EndDate date not null,
	primary key (PromoName, StartDate, EndDate)
);


------------------------------------------------
--  DDL Statements for table Owner
------------------------------------------------
create table Owner(
	FirstName varchar(60) not null,
	LastName varchar(60) not null,
	DateOfBirth date  not null,
	Expenses real,
	primary key (FirstName, LastName, DateOfBirth),
	foreign key (FirstName, LastName, DateOfBirth) references Person (FirstName, LastName, DateOfBirth) on delete cascade
);

------------------------------------------------
--  DDL Statements for table Employee
------------------------------------------------
create table Employee(
	FirstName varchar(60) not null,
	LastName varchar(60) not null,
	DateOfBirth date  not null,
	Salary real,
	YearsOfService date, 
	primary key (FirstName, LastName, DateOfBirth),
	foreign key (FirstName, LastName, DateOfBirth) references Person (FirstName, LastName, DateOfBirth) on delete cascade
);

------------------------------------------------
--  DDL Statements for table Customer
------------------------------------------------
create table Customer(
	FirstName varchar(60) not null,
	LastName varchar(60) not null,
	DateOfBirth date  not null,
	MembershipNumber BIGINT, 
	primary key (FirstName, LastName, DateOfBirth),
	foreign key (FirstName, LastName, DateOfBirth) references Person (FirstName, LastName, DateOfBirth) on delete cascade
);

------------------------------------------------
--  DDL Statements for table Seller 
------------------------------------------------
create table Seller(
	SellerID varchar(60) not null,
	URL varchar(60) not null,
	FirstName varchar(60) not null,
	LastName varchar(60) not null,
	DateOfBirth date  not null,
	SellerDescription varchar(60) ,
	YearJoined date, 
	primary key (SellerID, URL),
	foreign key (FirstName, LastName, DateOfBirth) references Owner (FirstName, LastName, DateOfBirth) on delete cascade
);
------------------------------------------------
--  DDL Statements for table Order 
------------------------------------------------
create table Orders(
	OrderID varchar(60) not null,
	TrackingNumber char(10) not null,
	FirstName varchar(60) not null,
	LastName varchar(60) not null,
	DateOfBirth date  not null,
	OrderDate date,
	OrderTime time, 
	OrderQuantitiy INTEGER, 
	primary key (OrderID),
	foreign key (TrackingNumber) references Shipment (TrackingNumber) on delete cascade, 
	foreign key (FirstName, LastName, DateOfBirth) references Customer (FirstName, LastName, DateOfBirth) on delete cascade
);

------------------------------------------------
--  DDL Statements for table Works for (many to many relationship between Employee and Seller)
------------------------------------------------
create table Works_For(
	SellerID varchar(60) not null,
	URL varchar(60) not null,
	FirstName varchar(60) not null,
	LastName varchar(60) not null,
	DateOfBirth date  not null,
	foreign key (FirstName, LastName, DateOfBirth) references Employee (FirstName, LastName, DateOfBirth) on delete cascade, 
	foreign key (SellerID, URL) references Seller (SellerID, URL) on delete cascade
);
------------------------------------------------
--  DDL Statements for table Shipment
------------------------------------------------
create table Shipment(
	TrackingNumber char(10) not null,
	Carrier varchar(60),
	DeliveryDate date, 
	primary key (TrackingNumber)
);

------------------------------------------------
--  DDL Statements for table Review
------------------------------------------------
create table Review(
	RatingNumber INTEGER not null,
	Comment varchar(60) not null,
	FirstName varchar(60) not null,
	LastName varchar(60) not null,
	DateOfBirth date  not null,
	ProductID varchar(60) not null,
	ModelNumber varchar(60) not null,
	primary key (RatingNumber, Comment, FirstName, LastName, DateOfBirth, ProductID, ModelNumber), 
	foreign key (FirstName, LastName, DateOfBirth) references Customer (FirstName, LastName, DateOfBirth) on delete cascade,
	foreign key (ProductID, ModelNumber) references Product (ProductID, ModelNumber) on delete cascade
);