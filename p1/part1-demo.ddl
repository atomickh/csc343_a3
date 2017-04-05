
-- Not enforced DTD restrictions:
--		work Title may have zero instances for a specific workExperience (workTitle+ not satisfied, only workTitle*)
--		Honorifics may have zero instances for a specific Name (honorific+ not satisfied, only honorific*)
--      Majors may have zero instances for a specific Education (major+ not satisfied, only major*)


CREATE TABLE Interviews (
	rID INT,
	pID INT,
	nID INT,
	aID INT,
	i_date DATE, 
	i_time TIME,
	location TEXT,
	FOREIGN KEY (rID) REFERENCES Resumes, 
	FOREIGN KEY (pID) REFERENCES Postings, 
	FOREIGN KEY (nID) REFERENCES Names,
	FOREIGN KEY (aID) REFERENCES Assessments,
	PRIMARY KEY (rID, pID, nID)
);

CREATE TABLE Names (
	nID INT,
	forename TEXT,
	surname TEXT,
	PRIMARY KEY (nID)
);

CREATE TABLE Honorifics (
	nID INT,
	honor_title TEXT NOT NULL,
	FOREIGN KEY (nID) REFERENCES Names,
	PRIMARY KEY (nID, honor)	
);

CREATE TABLE Titles (
	nID INT,
	title TEXT NOT NULL,
	FOREIGN KEY (nID) REFERENCES Names,
	PRIMARY KEY (nID, title)
);

CREATE TABLE Assessments (
	aID INT,
	techProficiency TEXT,
	communication TEXT,
	enthusiasm TEXT,
	PRIMARY KEY (aID)
);

CREATE TABLE Collegiality (
	aID INT,
	score INT NOT NULL,
	FOREIGN KEY (aID) REFERENCES Assessments,
	PRIMARY KEY (aID)
);

CREATE TABLE Postings (
	pID INT,
	position TEXT NOT NULL,
	PRIMARY KEY (pID)
);

CREATE TABLE Questions (
	qID INT,
	pID INT,
	question TEXT NOT NULL,
	FOREIGN KEY (pID) REFERENCES Postings,
	PRIMARY KEY (qID)
);


CREATE TABLE Answers (
	aID INT,
	qID INT,
	answer TEXT NOT NULL,
	FOREIGN KEY (aID) REFERENCES Assessments,
	FOREIGN KEY (qID) REFERENCES Questions,
	PRIMARY KEY (aID, qID)
);

CREATE DOMAIN skill_type as VARCHAR(6)
	CHECK ( VALUE IN ('SQL', 'Scheme', 'Python', 'R', 'LaTeX') );

CREATE DOMAIN level_type as INT
	CHECK ( VALUE >= 1 AND VALUE <= 5 );

CREATE TABLE ReqSkills (
	pID INT,
	skill skill_type NOT NULL,
	level level_type NOT NULL,
	importance level_type NOT NULL,
	FOREIGN KEY (pID) REFERENCES Postings,
	PRIMARY KEY (pID, skill)
);

CREATE TABLE Resumes (
	rID INT,
	nID INT,
	DoB DATE, 
	citizenship TEXT,
	address TEXT,
	telephone VARCHAR(11),
	email TEXT,
	FOREIGN KEY (nID) REFERENCES Names,
	PRIMARY KEY (rID)
);

CREATE TABLE Summaries (
	rID INT,
	summary TEXT,
	FOREIGN KEY (rID) REFERENCES Resumes,
	PRIMARY KEY (rID)
);

CREATE TABLE WorkExperiences (
	rID INT,
	wID INT,
	where TEXT NOT NULL,
	start_date DATE,
	end_date DATE,
	FOREIGN KEY (rID) REFERENCES Resumes,
	PRIMARY KEY (wID),
	CHECK start_date <= end_date
);

CREATE TABLE WorkTitles (
	wID INT,
	workTitle TEXT,
	FOREIGN KEY (wID) REFERENCES WorkExperiences,
	PRIMARY KEY (wID, workTitle)
);

CREATE TABLE WorkDescriptions (
	wID INT,
	description TEXT,
	FOREIGN KEY (wID) REFERENCES WorkExperiences,
	PRIMARY KEY (wID, description)
);

CREATE TABLE Educations (
	eID INT,
	rID INT,
	degreeName TEXT,
	institution TEXT,
	major TEXT,
	degreeLevel degree_type NOT NULL,
	start_date DATE,
	end_date DATE,
	FOREIGN KEY (rID) REFERENCES Resumes,
	CHECK start_date <= end_date,
	PRIMARY KEY (eID)
);

CREATE DOMAIN degree_type as varchar(13)
	CHECK (VALUE IN ('certificate', 'undergraduate', 'professional', 'masters', 'doctoral'))

CREATE TABLE Majors (
	eID INT,
	FOREIGN KEY (eID) REFERENCES Educations,
	major TEXT,
	PRIMARY KEY (eID)
);
	
	
CREATE TABLE Minors (
	eID INT,
	FOREIGN KEY (eID) REFERENCES Educations,
	minor TEXT,
	PRIMARY KEY (eID, minor)
);

CREATE TABLE Honors (
	eID INT,
	FOREIGN KEY (eID) REFERENCES Educations,
	honor TEXT,
	PRIMARY KEY (eID)
);

CREATE TABLE HasSkills (
	rID INT,
	FOREIGN KEY (rID) REFERENCES Resumes,
	skill skill_type NOT NULL,
	level level_type NOT NULL,
	PRIMARY KEY (rID, skill)
);

