update CLIENT
set skills_level = 'expert'
where PESEL = 21090527842;

update CLIENT
set skills_level = 'mid'
where PESEL = 36062853021;

update CLIENT
set quality_rating = 'good'
where PESEL = 20100402735;
select TOP 10 * from CLIENT

insert into [CLIENT] VALUES(00000000231,'male','Stefan Kowalski','Poland','mid','2000-03-01','good','2020-03-11',NULL)