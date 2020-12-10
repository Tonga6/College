DROP DATABASE IF EXISTS `game_company`;
CREATE DATABASE `game_company`; 
USE `game_company`;


DROP TABLE IF EXISTS `Studios`;
CREATE TABLE Studios (
    studio_location varchar(255) NOT NULL,
    studio_lead varchar(255) NOT NULL,
    timezone varchar(255) NOT NULL,
    studio_size integer NOT NULL,
    PRIMARY KEY (studio_location)
);
INSERT INTO Studios VALUES ('Dublin', 'John Smith', 'GMT',0);
INSERT INTO Studios VALUES ('London', 'Corey Clement', 'GMT',0);
INSERT INTO Studios VALUES ('Paris', 'Will Hill', 'PST',0);
INSERT INTO Studios VALUES ('California', 'Tom Carron', 'CST',0);
INSERT INTO Studios VALUES ('Singapore', 'Kate Kae', 'SST',0);


DROP TABLE IF EXISTS `Publishers`;
CREATE TABLE Publishers (
    publisher_name varchar(255) NOT NULL,
    publisher_id integer NOT NULL,
    contact_email varchar(255) NOT NULL,    
    PRIMARY KEY (publisher_name)
);
INSERT INTO Publishers VALUES ('EA', '0', 'hughman@ea.com');
INSERT INTO Publishers VALUES ('Pub Games', '1', 'jill@jack.com');
INSERT INTO Publishers VALUES ('Megaphone', '2', 'mega@megaphone.au');
INSERT INTO Publishers VALUES ('Jackpot', '3', 'jack@pot.com');
INSERT INTO Publishers VALUES ('La Rue', '4', 'jaque@larue.fr');


DROP TABLE IF EXISTS `Projects`;
CREATE TABLE Projects (
    project_name varchar(255) NOT NULL,
    project_id integer NOT NULL,
    genre varchar(255) NOT NULL,
    publisher_name varchar(255),
    PRIMARY KEY(project_name),

    FOREIGN KEY(publisher_name) REFERENCES Publishers(publisher_name)
);
ALTER TABLE Projects ADD UNIQUE (project_id);
INSERT INTO Projects VALUES ('Corn Field', '0','Puzzle','EA');
INSERT INTO Projects VALUES ('Duck','1','Platformer','Megaphone');
INSERT INTO Projects VALUES ('Elysium','2','Shooter','La Rue');
INSERT INTO Projects VALUES ('Where is My Car?','3','Puzzle','Pub Games');
INSERT INTO Projects VALUES ('Warfield','4','Shooter','Jackpot');
INSERT INTO Projects VALUES ('Jump','5','Platformer',null);


DROP TABLE IF EXISTS `Teams`;
CREATE TABLE Teams (
    team_id integer NOT NULL,
    project_id integer,
    studio_location varchar(255) NOT NULL,
    team_size integer NOT NULL,
    PRIMARY KEY(team_id),
    FOREIGN KEY (studio_location) REFERENCES Studios (studio_location),
    FOREIGN KEY (project_id) REFERENCES Projects (project_id)
);
INSERT INTO Teams VALUES ('0', '0', 'Dublin', 0);
INSERT INTO Teams VALUES ('1', '1', 'Dublin', 0);
INSERT INTO Teams VALUES ('2', '0', 'London', 0);
INSERT INTO Teams VALUES ('3', '1', 'London',0);
INSERT INTO Teams VALUES ('4', '2', 'Singapore',0);
INSERT INTO Teams VALUES ('5', '3', 'Singapore',0);
INSERT INTO Teams VALUES ('6', '4', 'Singapore',0);
INSERT INTO Teams VALUES ('7', '3', 'Paris',0);
INSERT INTO Teams VALUES ('8', '2', 'Paris',0);
INSERT INTO Teams VALUES ('9', '3', 'California',0);
INSERT INTO Teams VALUES ('10', '2', 'California',0);


