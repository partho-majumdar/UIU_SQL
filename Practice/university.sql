DROP DATABASE IF EXISTS UNIVERSITY;
CREATE DATABASE UNIVERSITY;
USE UNIVERSITY;

CREATE TABLE classroom(
    building VARCHAR(20),
    room_number INT,
    capacity INT,
    PRIMARY KEY (building,room_number)
    );
    
  CREATE TABLE department (
      dept_name VARCHAR(20),
      building VARCHAR(20),
      budget INT,
      PRIMARY KEY (dept_name)
  );

 CREATE TABLE course(
     course_id VARCHAR(20),
     title VARCHAR(20), 
     dept_name VARCHAR(20),
     credits INT,
     PRIMARY KEY (course_id),
     FOREIGN KEY (dept_name) REFERENCES department(dept_name)
     );
     
CREATE TABLE instructor(
    ID int,
    name VARCHAR(20) ,
    dept_name VARCHAR(20),
    salary INT,
     PRIMARY KEY (ID),
     FOREIGN KEY (dept_name) REFERENCES department(dept_name) );
    
CREATE TABLE section(
    course_id VARCHAR(20) ,
    sec_id INT ,
    semester VARCHAR(10) ,
    `year` YEAR ,
    building VARCHAR(20),  
    room_number int,
    time_slot_id char(1),
    PRIMARY KEY (course_id,sec_id,semester,`year`),
    FOREIGN KEY (building,room_number) REFERENCES classroom(building,room_number)
);
CREATE TABLE teaches(
    ID int,
    course_id VARCHAR(20)
    ,sec_id INT,
    semester VARCHAR(10), 
    `year` YEAR,
     PRIMARY KEY (ID,course_id,sec_id,semester,`year`),
    FOREIGN KEY (course_id,sec_id,semester,`year`) REFERENCES section(course_id,sec_id,semester,`year`),
     FOREIGN KEY (ID) REFERENCES instructor(ID)
    
    
);
CREATE TABLE student(
    ID int,
    name VARCHAR(20),
    dept_name VARCHAR(20) ,
    tot_cred INT,
    PRIMARY KEY (ID),
    FOREIGN  KEY (dept_name) REFERENCES department(dept_name)


);
CREATE TABLE takes(
    ID INT,
    course_id VARCHAR(20), 
    sec_id int,
    semester VARCHAR(10), 
    `year` YEAR ,
    grade VARCHAR(2),
     PRIMARY KEY (ID,course_id,sec_id,semester,`year`),
    FOREIGN KEY (course_id,sec_id,semester,`year`) REFERENCES section(course_id,sec_id,semester,`year`),
     FOREIGN KEY (ID) REFERENCES student(ID)


) ;
CREATE TABLE advisor(
    s_id INT ,
    i_id INT,
     PRIMARY KEY (s_ID,i_ID),
    FOREIGN KEY (s_id) REFERENCES student(ID),
     FOREIGN KEY (i_id) REFERENCES instructor(ID)

) ;

CREATE TABLE prereq(
    course_id VARCHAR(20),
    prereq_id VARCHAR(20),
    PRIMARY KEY (course_id,prereq_id),
    FOREIGN KEY( course_id) REFERENCES course ( course_id),
FOREIGN KEY( prereq_id) REFERENCES course ( course_id)

    

);
    
    
INSERT INTO classroom VALUES ( 'Packard' , 101,500),
							( 'Painter' , 514, 10),
                            ('Taylor', 3128 , 70),
                            ('Watson',100,30),
                            ('Watson',120,50);
                            
INSERT INTO department VALUES ('Biology' ,'Watson' , 90000),
							( 'Comp. Sci.' , 'Taylor' ,100000),
                            ('Elec. Eng.', 'Taylor' , 85000),
                            ('Finance' , 'Painter' , 120000),
                            ('History','Painter',50000),
                            ('Music' , 'Packard' , 80000),
                            ('Physics' ,'Watson' , 70000);

INSERT Into course VALUES ('BIO-101', 'Intro. to Biology', 'Biology', 4),  
('BIO-301', 'Genetics', 'Biology', 4),  
('BIO-399', 'Computational Biology', 'Biology', 3),   
('CS-101', 'Intro. to Computer Science', 'Comp. Sci.', 4), 
('CS-190', 'Game Design', 'Comp. Sci.', 4),  
('CS-315', 'Robotics', 'Comp. Sci.', 3),  
('CS-319', 'Image Processing', 'Comp. Sci.', 3),    
('CS-347', 'Database System Concepts', 'Comp. Sci.', 3),  
('EE-181', 'Intro. to Digital Systems', 'Elec. Eng.', 3), 
('FIN-201', 'Investment Banking', 'Finance', 3),    
('HIS-351', 'World History', 'History', 3), 
('MU-199', 'Music Video Production', 'Music', 3),  
('PHY-101', 'Physical Principles', 'Physics', 4);

