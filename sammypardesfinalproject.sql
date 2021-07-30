/*
Sammy Pardes
IST659
Final Project
*/

-- drop statements
drop table if exists Borten_DestinationAirline 
drop table if exists Borten_DestinationLodging
drop table if exists Borten_DestinationTransportation
drop table if exists Borten_Airline
drop table if exists Borten_Lodging
drop table if exists Borten_Transportation
drop table if exists Borten_Booking
drop table if exists Borten_City
drop table if exists Borten_Destination
drop table if exists Borten_Client
drop table if exists Borten_Agent

drop procedure if exists borten_ChangeClientEmail

drop function if exists borten_AgentBookingsCount

drop view if exists borten_AgentBookingReport
drop view if exists borten_AgentDestinationReport
drop view if exists borten_ClientDestinationReport
drop view if exists borten_ClientLodgingReport
-- end drop statements

-- create table statements 
create table Borten_Agent (
	agent_id int identity primary key,
	agent_first_name varchar(30) not null, 
	agent_last_name varchar(30) not null,
	agent_email_address varchar(50) not null unique,
	date_employed datetime default getdate()
)

create table Borten_Destination (
	destination_id int identity primary key,
	country_code varchar(3) unique not null,
	agent_id int not null foreign key references Borten_Agent(agent_id),
	destination_description varchar(200)
)

create table Borten_City (
	city_id int identity primary key,
	city_name varchar(30) not null unique,
	destination_id int not null foreign key references Borten_Destination(destination_id)
)

create table Borten_Client (
	client_id int identity primary key,
	first_name varchar(30) not null,
	last_name varchar(30) not null,
	client_email_address varchar(50) not null unique,
	client_address_line_1 varchar(50) not null,
	client_address_line_2 varchar(50),
	client_city varchar(30) not null,
	client_state varchar(30) not null,
	client_zip_code varchar(10) not null,
	client_country varchar(30) not null,
	party_number int, 
	agent_id int not null foreign key references Borten_Agent(agent_id)
)

create table Borten_Booking (
	booking_id int identity primary key,
	begin_date datetime not null,
	end_date datetime not null,
	price int not null,
	agent_id int not null foreign key references Borten_Agent(agent_id),
	destination_id int not null foreign key references Borten_Destination(destination_id),
	client_id int not null foreign key references Borten_Client(client_id)
)

create table Borten_Airline (
	airline_id int identity primary key,
	airline_name varchar(30) not null unique
)

create table Borten_Lodging (
	lodging_id int identity primary key,
	lodging_name varchar(30) not null unique, 
	lodging_address_line_1 varchar(50) not null,  
	lodging_address_line_2 varchar(50),
	lodging_city varchar(30) not null,
	lodging_state varchar(30) not null,
	lodging_zip varchar(10) not null,
	lodging_type varchar(30) not null
)

create table Borten_Transportation (
	transportation_id int identity primary key,
	transportation_name varchar(30) not null unique,
	transportation_type varchar(30) not null
)

create table Borten_DestinationAirline(
	destination_airline_id int identity primary key,
	destination_id int not null foreign key references Borten_Destination(destination_id),
	airline_id int not null foreign key references Borten_Airline(airline_id),
	constraint u1_Borten_DestinationAirline unique(destination_id, airline_id)
)

create table Borten_DestinationLodging (
	destination_lodging_id int identity primary key,
	destination_id int not null foreign key references Borten_Destination(destination_id),
	lodging_id int not null foreign key references Borten_Lodging(lodging_id),
	constraint u1_Borten_DestinationLodging unique(destination_id, lodging_id)
)

create table Borten_DestinationTransportation (
	destination_transportation_id int identity primary key,
	destination_id int not null foreign key references Borten_Destination(destination_id),
	transportation_id int not null foreign key references Borten_Transportation(transportation_id),
	constraint u1_Borten_DestinationTransportation unique(destination_id, transportation_id)
)
-- end create table statements

-- begin instert statements
INSERT INTO Borten_Agent 
		(agent_first_name, agent_last_name, agent_email_address, date_employed)
