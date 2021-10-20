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
