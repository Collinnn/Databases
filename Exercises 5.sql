use university;
-- 5.2.1 
DELIMITER //
create function
 buildingCapacityFct(vBuilding varchar(20))
 returns int
begin
declare vMaxCap int;
select sum(capacity) into vMaxCap
from classroom where building = vBuilding; 
return vMaxCap;
end //
DELIMITER ;

select buildingCapacityFct('Watson');
select * from classroom
where capacity > buildingCapacityFct('Watson');

DELIMITER //
create trigger Timeslot_BEFORE_INSERT
before insert on timeslot for each row
begin
	if new.endtime <= new.startTime
	then signal sqlstate 'HY000'
		set mysql_errno = 1525,
        message_text = 'endtime is equal to or after starttime';
	END IF;
    if timeoverlapwithTable(new.timeslotID,new.daycode,new.starttime,new.endtime)
    then signal sqlstate 'HY000' SET mysql_errno = 1525,
    message_text = 'time interval overlaps with existing timeinterval for the same timeSlotID';
    end if;
    END // #END
    DELIMITER ;

insert timeslot values ('A','T','08:50:00','08:00:00');

SET Global event_scheduler = 1;
Create Table BallRolls (
RollNo integer auto_increment primary key,
LuckyNO integer);
Create event RollBall
on schedule every 10 second do
INSERT BallRolls (luckyNO) values (Floor(37*RAND()));

select * from BallROlls;
alter event RollBall DISABLE;

