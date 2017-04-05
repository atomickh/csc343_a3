
-- Not enforced DTD restrictions:
--		work Title may have zero instances for a specific workExperience (workTitle+ not satisfied, only workTitle*)
--		honorifics may have zero instances for a specific Name (honorific+ not satisfied, only honorific*)
--      
-- There may be redundancies caused by more than one honorific (in Names table)
-- There may be redundancies caused by more than one major (in Educations table)

CREATE TABLE Interviews (
	FOREIGN KEY (rID) REFERENCES Resumes, 
	FOREIGN KEY (pID) REFERENCES Postings, 
	FOREIGN KEY (nID) REFERENCES Names,
	i_date DATE, 
	i_time TIME,
	location TEXT,
	FOREIGN KEY (aID) REFERENCES Assessments,
	PRIMARY KEY (rID, pID, nID)
);

CREATE TABLE Names (
	nID INT,
	forename TEXT,
	surname TEXT,
	honorific TEXT NOT NULL,
	PRIMARY KEY (nID)
);

CREATE TABLE honorifics (
	FOREIGN KEY (nID) REFERENCES Names,
	honor TEXT NOT NULL,
	PRIMARY KEY (nID, honor)	
);

CREATE TABLE Titles (
	FOREIGN KEY (nID) REFERENCES Names,
	title TEXT NOT NULL,
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
	FOREIGN KEY (aID) REFERENCES Assessments
	score INT NOT NULL,
	PRIMARY KEY (aID)
);

CREATE TABLE Postings (
	pID INT,
	position TEXT NOT NULL,
	PRIMARY KEY (pID)
);

CREATE TABLE Questions (
	qID INT,
	FOREIGN KEY (pID) REFERENCES Postings,
	question TEXT NOT NULL,
	PRIMARY KEY (qID)
);


CREATE TABLE Answers (
	FOREIGN KEY (aID) REFERENCES Assessments,
	FOREIGN KEY (qID) REFERENCES Questions,
	answer TEXT NOT NULL,
	PRIMARY KEY (aID, qID)
);

CREATE DOMAIN skill_type as VARCHAR(6)
	CHECK ( VALUE IN ('SQL', 'Scheme', 'Python', 'R', 'LaTeX') );

CREATE DOMAIN level_type as INT
	CHECK ( VALUE >= 1 AND VALUE <= 5 );

CREATE TABLE ReqSkills (
	FOREIGN KEY (pID) REFERENCES Postings,
	skill skill_type NOT NULL,
	level level_type NOT NULL,
	importance level_type NOT NULL,
	PRIMARY KEY (pID, skill)
);

CREATE TABLE Resumes (
	rID INT,
	FOREIGN KEY (nID) REFERENCES Names,
	DoB DATE, 
	citizenship TEXT,
	address TEXT,
	telephone VARCHAR(11),
	email TEXT,
	PRIMARY KEY (rID)
);

CREATE TABLE Summaries (
	FOREIGN KEY (rID) REFERENCES Resumes,
	summary TEXT,
	PRIMARY KEY (rID)
);

CREATE TABLE WorkExperiences (
	FOREIGN KEY (rID) REFERENCES Resumes,
	wID INT,
	where TEXT NOT NULL,
	start_date DATE,
	end_date DATE,
	PRIMARY KEY (wID),
	CHECK start_date <= end_date
);

CREATE TABLE WorkTitles (
	FOREIGN KEY (wID) REFERENCES WorkExperiences,
	workTitle TEXT,
	PRIMARY KEY (wID, workTitle)
);

CREATE TABLE WorkDescriptions (
	FOREIGN KEY (wID) REFERENCES WorkExperiences,
	description TEXT,
	PRIMARY KEY (wID, description)
);

CREATE TABLE Educations (
	eID INT,
	FOREIGN KEY (rID) REFERENCES Resumes,
	degreeName TEXT,
	institution TEXT,
	major TEXT,
	degreeLevel degree_type NOT NULL,
	start_date DATE,
	end_date DATE,
	CHECK start_date <= end_date,
	PRIMARY KEY (eID)
);

CREATE DOMAIN degree_type as varchar(13)
	CHECK (VALUE IN ('certificate', 'undergraduate', 'professional', 'masters', 'doctoral'))

CREATE TABLE Majors (
	FOREIGN KEY (eID) REFERENCES Educations,
	major TEXT,
	PRIMARY KEY (eID)
);
	
	
CREATE TABLE Minors (
	FOREIGN KEY (eID) REFERENCES Educations,
	minor TEXT,
	PRIMARY KEY (eID, minor)
);

CREATE TABLE Honors (
	FOREIGN KEY (eID) REFERENCES Educations,
	honor TEXT,
	PRIMARY KEY (eID)
);

CREATE TABLE HasSkills (
	FOREIGN KEY (rID) REFERENCES Resumes,
	skill skill_type NOT NULL,
	level level_type NOT NULL,
	PRIMARY KEY (rID, skill)
);

