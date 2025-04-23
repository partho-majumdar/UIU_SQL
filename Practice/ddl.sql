CREATE TABLE IF NOT EXISTS table1(
	colA INT AUTO_INCREMENT,
    colB VARCHAR(40) NULL,
    colC DATETIME DEFAULT '2020-01-01 00:00:00',
    foreign_colA INT NULL,
    foreign_colP VARCHAR(30),
    
    CONSTRAINT pk_colA PRIMARY KEY(colA),
    CONSTRAINT fk_foreign_colA FOREIGN KEY(foreign_colA) REFERENCES table1(colA) ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS table2 (
	colP VARCHAR(30),
    colQ CHAR(10),
    colR DOUBLE NOT NULL,
    foreign_colA INT,
    
    CONSTRAINT pk_colP PRIMARY KEY(colP),
    CONSTRAINT un_colQ UNIQUE(colQ),
    CONSTRAINT fk_foreign_colA FOREIGN KEY(foreign_colA) REFERENCES table1(colA) ON DELETE CASCADE  
);

ALTER TABLE table2
ADD COLUMN colS DATETIME DEFAULT '2021-12-31 00:00:00';

ALTER TABLE table2
DROP COLUMN colS;

-- Remove primary key
ALTER TABLE table2
DROP PRIMARY KEY;

-- Add new primary key
ALTER TABLE table2
ADD CONSTRAINT pk_colR PRIMARY KEY (colR);

-- Drop unique key -- call using new name 
ALTER TABLE table2
DROP INDEX un_colQ;

-- Add new foreign key
ALTER TABLE table2
DROP PRIMARY KEY;

ALTER TABLE table2
ADD CONSTRAINT pk_colP PRIMARY KEY(colP);

ALTER TABLE table1
ADD CONSTRAINT pk_foreign_colP FOREIGN KEY(foreign_colP) REFERENCES table2(colP) ON DELETE SET NULL;

------------------------------ END DDL ------------------------------

------------------------------ DML START ------------------------------

-- Data Insert 
INSERT INTO table1 
VALUES(NULL, 'dbms', '2021-10-1 12:29:34', NULL, NULL),
(NULL, 'oop', '2018-05-21 09:12:51', NULL, NULL);
                         
INSERT INTO table1 (colB, foreign_colA, colC) 
VALUES('ml', 3, '2016-11-03 07:49:23'),
('new val', 1, '2028-10-09 04:13:37');

-- Data Update
UPDATE table1 
SET colB = 'cn', colC = '2039-11-19 01:00:29' WHERE colA > 2; 

-- Data Delete
DELETE FROM table1
WHERE colA > 3;
