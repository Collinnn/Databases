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
where capacity > buildingCapacityFct('Watson')