DROP TABLE IF EXISTS `Employees`;
CREATE TABLE Employees (
    employee_name varchar(255) NOT NULL,
    employee_id integer NOT NULL,
    position varchar(255) NOT NULL,
    seniority varchar(255),
    team_id integer,
    studio_location varchar(255) NOT NULL,
    PRIMARY KEY(employee_id) ,
    FOREIGN KEY (studio_location) REFERENCES Studios (studio_location),
    FOREIGN KEY (team_id) REFERENCES Teams (team_id),
    CONSTRAINT check_employee_position CHECK (position IN ('Artist','Programmer',
       'Designer','Marketing','Studio Leader', 'CEO'))
);


DROP TABLE IF EXISTS `Contractors`;
CREATE TABLE Contractors (
	contractor_name varchar(255) NOT NULL,
    contractor_email varchar(255) NOT NULL,
    project_name varchar(255) NOT NULL,
    service_provided varchar(255) NOT NULL,
    PRIMARY KEY (contractor_name),
    FOREIGN KEY (project_name) REFERENCES Projects (project_name),
    CONSTRAINT check_contractor_service CHECK (service_provided IN ('Art','Sound',
       'Localisation'))
);
INSERT INTO Contractors VALUES('Second Brush', 'greg@sb.com','Elysium', 'Art');
INSERT INTO Contractors VALUES('Vox', 'voxrep@vox.com','Jump', 'Sound');
INSERT INTO Contractors VALUES('Rosetta', 'laura@rosetta.com','Elysium', 'Localisation');
INSERT INTO Contractors VALUES('Sonix', 'rep@sonix.com','Jump', 'Sound');
INSERT INTO Contractors VALUES('Bob Ross', 'bob@ross.com','Warfield', 'Art');


DELIMITER @@;
-- Increment number of employees in the appropriate Team and Studio
CREATE TRIGGER Add_Employee
AFTER INSERT ON Employees
FOR EACH ROW
BEGIN
    UPDATE Studios
    SET studio_size = (SELECT COUNT(studio_location) FROM Employees
    WHERE studio_location = NEW.studio_location) 
    WHERE studio_location = NEW.studio_location;

    UPDATE Teams
    SET team_size = (SELECT COUNT(team_id) FROM Employees
    WHERE team_id = NEW.team_id) 
    WHERE team_id = NEW.team_id;
END;

-- Decrement number of employees in the appropriate Team and Studio
CREATE TRIGGER Remove_Employee
AFTER DELETE ON Employees
FOR EACH ROW
BEGIN
    UPDATE Studios
    SET studio_size = (SELECT COUNT(studio_location) FROM Employees
    WHERE studio_location = OLD.studio_location) 
    WHERE studio_location = OLD.studio_location;

    UPDATE Teams
    SET team_size = (SELECT COUNT(team_id) FROM Employees
    WHERE team_id = OLD.team_id) 
    WHERE team_id = OLD.team_id;
END;

-- Update number of employees in the appropriate Team and Studio
CREATE TRIGGER Edit_Employee
AFTER Update ON Employees
FOR EACH ROW
BEGIN
    UPDATE Studios
    SET studio_size = (SELECT COUNT(studio_location) FROM Employees
    WHERE studio_location = NEW.studio_location) 
    WHERE studio_location = NEW.studio_location;

    UPDATE Teams
    SET team_size = (SELECT COUNT(team_id) FROM Employees
    WHERE team_id = NEW.team_id) 
    WHERE team_id = NEW.team_id;
END;
@@;
DELIMITER ;

