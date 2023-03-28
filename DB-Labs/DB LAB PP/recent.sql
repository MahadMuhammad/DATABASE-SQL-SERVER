CREATE TABLE employee (
    employeeName VARCHAR(25),
    streetAddress VARCHAR(25),
    city VARCHAR(25),
    PRIMARY KEY (employeeName)--,streetAddress)
);


CREATE TABLE company (
    companyName VARCHAR(25) PRIMARY KEY,
    city VARCHAR(25)
);

CREATE TABLE works (
    employeeName VARCHAR(25), 
    companyName VARCHAR(25),
    salary DECIMAL(6,3)
);
ALTER TABLE works ALTER COLUMN salary DECIMAL(6,3);

CREATE TABLE manages (
    employeeName VARCHAR(25),
    managerName VARCHAR(25)
);

ALTER TABLE employee ALTER COLUMN employeeName VARCHAR(25) NOT NULL;
ALTER TABLE employee ADD COnSTRAINT t1_pk 
PRIMARY KEY (employeeName);

ALTER TABLE company ALTER COLUMN companyName VARCHAR(25) NOT NULL;
ALTER TABLE company ADD COnSTRAINT t2_pk 
PRIMARY KEY (companyName);

ALTER TABLE works ALTER COLUMN employeeName VARCHAR(25) NOT NULL;
ALTER TABLE works ADD COnSTRAINT t3_pk 
PRIMARY KEY (employeeName);

ALTER TABLE manages ALTER COLUMN employeeName VARCHAR(25) NOT NULL;
ALTER TABLE manages ADD COnSTRAINT t4_pk 
PRIMARY KEY (employeeName);

DROP TABLE employee;
DROP TABLE company;
DROP TABLE works;
DROP TABLE manages;

ALTER TABLE works ADD CONSTRAINT t3_fk2 FOREIGN KEY (companyName) REFERENCES company (companyName) ON DELETE SET NULL ON UPDATE CASCADE;
ALTER TABLE works ADD CONSTRAINT t3_fk1 FOREIGN KEY (employeeName) REFERENCES employee (employeeName) ON UPDATE CASCADE;

ALTER TABLE manages ADD CONSTRAINT t4_fk1 FOREIGN KEY (employeeName) REFERENCES employee (employeeName) ON UPDATE CASCADE;


ALTER TABLE employee ADD phone_number VARCHAR(11) CONSTRAINT CHK_PN_LENGHT CHECK (LEN(phone_number) = 11);

-- INSERT INTO employee (employeeName,phone_number) VALUES ('mahad',6);

ALTER TABLE company ADD establishDate DATE DEFAULT DATEADD(year, -2, GETDATE())
CONSTRAINT CHK_establishDate CHECK (establishDate <=GETDATE());

ALTER TABLE works ALTER COLUMN salary DECIMAL(10,3) DEFAULT 4000;
ALTER TABLE works ADD CONSTRAINT CHK_SALARY CHECK (salary >=4000); 

ALTER TABLE company DROP COLUMN city;

INSERT INTO employee (employeeName, streetAddress, city, phone_number) VALUES
('John Smith', '123 Main St', 'Anytown', '12345678901'),
('Jane Doe', '456 Oak St', 'Otherville', '23456789012'),
('Bob Johnson', '789 Elm St', 'Smallville', '34567890123'),
('Alice Williams', '321 Maple St', 'Bigtown', '45678901234');

INSERT INTO company (companyName, establishDate) VALUES
('ABC Corp', '2018-01-01'),
('XYZ Inc', '2019-05-15'),
('Acme Co', '2017-10-01'),
('Global Enterprises', '2020-02-20');

INSERT INTO works (employeeName, companyName, salary) VALUES
('John Smith', 'ABC Corp', 5000.00),
('Jane Doe', 'Acme Co', 4000.50),
('Bob Johnson', 'XYZ Inc', 4500.25),
('Alice Williams', 'Global Enterprises', 6000.75);

INSERT INTO manages (employeeName, managerName) VALUES
('John Smith', 'Jane Doe'),
('Bob Johnson', 'Alice Williams'),
('Alice Williams', 'Jane Doe'),
('Jane Doe', 'Bob Johnson');

SELECT * FROM employee;
SELECT * FROM company;
SELECT * FROM works;
SELECT * FROM manages;