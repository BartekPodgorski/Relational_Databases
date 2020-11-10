CREATE TABLE promises (
    promise_id int IDENTITY(1,1) PRIMARY KEY,
    Date_of_submission date,
    Content_of_promise character varying(200) 
);

CREATE TABLE political_parties (
    party_id int IDENTITY(1,1) PRIMARY KEY,
    name_of_party character varying(50) NOT NULL,
    headquater character varying(50),
    leader character varying(50),
	number_of_members int,
	date_of_establish date
);

CREATE TABLE deputies (
    PESEL bigint PRIMARY KEY,
    name_of_deputy character varying(30),
	surname character varying(30),
	birth_day date,
    salaries int,
	occupation character varying(30),
	position character varying(30),
	political_view character varying(30) NOT NULL,
	constituency int,
	number_of_votes_obtained int,
);

CREATE TABLE commision (
    name_of_commision character varying(10) PRIMARY KEY,
	number_of_members int,
	goal_of_commission character varying(100),
);


CREATE TABLE votings (
    voting_number int IDENTITY(1,1) PRIMARY KEY,
	date_of_voting date,
	presence int,
	institution character varying(30),
	number_for int,
	number_against int,
	number_of_abstained int,
);

CREATE TABLE proposal (
	proposal_id int IDENTITY(1,1) PRIMARY KEY,
    name_of_proposal character varying(100),
	applicant character varying(30),
	type_of_proposal character varying(20),
);

CREATE TABLE election_program (
    party_id int PRIMARY KEY,
	FOREIGN KEY( party_id) REFERENCES political_parties
	ON DELETE NO ACTION
	ON UPDATE CASCADE,
    election_slogan character varying(100),
    number_of_promises int,
	introduction_period_years int,
);

CREATE TABLE property_declaration (
	PESEL bigint PRIMARY KEY,
	FOREIGN KEY (PESEL) REFERENCES deputies
	ON DELETE NO ACTION
	ON UPDATE CASCADE,
	social_status character varying(30),
	date_of_submission date,
	cash_resources int,
	share_value int,
	value_of_property int,
);
CREATE TABLE vote (
	PESEL bigint,
	voting_number int,
	how_vote character varying(30),
	PRIMARY KEY (PESEL, voting_number),
	FOREIGN KEY (PESEL) REFERENCES deputies
	ON UPDATE CASCADE,
	FOREIGN KEY (voting_number) REFERENCES votings
	ON DELETE CASCADE
	ON UPDATE CASCADE
);