INSERT INTO Employees VALUES ('John Smith', '0', 'Programmer', 'Senior', '0', 'Dublin');
INSERT INTO Employees VALUES ('Oisin Tong', '1', 'Designer', 'Junior', '1', 'Dublin');
INSERT INTO Employees VALUES ('Sarah Lance', '2', 'Artist', 'Junior', '7', 'Paris');
INSERT INTO Employees VALUES ('Peter Ridden', '3', 'Artist', 'Senior', '7', 'Paris');
INSERT INTO Employees VALUES ('Rickard Mole', '4', 'Designer', 'Junior', '4', 'Singapore');
INSERT INTO Employees VALUES ('Lisa Parker', '5', 'Programmer', 'Junior', '7', 'Paris');
INSERT INTO Employees VALUES ('Paula Real', '6', 'Programmer', 'Junior', '10', 'California');
INSERT INTO Employees VALUES ('Yvette Wyn', '7', 'Programmer', 'Senior', '9', 'California');
INSERT INTO Employees VALUES ('Marcus Inta', '8', 'Designer', 'Senior', '0', 'Dublin');
INSERT INTO Employees VALUES ('Will Hill', '9', 'Artist', 'Senior', '8', 'Paris');
INSERT INTO Employees VALUES ('Greg Peg', '10', 'Artist', 'Senior', '9', 'California');
INSERT INTO Employees VALUES ('Caitlin Murphy', '11', 'Artist', 'Junior', '10', 'California');
INSERT INTO Employees VALUES ('Eamon Ryan', '12', 'Marketing', 'Senior', '3', 'London');
INSERT INTO Employees VALUES ('Laura Armstrong', '13', 'Programmer', 'Junior', '10', 'California');
INSERT INTO Employees VALUES ('Lilly White', '14', 'Marketing', 'Senior', '0', 'Dublin');
INSERT INTO Employees VALUES ('Tom Carron', '15', 'Marketing', 'Junior', '10', 'California');
INSERT INTO Employees VALUES ('Beth Olsen', '16', 'Designer', 'Junior', '4', 'London');
INSERT INTO Employees VALUES ('Cian Kart', '17', 'Marketing', 'Junior', '5', 'Singapore');
INSERT INTO Employees VALUES ('Joe Norm', '18', 'Designer', 'Senior', '8', 'Paris');
INSERT INTO Employees VALUES ('Hughie Swine', '19', 'Programmer', 'Junior', '1', 'Dublin');
INSERT INTO Employees VALUES ('Debra Yue', '20', 'Programmer', 'Junior', '7', 'Paris');
INSERT INTO Employees VALUES ('Gordan Ramsey', '21', 'Designer', 'Senior', '5', 'Singapore');
INSERT INTO Employees VALUES ('Alshon Abbett', '22', 'Marketing', 'Junior', '6', 'Singapore');
INSERT INTO Employees VALUES ('Corey Clement', '23', 'Designer', 'Senior', '3', 'London');
INSERT INTO Employees VALUES ('Theresa May', '24', 'Marketing', 'Junior', '4', 'Singapore');
INSERT INTO Employees VALUES ('Iris Eye', '25', 'Designer', 'Senior', '2', 'London');
INSERT INTO Employees VALUES ('Louis Goal', '26', 'Programmer', 'Junior', '2', 'London');
INSERT INTO Employees VALUES ('Kate Kae', '27', 'Programmer', 'Senior', '6', 'Singapore');
INSERT INTO Employees VALUES ('Rye Bread', '28', 'Artist', 'Senior', '6', 'Singapore');

CREATE VIEW Dublin_Employees AS
SELECT employee_name, employee_id, position, seniority
FROM Employees
WHERE studio_location = 'Dublin';

CREATE VIEW Paris_Employees AS
SELECT employee_name, employee_id, position, seniority
FROM Employees
WHERE studio_location = 'Paris';

CREATE VIEW California_Employees AS
SELECT employee_name, employee_id, position, seniority
FROM Employees
WHERE studio_location = 'California';

CREATE VIEW London_Employees AS
SELECT employee_name, employee_id, position, seniority
FROM Employees
WHERE studio_location = 'London';

CREATE VIEW Singapore_Employees AS
SELECT employee_name, employee_id, position, seniority
FROM Employees
WHERE studio_location = 'Singapore';

CREATE ROLE IF NOT EXISTS 'moderator','read_only';
GRANT SELECT ON game_company.* TO 'moderator','read_only';
GRANT INSERT, DELETE, UPDATE ON Studios TO 'moderator';
GRANT INSERT, DELETE, UPDATE ON Studios TO 'moderator';
GRANT INSERT, DELETE, UPDATE ON Studios TO 'moderator';
