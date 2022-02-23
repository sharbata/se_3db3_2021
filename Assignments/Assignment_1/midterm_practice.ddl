connect to SE3DB3;

------------------------------------------------
--  DDL Statements for practice table
------------------------------------------------
create table hats(
	id int not null primary key,
	color varchar(20)
);

create table models(
	m_id int unique,
	age int not null,
	name varchar(35) not null,
	hat_worn int references hats(id),
	primary key (name, age)
);
