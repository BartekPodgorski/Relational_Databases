/*1.Jakie s¹ œrednie zarobki w partiach politycznych?*/
select  political_view as Party, AVG(salaries) as Average_Salaries
	from property_declaration as pd
	join deputies
	on deputies.PESEL=pd.PESEL
	group by deputies.political_view
	order by Average_Salaries desc;

/*2.Jak g³osowa³a Pani Agnieszka Kaczorowska dnia 2019-11-11*/

select deputies.PESEL, surname,name_of_deputy,political_view,how_vote
	from deputies,vote,votings
	where deputies.PESEL=vote.PESEL and votings.voting_number=vote.voting_number
	and date_of_voting='2019-11-11' and surname='Kaczorowska' ;

/* 3.Ile g³osów ³acznie zdobyli przedstawiciele partii PIS*/

select Political_view , sum(number_of_votes_obtained)
	from deputies
	where political_view='PIS'
	group by political_view;

/* 4. Wyswietl tyc poslow z pisu ktorzy maja wynik wyzszy niz sredniaw kraju*/

select name_of_deputy,surname
	from deputies
	where political_view='PIS' and number_of_votes_obtained > (select avg(number_of_votes_obtained)
																	from deputies
																	where political_view='PIS'
																	group by political_view)
	group by name_of_deputy,surname;

/* To check
select political_view,surname,number_of_votes_obtained
from deputies
where political_view='PIS'; */

/*5.Który pose³ jest najbogatszy w polsce */

select  top 1 name_of_deputy,surname,cash_resources+share_value+value_of_property
	from property_declaration as pd
	join deputies
	on deputies.PESEL=pd.PESEL
	order by cash_resources+share_value+value_of_property desc;


/*6.Ktore partie polityczne maj wiecej czlonkow niz N+*/

select *
	from political_parties
	where number_of_members > (select number_of_members
								from political_parties
								where name_of_party='N+');

/*Za pomoca View pokaz ktore obietnice zostaly zgloszone przez PIS*/

create view check_proposal
as select name_of_proposal,applicant as "He kept a promise"
	from  proposal,promises
	join political_parties pp
	on pp.party_id=promises.party_id
	where content_of_promise=name_of_proposal and applicant=name_of_party;

select *
	from check_proposal
	where "He kept a promise"='PIS';

