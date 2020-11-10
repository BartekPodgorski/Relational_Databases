SELECT *
	FROM vote
	WHERE voting_number=1;

DELETE FROM votings WHERE voting_number=1;

SELECT *
	FROM vote
	WHERE voting_number=1;

SELECT   party_id ,election_slogan,number_of_promises FROM election_program 

UPDATE election_program
	SET number_of_promises=4
	WHERE party_id=3

SELECT   party_id ,election_slogan,number_of_promises FROM election_program 

DROP TABLE promises

 