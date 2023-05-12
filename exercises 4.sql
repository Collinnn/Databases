-- 4.2.1 Joins

select deptName, COUNT(instID) from department natural left outer join instructor
Group by deptName;

-- 4.2.2
SELECT studname,title from student natural join takes 
join course using (courseID)
 order by studName asc; -- asc is not needed
 -- 4.2.3
-- on delete cascade has been used for the foreign keys,
-- since when removing we want the children to also be removed

-- 4.2.4
Create view SeniorInstructos as 
select InstID, instName, deptname
from Instructor where salary > 80000;
 
Create USER 'Karen'@'localhost'
Identified by 'setPassword';
create USER 'Linda'@'localhost'
Identified by 'setPassword';
create USER 'Susan'@'localhost'
Identified by 'setPassword';

select user from mysql.user;
grant all on university.* to 'Karen'@'localhost';
grant all on University.* to 'Susan'@'localhost';
show grants for 'Karen'@'localhost';
show grants for 'Linda'@'localhost';
show grants for 'Susan'@'localhost';

DROP USER 'Karen'@'localhost';
DROP USER 'Linda'@'localhost';
DROP USER 'Susan'@'localhost';




 