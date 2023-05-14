
-- 2.13
select * from student;

-- 2.14
select * from course;
-- 2.15
select studname from student;
-- 2.16
select studname,totcredits from student;
-- 2.17
select instName,DeptName,Salary from instructor;
-- 2.18
select * from student
where Totcredits >100;
-- 2.19
select * from student
where Totcredits > 100 AND DeptName = "Comp. Sci.";
-- 2.20
select * from classroom
where Building = "Painter" OR (capacity >25 AND capacity <50);
-- 2.21
select deptname from Department
where building <> 'Taylor';

-- 2.22
select CourseID,StudyYear,Grade from Takes,Student 
where takes.StudID=student.StudID And studName = "Shankar";
-- 2.23
insert course values('cs-102','Weekly Seminar','Comp. Sci.','0'),('cs-103','Monthly Seminar','Comp. Sci.','0');
-- 2.24
insert section values('cs-102',1,'Fall',2009,Null,Null,Null);
-- 2.25
Insert into takes
Select StudId, CourseId, SectionId, Semester , StudyYear, Null
From Student, Section
Where deptName = "Comp. Sci."
And CourseId = "CS-102";

-- 2.26 
Delete from takes 
where courseID = "cs-102" OR courseID = "cs-103";
-- 2.27
Update Department set building = "Taylor" 
WHERE DeptName = 'Finance';








