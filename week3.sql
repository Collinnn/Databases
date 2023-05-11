use university;

SELECT AVG(Salary) from instructor;

SELECT * from instructor
where salary = (Select max(salary) from instructor);

Delete from takes
where courseID in (select courseID from takes where courseID = "BIO-101" and courseID = "BIO-301");

select * from student
where STUDID not in(select studid from takes);

select * from department 
where budget >= ALL(Select budget from department);

select * from student 
where studname = some(select instName from instructor);
drop table GRadepoint;
create table GRADEPOINT 
	( grade VARCHAR(2) PRIMARY KEY,
	  Points DECIMAL(2,1));
 insert gradePOInt values
 ('A', 4.0),
('A-', 3.7),
('B', 3.0),
('B+', 3.3),
('B-', 2.7),
('C', 2.0),
('C+', 2.3),
('C-', 1.7),
('D', 1.0),
('D+', 1.3),
('D-', 0.7),
('F', 0.0);

select studid, grade from takes;

select * from gradepoint;

select StudID,sum(Points*credits) as TotalGradepoint from gradepoint 
natural Join takes natural join course
group by (StudID);

select StudID,sum(Points*credits)/sum(credits) as GPA from gradepoint 
natural Join takes natural join course
group by (StudID)
order by GPA DESC;

(select StudID,sum(Points*credits)/sum(credits) as GPA from gradepoint
natural join takes natural join course)
UNION 
(select StudID,null from student
where studID not in(select studid from takes));

create table testscores(
	student varchar(20),
    test varchar(1),
    score integer,
    primary key(student, test)
    );

insert testscores values
("Brandt", "A", 47),
("Brandt","B",50),
("Brandt","C",null),
("Brandt","D",null),
("Chavez","A",52),
("Chavez","B",45),
("Chavez","C",53),
("Chavez","D",null);

select student,test,max(score) from testscores
group by student
having avg(score) > 49;

Select * from student where studName 
not in(select * from testscores);



