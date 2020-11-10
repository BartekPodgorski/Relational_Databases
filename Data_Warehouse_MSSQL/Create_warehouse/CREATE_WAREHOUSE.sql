
CREATE TABLE [CLIENT] (
  [ID_client] bigint IDENTITY(1,1) NOT NULL,
  [PIN] char(11),
  [Sex] varchar(6),
  [Name_and_surname] varchar(50),
  [Nationality] varchar(150),
  [Age_category] varchar(20),
  [Skier_skill] varchar(15),
  [Grade] varchar(15),
  Insertion_date date,
  Deactivation_date date
  PRIMARY KEY ([ID_client]),
);

CREATE TABLE [SKIPASS] (
  [ID_skipass] bigint IDENTITY(1,1) NOT NULL,
  [ID_client] bigint NOT NULL,
  [range_of_skipass] varchar(10),
  [Skipass_no] varchar(11),
  [Price_category] varchar(15)
  PRIMARY KEY ([ID_skipass]),
);

ALTER TABLE SKIPASS ADD CONSTRAINT FK_SKIPASS_ID_client FOREIGN KEY (ID_client) REFERENCES CLIENT;


CREATE TABLE [LIFT] (
  [ID_lift] bigint IDENTITY(1,1) NOT NULL,
  [Lift_name] varchar(20),
  [Length_of_lift_category] varchar(30),
  [Time_going_up_category] varchar(30),
  [Couch_size_category] varchar(100),
  [Size_category] varchar(50),
  [Lift_type] varchar(15),
  PRIMARY KEY ([ID_lift])
);

CREATE TABLE [TIME](
[ID_time] bigint IDENTITY(1,1) NOT NULL,
[Hour] int,
[Minute] int,
[Second] int,
[Time_of_day] varchar(20),
PRIMARY KEY ([ID_time]),
CONSTRAINT CHK_Hour CHECK ([Hour]>=0 AND [Hour]<24),
CONSTRAINT CHK_Minute CHECK ([Minute]>=0 AND [Minute]<60),
CONSTRAINT CHK_Second CHECK ([Second]>=0 AND [Second]<60),
);

CREATE TABLE [DATE](
[ID_date] bigint IDENTITY(1,1) NOT NULL,
[Date] date,
[Year] int,
[Month] varchar(20),
[Month_no] int,
[Week_no] int,
[Day_of_the_week] varchar(10),
PRIMARY KEY ([ID_date])
);

CREATE TABLE [JUNK](
[ID_junk] bigint IDENTITY(1,1) NOT NULL,
[Couch_no] int,
[Application] varchar(10),
PRIMARY KEY ([ID_junk])
);

--DROP TABLE TICKET_SCAN;

CREATE TABLE [TICKET_SCAN] (
  [ID_date] bigint NOT NULL,
  [ID_time] bigint NOT NULL,
  [ID_skipass] bigint NOT NULL,
  [ID_lift] bigint NOT NULL,
  [ID_junk] bigint NOT NULL,
  [Scan_no] int,
  [Skier_age] int,
  [Lift_length] int,
  --[Route_length] int,
  PRIMARY KEY (ID_date, ID_time, ID_skipass, ID_lift, ID_junk),
);
-- zrobiæ [Lift_length]*1.5
-- ALTER TABLE TICKET_SCAN ADD CONSTRAINT TS_Route_length DEFAULT ([Lift_length]*1.5) FOR [Route_length];

ALTER TABLE TICKET_SCAN ADD CONSTRAINT FK_TICKET_SCAN_ID_date FOREIGN KEY (ID_date) REFERENCES [DATE];
ALTER TABLE TICKET_SCAN ADD CONSTRAINT FK_TICKET_SCAN_ID_time FOREIGN KEY (ID_time) REFERENCES [TIME];
ALTER TABLE TICKET_SCAN ADD CONSTRAINT FK_TICKET_SCAN_ID_lift FOREIGN KEY (ID_lift) REFERENCES LIFT;
ALTER TABLE TICKET_SCAN ADD CONSTRAINT FK_TICKET_SCAN_ID_skipass FOREIGN KEY (ID_skipass) REFERENCES SKIPASS;
ALTER TABLE TICKET_SCAN ADD CONSTRAINT FK_TICKET_SCAN_ID_junk FOREIGN KEY (ID_junk) REFERENCES JUNK;

CREATE TABLE [STATUS] (
	[ID_status] bigint IDENTITY(1,1) NOT NULL,
	[Status_description] varchar(8)
	PRIMARY KEY (ID_status),
);

CREATE TABLE [LIFT_STATUS_CHANGE] (
  [ID_lift] bigint NOT NULL,
  [ID_date_from] bigint NOT NULL,
  [ID_date_to] bigint NOT NULL,
  [ID_status] bigint NOT NULL,
  PRIMARY KEY (ID_lift, ID_date_from, ID_date_to, ID_status)
);

ALTER TABLE LIFT_STATUS_CHANGE ADD CONSTRAINT FK_LIFT_STATUS_CHANGE_ID_lift FOREIGN KEY (ID_lift) REFERENCES [LIFT];
ALTER TABLE LIFT_STATUS_CHANGE ADD CONSTRAINT FK_LIFT_STATUS_CHANGE_ID_date_from FOREIGN KEY (ID_date_from) REFERENCES [DATE];
ALTER TABLE LIFT_STATUS_CHANGE ADD CONSTRAINT FK_LIFT_STATUS_CHANGE_ID_date_to FOREIGN KEY (ID_date_to) REFERENCES [DATE];
ALTER TABLE LIFT_STATUS_CHANGE ADD CONSTRAINT FK_LIFT_STATUS_CHANGE_ID_status FOREIGN KEY (ID_status) REFERENCES [STATUS];

/*
select count(*) from TICKET_SCAN
select count(*) from Client
select * from TICKET_SCAN where ID_date = 529
select * from DATE where date = '2020-04-12'
select * from LIFT_STATUS_CHANGE where ID_status=2
select * from DATE where ID_date = 33
select * from TICKET_SCAN where ID_date = 33

select count(id_lift) from LIFT_STATUS_CHANGE where ID_date_from = 33 and ID_status = 2
*/