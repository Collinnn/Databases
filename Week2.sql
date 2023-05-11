SELECT CourseID,StudyYear,Grade from takes,student
where studname = "shankar"
and student.studID = takes.studid;

insert course values("CS-102","weekly seminar",Null,0);
insert course values("CS-103","monthly seminar",Null,0);

Select * from section;

insert section values("CS-102",1,"Fall",2009,null,null,null),
("CS-103",1,"EVENING",2109,null,null,null);

insert into takes
select studID ,CourseID,SectionID,semester,studyyear,null from student,section
where deptName = "Comp. Sci." AND CourseID = "CS-102"; 


Delete from takes 
where courseID = "CS-102" OR courseID= "CS-103";

Create table Person(DriverID varchar(5),
					DriverName varchar(5),
                    Address varchar(5),
                    primary key(DriverID)
                    );
create table Car(License varchar(5),
 model varchar(5),
 prodYear varchar (5), 
	primary key(License));

create table Accident(ReportNumber varchar(5),AccDate varchar(5),location varchar(5),
    primary key(ReportNumber));

create table owns(DriverID varchar(5),License varchar(5), primary key(DriverID,License)
, foreign key(DriverID) references Person(DriverID), foreign key(License) references Car(License));

create table Participants(ReportNumber varchar(5), License varchar(5),
 DriverID varchar(5), DamageAmount varchar(5), primary key(ReportNumber,License)
 , foreign key(DriverID) References Person(DriverId));