VALUES	('Sammy', 'Pardes', 'spardes@bortenoverseas.com', '6/20/2016'),
		('Andrea', 'Berekeland', 'aberkeland@bortenoverseas.com', '5/7/2014'),
		('Austin', 'Cotant', 'acotant@bortenoverseas.com', '2/26/2018'),
		('Emily', 'Volland', 'evolland@bortenoverseas.com', '5/14/2017'),
		('Olivia', 'Barrow', 'obarrow@bortenoverseas.com', '11/23/2015'),
		('Nate', 'Sweet', 'nsweet@bortenoverseas.com', '9/7/2014'),
		('Ian', 'Norden', 'inorden@bortenoverseas.com', '1/13/2014'),
		('Michael', 'Cook', 'mcook@bortenoverseas.com', '4/17/2019'),
		('Grant', 'Kinney', 'gkinney@bortenoverseas.com', '12/3/2014')
GO

INSERT INTO Borten_Destination
		(country_code, agent_id, destination_description)
VALUES	('AUS','1','Australia'), ('DNK', '2', 'Denmark'), ('ISL', '3', 'Iceland'), 
		('IRL', '4', 'Ireland'),  ('JPN', '5', 'Japan'), ('NLD', '6', 'Netherlands'), 
		('GBR', '7', 'United Kingdom'), ('FRA', '8', 'France'), ('MEX', '9', 'Mexico'),
		('SWE', '1', 'Sweden'), ('NZL', '2', 'New Zealand'), ('IND', '3', 'India'),
		('FJI', '4', 'Fiji'), ('BRA', '5', 'Brazil'), ('ZAF', '6', 'South Africa'),
		('TCA', '7', 'Turks and Caicos'), ('BHS', '8', 'Bahamas'), ('AIA', '9', 'Anguilla')
GO

INSERT INTO Borten_City
		(city_name, destination_id)
VALUES	('Sydney', '1'), ('Copenhagen', '2'), ('Reykjavik', '3'), ('Dublin', '4'), ('Tokyo', '5'),
		('Amsterdam', '6'), ('London', '7'), ('Paris', '8'), ('Cancun', '9'), ('Stockholm', '10'),
		('Auckland', '11'), ('New Delhi', '12'), ('Suva', '13'), ('Rio de Janeiro', '14'), ('Johannesburg', '15'),
		('Cockburn Town', '16'), ('Nassau', '17'), ('The Valley', '18'), ('Melbourne', '1'), ('Nice', '8'),
		('Osaka', '5'), ('Manchester', '7'), ('Perth', '1'), ('Rotterdam', '6'), ('Mexico City', '9')
GO

INSERT INTO Borten_Airline
		(airline_name)
VALUES	('Delta'), ('JetBlue'), ('SouthWest'), ('American Airlines'), ('United'), ('Japan Airlines'), ('Emirates'), ('Caribbean Airlines')
GO

INSERT INTO Borten_Lodging
		(lodging_name, lodging_address_line_1, lodging_city, lodging_state, lodging_zip, lodging_type)
VALUES	('Four Seasons Sydney','199 George St','The Rocks','New South Wales','2000','Hotel'),
		('Steel House Copenhagen','Herholdtsgade 6','Kobenhavn','Copenhagen','','Hostel'),
		('Galaxy Pod Hostel','Laugavegur 172','Reykjavík','Reykjavík','','Hostel'),
		('Clontarf Castle Hotel','Castle Ave','lontarf East','Dublin','','Hotel')
GO

INSERT INTO Borten_DestinationLodging
		(destination_id, lodging_id)
VALUES	('1', '1'),
		('2', '2'),
		('3', '3'),
		('4', '4')
GO

INSERT INTO Borten_Client
		(first_name, last_name, client_email_address, client_address_line_1, client_city, client_state, client_zip_code, client_country, party_number, agent_id)
VALUES	('Greta', 'Gerwig', 'ladybird@movie.com','44 Astor Pl', 'New York', 'NY', '11011', 'US','5','1'),
		('Simone', 'Biles', 'aagold@usagymnastics.org', '987 Olympic Ln', 'Dallas','TX', '44332', 'US', '2', '2'),
		('Adam', 'Driver', 'adriver@girlshbo.com', '335 Park St', 'Los Angeles','CA', '54543', 'US', '7', '5'),
		('Scarlett', 'Johanson', 'scarjo@her.net', '27 Rodeo Dr', 'Hollywood','CA', '23456', 'US', '3', '4'),
		('John', 'Oliver', 'lastweek@tonight.com', '30 Rockefeller Pl', 'New York','NY', '11012', 'US', '4', '7'),
		('Joe', 'Rogan', 'tko@ufc.org', '8 Kickboxing St', 'Las Vegas','NV', '05050', 'US', '2', '7'),
		('Bill', 'Murray', 'billm@ghostbusters.com', '890 Zombieland Dr', 'Tuscan','AZ', '09876', 'US', '5', '9')