INSERT INTO instructor VALUES 
 (10101, 'Srinivasan', 'Comp. Sci.', 65000), 
 (12121, 'Wu', 'Finance', 90000),   
 (15151, 'Mozart', 'Music', 40000),  
 (22222, 'Einstein', 'Physics', 95000), 
 (32343, 'El Said', 'History', 60000), 
 (33456, 'Gold', 'Physics', 87000),  
 (45565, 'Katz', 'Comp. Sci.', 75000),
 (58583, 'Califieri', 'History', 62000),  
 (76543, 'Singh', 'Finance', 80000),  
 (76766, 'Crick', 'Biology', 72000),  
 (83821, 'Brandt', 'Comp. Sci.', 92000),  
 (98345, 'Kim', 'Elec. Eng.', 80000);
 
 insert into section values  ('BIO-101', 1, 'Summer', 2009, 'Painter', 514, 'B'),  
 ('BIO-301', 1, 'Summer', 2010, 'Painter', 514, 'A'), 
 ('CS-101', 1, 'Fall', 2009, 'Packard', 101, 'H'), 
 ('CS-101', 1, 'Spring', 2010, 'Packard', 101, 'F'), 
 ('CS-190', 1, 'Spring', 2009, 'Taylor', 3128, 'E'),  
 ('CS-190', 2, 'Spring', 2009, 'Taylor', 3128, 'A'),
 ('CS-315', 1, 'Spring', 2010, 'Watson', 120, 'D'),  
 ('CS-319', 1, 'Spring', 2010, 'Watson', 100, 'B'),  
 ('CS-319', 2, 'Spring', 2010, 'Taylor', 3128, 'C'), 
 ('CS-347', 1, 'Fall', 2009, 'Taylor', 3128, 'A'),   
 ('EE-181', 1, 'Spring', 2009, 'Taylor', 3128, 'C'),  
 ('FIN-201', 1, 'Spring', 2010, 'Packard', 101, 'B'),  
 ('HIS-351', 1, 'Spring', 2010, 'Painter', 514, 'C'),  
 ('MU-199', 1, 'Spring', 2010, 'Packard', 101, 'D'),   
 ('PHY-101', 1, 'Fall', 2009, 'Watson', 100, 'A');
 
 
 INSERT into student VALUES   ('00128', 'Zhang', 'Comp. Sci.', 102), 
 ('12345', 'Shankar', 'Comp. Sci.', 32),  
 ('19991', 'Brandt', 'History', 80),
 ('23121', 'Chavez', 'Finance', 110),
 ('44553', 'Peltier', 'Physics', 56),  
 ('45678', 'Levy', 'Physics', 46),  
 ('54321', 'Williams', 'Comp. Sci.', 54),    
 ('55739', 'Sanchez', 'Music', 38),  
 ('70557', 'Snow', 'Physics', 0),   
 ('76543', 'Brown', 'Comp. Sci.', 58),    
 ('76653', 'Aoi', 'Elec. Eng.', 60),  
 ('98765', 'Bourikas', 'Elec. Eng.', 98), 
 ('98988', 'Tanaka', 'Biology', 120);
 
 INSERT into teaches VALUES  
 (10101, 'CS-101', 1, 'Fall', 2009),
 (10101, 'CS-315', 1, 'Spring', 2010),   
 (10101, 'CS-347', 1, 'Fall', 2009),  
 (12121, 'FIN-201', 1, 'Spring', 2010), 
 (15151, 'MU-199', 1, 'Spring', 2010), 
 (22222, 'PHY-101', 1, 'Fall', 2009),  
 (32343, 'HIS-351', 1, 'Spring', 2010),
 (45565, 'CS-101', 1, 'Spring', 2010), 
 (45565, 'CS-319', 1, 'Spring', 2010), 
 (76766, 'BIO-101', 1, 'Summer', 2009),
 (76766, 'BIO-301', 1, 'Summer', 2010),
 (83821, 'CS-190', 1, 'Spring', 2009), 
 (83821, 'CS-190', 2, 'Spring', 2009), 
 (83821, 'CS-319', 2, 'Spring', 2010), 
 (98345, 'EE-181', 1, 'Spring', 2009);

INSERT into takes VALUES (00128, "CS-101", 1, "Fall", 2009, "A"),
(00128, "CS-347", 1, "Fall", 2009, "A-"),
(12345, "CS-101", 1, "Fall", 2009, "C"),
(12345, "CS-190", 2, "Spring", 2009, "A"),
(12345, "CS-315", 1, "Spring", 2010, "A"),
(12345, "CS-347", 1, "Fall", 2009, "A"),
(19991, "HIS-351", 1, "Spring", 2010, "B"),
(23121, "FIN-201", 1, "Spring", 2010, "C+"),
(44553, "PHY-101", 1, "Fall", 2009, "B-"),
(45678, "CS-101", 1, "Fall", 2009, "F"),
(45678, "CS-101", 1, "Spring", 2010, "B+"),
(45678, "CS-319", 1, "Spring", 2010, "B"),
(54321, "CS-101", 1, "Fall", 2009, "A-"),
(54321, "CS-190", 2, "Spring", 2009, "B+"),
(55739, "MU-199", 1, "Spring", 2010, "A-"),
(76543, "CS-101", 1, "Fall", 2009, "A"),
(76543, "CS-319", 2, "Spring", 2010, "A"),
(76653, "EE-181", 1, "Spring", 2009, "C"),
(98765, "CS-101", 1, "Fall", 2009, "C-"),
(98765, "CS-315", 1, "Spring", 2010, "B"),
(98988, "BIO-101", 1, "Summer", 2009, "A"),
(98988, "BIO-301", 1, "Summer", 2010, "null");

INSERT into advisor VALUES (00128,45565), 
(12345,10101) , (23121 , 76543) ,(44553,22222) , (45678,22222),(76543,45565),(76653,98345),(98765,98345),(98988,76766);

INSERT INTO prereq VALUES ("BIO-301","BIO-101"),
("BIO-399", "BIO-101") , ("CS-190","CS-101"),  ("CS-315","CS-101"),("CS-319","CS-101"),("CS-347","CS-101"),("EE-181","PHY-101");