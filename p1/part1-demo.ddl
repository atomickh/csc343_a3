
-- Not enforced DTD restrictions:
--		work Title may have zero instances for a specific workExperience
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
	foreign key (aID) references Assessments,
	PRIMARY KEY (rID, pID, nID)
);

CREATE TABLE Names (
	nID INT,
	forename TEXT,
	surname TEXT,
	honorific TEXT NOT NULL,
	PRIMARY KEY (nID)
);

CREATE TABLE Titles (
	FOREIGN KEY (nID) references Names,
	title TEXT NOT NULL,
	PRIMARY KEY (nID, title)
);

create table Assessments (
	aID INT,
	techProficiency TEXT,
	communication TEXT,
	enthusiasm TEXT,
	primary key (aID)
);

create table Collegiality (
	foreign key (aID) references Assessments
	score INT NOT NULL,
	primary key (aID)
);

CREATE TABLE Postings (
	pID INT,
	position TEXT NOT NULL,
	PRIMARY KEY (pID)
);

create table Questions (
	qID INT,
	foreign key (pID) references Postings,
	question TEXT NOT NULL,
	primary key (qID)
);


create table Answers (
	foreign key (aID) references Assessments,
	foreign key (qID) references Questions,
	answer TEXT NOT NULL,
	primary key (aID, qID)
);

create domain skill_type as VARCHAR(6)
	CHECK ( VALUE IN ('SQL', 'Scheme', 'Python', 'R', 'LaTeX') );

create domain level_type as INT
	CHECK ( VALUE >= 1 AND VALUE <= 5 );

create table ReqSkills (
	foreign key (pID) references Postings,
	skill skill_type NOT NULL,
	level level_type NOT NULL,
	importance level_type NOT NULL,
	primary key (pID, skill)
);

create table Resumes (
	rID INT,
	foreign key (nID) references Names,
	DoB DATE, 
	citizenship TEXT,
	address TEXT,
	telephone VARCHAR(11),
	email TEXT,
	primary key (rID)
);

create table Summaries (
	foreign key (rID) references Resumes,
	summary text,
	primary key (rID)
);

create table WorkExperiences (
	foreign key (rID) references Resumes,
	wID INT,
	where text NOT NULL,
	start_date DATE,
	end_date DATE,
	primary key (wID),
	CHECK start_date <= end_date
);

create table WorkTitles (
	foreign key (wID) references WorkExperiences,
	workTitle TEXT,
	primary key (wID, workTitle)
);

create table WorkDescriptions (
	foreign key (wID) references WorkExperiences,
	description text,
	primary key (wID, description)
);

create table Educations (
	eID INT,
	foreign key (rID) references Resumes,
	degreeName TEXT,
	institution text,
	major text,
	degreeLevel degree_type NOT NULL,
	start_date date,
	end_date date,
	CHECK start_date <= end_date,
	primary key (eID)
);

create domain degree_type as varchar(13)
	CHECK (VALUE IN ('certificate', 'undergraduate', 'professional', 'masters', 'doctoral'))

create table Minors (
	foreign key (eID) references Educations,
	minor text,
	primary key (eID, minor)
);

create table Honors (
	foreign key (eID) references Educations,
	honor text,
	primary key (eID)
);

create table HasSkills (
	foreign key (rID) references Resumes,
	skill skill_type NOT NULL,
	level level_type NOT NULL,
	primary key (rID, skill)
);