GO

INSERT INTO Borten_Booking
		(begin_date, end_date, price, agent_id, destination_id, client_id)
VALUES	('1/22/20', '2/5/20','7000','1','3','1'),
		('4/7/20', '4/27/20', '3250', '2', '7', '2'),
		('9/4/20', '10/1/20', '8750', '5', '17', '3'),
		('8/16/20', '8/25/20', '2500', '4', '8', '4'),
		('3/9/20', '4/9/20', '5525', '7', '4', '5'),
		('3/27/20', '5/2/20', '10500', '7', '10', '6'),
		('5/14/20', '5/29/20', '2300', '9', '12', '7')
GO
--end insert statements

--begin select statements to show insterts were successful
SELECT * FROM Borten_Client
SELECT * FROM Borten_Agent
--end select statements


--create a procedure to update a client's email address given first and last name
GO
CREATE PROCEDURE borten_ChangeClientEmail (@clientFirstName varchar(30), @clientLastName varchar(30), @newEmail varchar(50))
AS
BEGIN
	UPDATE Borten_Client SET client_email_address = @newEmail
	WHERE last_name = @clientLastName AND first_name = @clientFirstName
END
GO

--use email update procedure
EXEC borten_ChangeClientEmail 'Adam', 'Driver', 'mynewemail@driver.com'
SELECT * FROM Borten_Client WHERE first_name='Adam' and last_name ='Driver'
--end email update procedure
--end borten_ChangeClientEmail procedure

--create views and functions
--create function to count bookings for each agent
GO
CREATE FUNCTION dbo.borten_AgentBookingsCount(@agentID int)
RETURNS int AS 
BEGIN
	DECLARE @returnValue int
	SELECT @returnValue = COUNT(Borten_Booking.agent_id) FROM Borten_Booking
	WHERE Borten_Booking.agent_id = @agentID
	RETURN @returnValue
END
GO

--use borten_AgentBookingsCount function
SELECT Borten_Agent.agent_first_name, dbo.borten_AgentBookingsCount(Borten_Agent.agent_id) AS NumBookings FROM Borten_Agent
--end count bookings for each agent function

--create destinations for each agent view
GO
CREATE VIEW borten_AgentDestinationReport AS
	SELECT
	Borten_Agent.agent_first_name,
	Borten_Destination.destination_description
	FROM Borten_Destination
	JOIN Borten_Agent ON Borten_Agent.agent_id = Borten_Destination.agent_id
GO
--test out agent destinations view
SELECT * FROM borten_AgentDestinationReport ORDER BY agent_first_name
-- end agent destinations view

--create client destinations view
GO
CREATE VIEW borten_ClientDestinationReport AS
	SELECT
	Borten_Client.first_name,
	Borten_Client.last_name,
	Borten_Destination.destination_description,
	Borten_Agent.agent_first_name
	FROM Borten_Client
	JOIN Borten_Booking ON Borten_Booking.client_id = Borten_Client.client_id
	JOIN Borten_Destination ON Borten_Destination.destination_id = Borten_Booking.destination_id
	JOIN Borten_Agent ON Borten_Agent.agent_id = Borten_Booking.agent_id
GO
--test out client destinations view
SELECT * FROM borten_ClientDestinationReport ORDER BY last_name
--end client destions view

--create view for client lodging
GO
CREATE VIEW borten_ClientLodgingReport AS
	SELECT
	Borten_Client.first_name,
	Borten_Client.last_name,
	Borten_Destination.destination_description,
	Borten_Lodging.lodging_name
	FROM Borten_Client
	JOIN Borten_Booking on Borten_Booking.client_id = Borten_Client.client_id
	JOIN Borten_Destination ON Borten_Destination.destination_id = Borten_Booking.booking_id
	JOIN Borten_DestinationLodging ON Borten_DestinationLodging.destination_id = Borten_Destination.destination_id
	JOIN Borten_Lodging on Borten_Lodging.lodging_id = Borten_DestinationLodging.lodging_id
GO
--test out client lodging view
SELECT * FROM borten_ClientLodgingReport ORDER BY last_name
--end create views

--create form in Access to enter new client information
--agent set to dropdown menu
--use client view to see if Access form worked
SELECT * FROM Borten_Client