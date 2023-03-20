drop database if exists RPDTicketDB; 
create database RPDTicketDB; 
use RPDTicketDB; 

/*ENTITY TABLE CREATIONS ***************************************************************************************/   
CREATE TABLE OFFICER(
    badgeNum INT not null,
    oName VARCHAR(40),
    PRIMARY KEY(badgeNum)
); 

CREATE TABLE CITIZEN(
    licenseNum INT not null,
    cName VARCHAR(40),
    outBl FLOAT(7,2),
    PRIMARY KEY(licenseNum)
); 

CREATE TABLE TICKET(
    ticketNum VARCHAR(40) not null,
    infCode VARCHAR(40), 
    doi DATE, 
    dueBy DATE, 
    courtDate DATE, 
    amt FLOAT(7,2), 
    PRIMARY KEY(ticketNum)
); 
/*RELATIONSHIP TABLE CREATIONS ***************************************************************************************/   
CREATE TABLE Issues ( 
	ticketNum VARCHAR(40) not null,
	badgeNum INT not null,
	FOREIGN KEY (ticketNum) REFERENCES TICKET (ticketNum),
	FOREIGN KEY (badgeNum) REFERENCES OFFICER (badgeNum)
);

CREATE TABLE Pays ( 
	ticketNum VARCHAR(40) not null,
	licenseNum INT not null,
	FOREIGN KEY (ticketNum) REFERENCES TICKET (ticketNum),
	FOREIGN KEY (licenseNum) REFERENCES CITIZEN (licenseNum)
);

/*ENTITY INSERTS ***************************************************************************************/   
INSERT INTO 
	OFFICER(badgeNum, oName)
VALUES
	(101, 'Paul Blart'),
    (102, 'Frank Drebin Jr.'),
    (103, 'Ben Kenobi');
    
INSERT INTO 
	CITIZEN(licenseNum, cName, outBl)
VALUES
	(123456789, 'Tom Clancy', 156.77),
    (987654321, 'Chuck Norris', 00.00),
    (902109021, 'Travis Scott', 65.29);
    
INSERT INTO
	TICKET(ticketNum, infCode, doi, dueBy, courtDate, amt)
VALUES
	('123ABC', '24-163', '2001-01-01', '2001-01-16', '2001-01-17', 80.24),
    ('456DEF', '16-34', '2016-08-04', '2016-08-19', '2016-08-20', 76.53),
    ('789GHI', '66-92', '2023-12-11', '2023-12-26', '2023-12-27', 65.29);
  
/*RELATIONSHIP INSERTS ***************************************************************************************/   
INSERT INTO
	Issues(ticketNum, badgeNum)
VALUES
	('123ABC', 101),
    ('456DEF', 102),
    ('789GHI', 103);
INSERT INTO
	Pays(ticketNum, licenseNum)
VALUES
	('123ABC', 123456789),
    ('456DEF', 123456789),
    ('789GHI', 902109021);

 /* CREATE VIEW FOR TOM CLANCY ***********************************************************************************/ 
 CREATE VIEW citizenView AS
	SELECT c.cName, t.*
    FROM CITIZEN c, Pays p, TICKET t
    WHERE c.licenseNum = 123456789 and c.licenseNum = p.licenseNum and p.ticketNum = t.ticketNum;
    
    

    