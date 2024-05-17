-- QUESTION_2
CREATE TABLE student (
    Student_ID CHAR(4) PRIMARY KEY,
    Lastname VARCHAR(20) NOT NULL,
    Firstname VARCHAR(20) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    City VARCHAR(20) NOT NULL,
    State CHAR(2) NOT NULL,
    Zip VARCHAR(20) NOT NULL,
    Enroll_Date DATE NOT NULL,
    Undergrad BOOLEAN NOT NULL
);

CREATE TABLE Instructor (
    InstName VARCHAR(20) PRIMARY KEY,
    InstOffice CHAR(5) NOT NULL,
    InstRank VARCHAR(20) NOT NULL
);

CREATE TABLE Course (
    Course_ID CHAR(7) PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    CrHour INT NOT NULL,
    InstName VARCHAR(50) NOT NULL,
    FOREIGN KEY (InstName)
        REFERENCES Instructor (InstName)
);

CREATE TABLE Take (
    Student_ID CHAR(4) NOT NULL,
    Course_ID CHAR(7) NOT NULL,
    Grade CHAR(1),
    PRIMARY KEY (Student_ID , Course_ID),
    FOREIGN KEY (Student_ID)
        REFERENCES Student (Student_ID),
    FOREIGN KEY (Course_ID)
        REFERENCES Course (Course_ID)
);

INSERT INTO Student (Student_ID, LastName, FirstName, Address, City, State, Zip, Enroll_Date, Undergrad) VALUES
    ("0103", "O'Casey","Harriet",  "4088 Ottumwa Way", "Lexington", "KY", "40515", "1997-08-25", 1),
    ("0122", "Logan", "Janet",  "860 Charleston St.", "Lexington", "MA", "55500", "1998-01-19", 0),
    ("0123", "Hagen", "Greg",  "6065 Rainbow Falls Rd.", "Springfield", "MO", "65803", "1997-06-10", 1),
    ("0139", "Carroll", "Pat", "4018 Landers Lane", "Lafayette", "CO", "84548", "1997-08-25", 1),
    ("0148", "Wolf", "Bee", "1775 Bear Trail", "Cincinnati", "OH", "45208", "1998-01-19", 1),
    ("0167", "Krumpie", "Scott", "580 E Main St.", "Lexington", "KY", "40506-0034", "1997-08-25", 0),
    ("0171", "Harvey", "Eiliot", "34 Kerry Dr", "El Mano", "CO", "80646", "1997-08-25", 1),
    ("0181", "Zygote","Carrie", "8607 Ferndale St.", "Grenoble", "CA", "91360-4260", "1997-08-25", 1),
    ("0194", "Loftus","Abner", "8077 Montana Place", "Big Fish Bay", "WI", "53717", "1998-01-19", 1),
    ("0251", "Grainger", "John", "2256 N Sante Fe Dr.", "Iliase", "CA", "91210", "1998-01-19", 1);

INSERT INTO Instructor (InstName, InstOffice, InstRank) VALUES
    ("Lujan", "BE109", "Assistant"),
    ("Morris", "BE110", "Full"),
    ("Presley", "BE144", "Associate"),
    ("Wike", "BE220", "Full");

INSERT INTO Course (Course_ID, Title, CrHour, InstName) VALUES
    ("DIS 110", "Introduction to DOS", 2, "Lujan"),
    ("DIS 118", "Microcomputer Applications", 3, "Wike"),
    ("DIS 138", "Introduction to Windows", 2, "Lujan"),
    ("DIS 140", "Introduction to Database/Access", 3, "Presley"),
    ("DIS 150", "Introduction to Spreadsheet/Excel", 2, "Morris");

INSERT INTO Take (Student_ID, Course_ID, Grade) VALUES
    ("0103", "DIS 110", "A"),
    ("0103", "DIS 118", "B"),
    ("0122", "DIS 118", "A"),
    ("0122", "DIS 138", "C"),
    ("0122", "DIS 140", "C"),
    ("0123", "DIS 110", "D"),
    ("0123", "DIS 140", "E"),
    ("0148", "DIS 140", "A"),
    ("0148", "DIS 150", "B"),
    ("0167", "DIS 138", "C"),
    ("0167", "DIS 140", "C"),
    ("0167", "DIS 150", "B"),
    ("0181", "DIS 118", "A"),
    ("0181", "DIS 140", "A"),
    ("0181", "DIS 150", "D");
-- QUESTION_3    
DELIMITER $$
CREATE PROCEDURE GetStudentData()
BEGIN
    SELECT Student.FirstName, Student.LastName, Course.Title, Take.Grade
    FROM Student
    INNER JOIN Take ON Student.Student_ID = Take.Student_ID
    INNER JOIN Course ON Take.Course_ID = Course.Course_ID
    WHERE Course.CrHour >= 3;
END $$
DELIMITER ;
-- QUESTION_4
DELIMITER $$
CREATE FUNCTION Get_DateSpan(Student_ID CHAR(4))
RETURNS INTEGER
READS SQL DATA
BEGIN
    DECLARE Span DECIMAL(9, 2);
    DECLARE Enroll_Date DATE;
    SELECT Student.Enroll_Date INTO Enroll_Date FROM Student WHERE Student.Student_ID = Student_ID;
    SET Span = DATEDIFF(NOW(), Enroll_Date);
    RETURN Span;
END $$
DELIMITER ;
-- QUESTION_5
CREATE TABLE UpdatedGrades (
    Student_ID CHAR(4),
    Course_ID CHAR(7),
    Old_Grade CHAR(1),
    New_Grade CHAR(1),
    Date_Updated TIMESTAMP,
    PRIMARY KEY (Student_ID , Course_ID)
);

DELIMITER $$
CREATE TRIGGER Grades_After_Update
AFTER UPDATE ON Take
FOR EACH ROW
BEGIN
    INSERT INTO UpdatedGrades (Student_ID, Course_ID, Old_Grade, New_Grade, Date_Updated)
    VALUES (OLD.Student_ID, OLD.Course_ID, OLD.Grade, NEW.Grade, NOW());
END $$
DELIMITER ;

SELECT 
    *
FROM
    STUDENT;
SELECT 
    *
FROM
    INSTRUCTOR;
SELECT 
    *
FROM
    COURSE;
SELECT 
    *
FROM
    TAKE;
SELECT 
    *
FROM
    UPDATEDGRADES;
    
    
    
    
    