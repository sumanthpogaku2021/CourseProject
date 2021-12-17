Create Database LoanSystem;

Use LoanSystem;

Create Table Customer(CustID INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY, CustFname VARCHAR(20) NOT NULL, CustLname	VARCHAR(20) NOT NULL, CustPhone VARCHAR(10) NOT NULL, CustAddress VARCHAR(500) NOT NULL);

Describe Customer;

Create Table CollectionAgent(AgentID INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY, AgentName VARCHAR(30) NOT NULL, AgentPhone VARCHAR(10) NOT NULL, AgentEmail VARCHAR(25));

Describe CollectionAgent;


Create Table Loan(LoanID INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY, LoanStartDate DATE NOT NULL, LoanEndDate DATE NOT NULL, InterestRate FLOAT NOT NULL, LoanAmount FLOAT NOT NULL, PaymentDue FLOAT NOT NULL, Duedate DATE, PayFrequency INTEGER, CustID INTEGER UNSIGNED NOT NULL, AgentID INTEGER UNSIGNED NOT NULL, FOREIGN KEY(CustID) REFERENCES Customer(CustID) ON DELETE CASCADE, FOREIGN KEY(AgentID) REFERENCES CollectionAgent(AgentID) ON DELETE CASCADE);

Describe Loan;


Create Table PaymentType(typeID INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY, PaymentType VARCHAR(10));

Describe PaymentType;

Create Table Payment(PaymentID INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY, LoanID INTEGER UNSIGNED NOT NULL, typeID INTEGER UNSIGNED NOT NULL, PaymentDate DATE NOT NULL, AmountPaid FLOAT NOT NULL, Remark varchar(100), FOREIGN KEY(typeID) REFERENCES PaymentType(typeID) ON DELETE CASCADE, FOREIGN KEY(LoanID) REFERENCES Loan(LoanID) ON DELETE CASCADE);

Describe Payment;

Use LoanSystem;
LOAD DATA LOW_PRIORITY LOCAL INFILE 'D:/Data/customer.csv' INTO TABLE Customer FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS (CustFname,CustLname,CustPhone,CustAddress);

LOAD DATA LOW_PRIORITY LOCAL INFILE 'D:/Data/agent.csv' INTO TABLE CollectionAgent FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS (AgentName,AgentPhone,AgentEmail);

LOAD DATA LOW_PRIORITY LOCAL INFILE 'D:/Data/paymenttype.csv' INTO TABLE PaymentType FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS (paymenttype);

LOAD DATA LOW_PRIORITY LOCAL INFILE 'D:/Data/loan.csv' INTO TABLE Loan FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS (LoanStartDate,LoanEndDate,InterestRate,LoanAmount,PaymentDue,Duedate,PayFrequency,CustID,AgentID);

LOAD DATA LOW_PRIORITY LOCAL INFILE 'D:/Data/payment.csv' INTO TABLE Payment FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS (LoanID,typeID,PaymentDate,AmountPaid,Remark);


INSERT INTO customer(CustFname,CustLname,CustPhone,CustAddress) VALUES('Tandy','Ortega','7801012345','3370 Vernon Street Palm Springs, CA');

INSERT INTO customer(CustFname,CustLname,CustPhone,CustAddress) VALUES('Barbara','Dipalma','7185691020','2011 Kovar Road Worcester, MA 01610');

SELECT * FROM customer;

INSERT INTO collectionagent(AgentName,AgentPhone,AgentEmail) VALUES('Debbie','7903111221','Debbie@loan.com');
INSERT INTO collectionagent(AgentName,AgentPhone,AgentEmail) VALUES('Jonathan','7633122110','Jonathan@loan.com');

SELECT * FROM collectionagent;

INSERT INTO loan(LoanStartDate,LoanEndDate,InterestRate,LoanAmount,PaymentDue,DueDate,PayFrequency,CustID,AgentID)
VALUES('2016-06-23','2026-07-23',12.2,129000,7500,'2021-11-11',1,4,5);
INSERT INTO loan(LoanStartDate,LoanEndDate,InterestRate,LoanAmount,PaymentDue,DueDate,PayFrequency,CustID,AgentID)
VALUES('2019-10-12','2030-10-12',9.6,148759.45,4500,'2021-12-01',2,5,3);

SELECT * FROM loan;

INSERT INTO payment(LoanID,typeID,PaymentDate,AmountPaid,Remark) VALUES(4,2,'2021-12-01',3400,'Partially paid');
INSERT INTO payment(LoanID,typeID,PaymentDate,AmountPaid,Remark) VALUES(5,3,'2021-12-10',2500,'Partially paid');

SELECT * FROM payment;

UPDATE customer SET CustPhone='7901079010' WHERE CustID=1;

SELECT * FROM customer WHERE CustID=1;

UPDATE loan SET InterestRate=10.29 WHERE LoanID=3;

SELECT InterestRate FROM loan WHERE LoanID=3;

DELETE FROM payment WHERE PaymentID=4;

SELECT AmountPaid AS AMOUNT FROM payment WHERE AmountPaid>1500;

SELECT CustFname AS FIRST_NAME, CustLname AS LAST_NAME, CustPhone AS CONTACT_NUMBER, CustAddress AS ADDRESS, DueDate AS LOAN_DUEDATE FROM customer INNER JOIN loan ON customer.CustID=loan.CustID WHERE loan.Duedate>'2021-11-30'; 


