use universityDB;
-- 3.2.1
select max(salary) from instructor;

-- 3.2.2
select InstID, InstName from Instructor
where salary = (select max(salary) from instructor);
select instID, InstName from instructor
where salary >= All(select salary from instructor);
-- 3.2.3
delete from takes where courseID in ('Bio-101','bio-301');
-- 3.2.4
select studID,studname from student 
where studID not in (Select StudID from takes);
-- 3.2.5
select DeptName from Department
where budget >= ALL(Select budget from Department);
-- 3.2.6
select distinct studName
From Student
where StudName = some(select instName from instructor);
select distinct StudName from student,instructor
where studName = instName;
-- 3.2.7
CREATE TABLE GradePoints(
	grade VarChar(2) Primary Key,
    point Decimal(3,1));
    
Insert Into GradePoints Values ('A',4.0),('A-',3.7),('B',3.0),('B+',3.3),('B-',2.7),('C',2.0),('C+',2.3),('C-',1.7),('D',1.0),('D+',1.3),('D-',0.7),('F',0.0);

-- 3.2.8
select StudID,SUM(Credits*Point)
from (Takes natural join course) natural join GradePoints
group by studid;

-- 3.2.9
select StudID,studName,SUM(credits*Point)/sum(credits) as GPA
from takes Natural join Course natural join GradePoints natural join student
Group by STUDID
Order BY GPA DESC;
-- 3.2.10
(select StudID, sum(Credits*Point)
from takes natural join course natural join GradePoints 
group by studID)
Union
(select studID, 0 as GPA
from student
where studid not in (select studID from takes));

(select studID, sum(Point*credits)/sum(credits) as GPA
from (takes natural join course) natural join gradepoints 
group by studid)
Union
(select studID, null as GPA
from student 
where studid not in (select studid from takes))
order by GPA DESC;

-- 3.2.11
DROP TABLE IF EXISTS Testscores;
Create table Testscores(
student varchar(20) not null,
Test varchar(2) not null,
Score int,
Primary key(Student,test) );

Insert Into Testscores 
values('Brandt','A',47),('Brandt','B',50),('Brandt','C',null),('Brandt','D',null),
('Chavez','A',null),('Chavez','B',null),('Chavez','C',null),('Chavez','D',null);
select * from testscores;

select student, max(score)
from testscores
where score > 49;

select distinct student,score from testscores where score is null;







