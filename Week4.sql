use university;

select deptName,count(InstName) from department natural join Instructor;

select * from takes 
natural join student where courseID is not null order by StudID asc;

/*Because it makes sense that when course is deleted, 
then the department shouldn't have a reference to it. */

create view SeniorInstructor as
select * from instructor where salary > 80000;

create user 'Karen'@'localhost' identified by 'setPassword';
create user 'Linda'@'localhost' identified by 'setPassword';
create user 'Susan'@'localhost' identified by 'setPassword';

grant select on *.* to 'Karen'@'localhost';
grant All on *.* to 'Linda'@'localhost';
grant All on *.* to 'Susan'@'localhost';

drop user 'Karen'@'localhost';
drop user 'Linda'@'localhost';
drop user 'Susan'@'localhost';