SELECT LoanAmount AS LOAN_AMOUNT, PaymentDue AS DUE, Duedate AS DUE_DATE, PaymentDATE AS DATE_PAID FROM loan INNER JOIN payment ON loan.LoanID=payment.LoanID WHERE PayFrequency=2;

SELECT COUNT(LoanID) AS NUMBER_OF_LOANS FROM loan WHERE InterestRate>9.5;

SELECT PaymentDate AS PAYMENT_DATE, Remark AS PAYMENT_REMARK, Sum(AmountPaid) AS TOTAL_AMOUNT_PAID, PaymentType AS PAYMENT_MODE FROM payment INNER JOIN paymenttype ON payment.typeID=paymenttype.typeID WHERE payment.AmountPaid > 1200;

SELECT CustFname AS CUSTOMER_FIRST_NAME, CustLname AS CUSTOMER_LAST_NAME, CustPhone AS CUSTOMER_CONTACT_NUMBER, CustAddress AS CUSTOMER_ADDRESS, LoanAmount AS LOAN_AMOUNT, PaymentDue AS DUE_AMOUNT, Duedate AS DUE_DATE, AmountPaid AS AMOUNT_PAID, PaymentDate AS PAYMENT_DATE FROM customer INNER JOIN loan ON customer.CustID=loan.CustID INNER JOIN payment ON  loan.LoanID=payment.LoanID WHERE payment.AmountPaid>1200;

SELECT AgentName AS AGENT_NAME, AgentPhone AS AGENT_CONTACT_NUMBER, AgentEmail AS AGENT_EMAIL, LoanAmount AS LOAN_AMOUNT, PaymentDue AS LOAN_DUE, AmountPaid AS AMOUNT_PAID, PaymentDate AS PAYMENT_DATE FROM collectionagent INNER JOIN loan ON collectionagent.AgentID=loan.AgentID INNER JOIN payment ON  loan.LoanID=payment.LoanID WHERE payment.PaymentDate>'2021-11-01';

SELECT AmountPaid AS AMOUNT_PAID, PaymentDate AS PAYMENT_DATE FROM payment WHERE PaymentDate BETWEEN '2021-10-01' AND '2021-12-15';


CREATE INDEX idx_customer_name ON customer(CustFname,CustLname);

DESCRIBE customer;

CREATE INDEX idx_agent_name ON collectionagent(AgentName);

DESCRIBE collectionagent;

CREATE INDEX idx_due_date ON loan(Duedate);

DESCRIBE loan;

CREATE VIEW CustView AS (SELECT * FROM customer ORDER BY CustFname);

SELECT * FROM custview;

CREATE VIEW PaymentDateView AS (SELECT AmountPaid AS AMOUNT_PAID, PaymentDate AS PAYMENT_DATE FROM payment WHERE PaymentDate BETWEEN '2021-10-01' AND '2021-12-15');

SELECT * FROM paymentdateview;

DELIMITER //
CREATE TRIGGER before_insert_payment_record BEFORE INSERT ON payment FOR EACH ROW BEGIN
IF NEW.PaymentDate>(SELECT CURRENT_DATE) THEN SET NEW.Remark='Not paid';
END IF;
END //



INSERT INTO payment(LoanID,typeID,PaymentDate,AmountPaid,Remark) VALUES(5,1,'2022-01-01',1400,'Partially paid');

SELECT * FROM payment;


START TRANSACTION;

SELECT @amountpaid:=MAX(AmountPaid) FROM payment;

INSERT INTO payment(LoanID,typeID,PaymentDate,AmountPaid,Remark) VALUES(4,1,'2021-09-10',4000,'Paid');

COMMIT;

ROLLBACK;

CREATE USER test_admin@localhost IDENTIFIED BY 'admin';

CREATE USER test_reader@localhost IDENTIFIED BY 'reader';

CREATE USER test_editor@localhost IDENTIFIED BY 'editor';

GRANT SHOW VIEW, ALTER, CREATE, EXECUTE, CREATE VIEW, DELETE, DROP, INDEX, REFERENCES, TRIGGER, LOCK TABLES  ON loansystem.* TO test_admin@localhost WITH GRANT OPTION;

GRANT EXECUTE, SELECT, SHOW VIEW, ALTER, CREATE, CREATE VIEW, INDEX, INSERT, REFERENCES, TRIGGER, UPDATE ON loansystem.* TO test_editor@localhost;

GRANT SELECT, SHOW VIEW  ON loansystem.* TO test_reader@localhost;

SHOW GRANTS FOR test_admin@localhost;

SHOW GRANTS for test_reader@localhost;

SHOW GRANTS for test_editor@localhost;


LOCK TABLE customer READ;

INSERT INTO customer(CustFname, CustLname, custPhone, CustAddress) VALUES('James','Smith','78911221','122-West Street, CA');

UNLOCK TABLES;
INSERT INTO customer(CustFname, CustLname, custPhone, CustAddress) VALUES('James','Smith','78911221','122-West Street, CA');

SELECT * FROM customer;

mysqldump -u root -p loansystem > D:\Data\loansystem.dump

mysqldump -u root -p loansystem > D:\Data\loansystem.sql







