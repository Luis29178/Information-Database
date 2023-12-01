use example2202;

#enable = 1 desable = 0 for auto save 
set autocommit = 1;
set autocommit = 0; #allows use of rollback(undo)
commit;				#Commits work disbaleing rollback for all commited actions

select fuelType, avg(mpgHighway), avg(fuelCostAnnual)
from vehicle
group by fuelType
order by avg(mpgHighway) desc;


select * from uservehicle;

delete from vehicle where Cylinders = 4;

delete from uservehicle where VehicleId in (select VehicleId from vehicle where Cylinders = 4);

delimiter $$
drop function if exists itemCount$$

create function itemCount(Id int(11))
returns int(11)
Deterministic
reads sql data
begin
declare x int;
select quantityInStock into x from item where itemId =Id;
return (x);
end$$
delimiter ;


select * from orderitem;
delimiter $$
drop function if exists orderTotalPrice$$

create function orderTotalPrice(OId int(11))
returns decimal(10,2)
Deterministic
reads sql data
begin
declare x decimal(10,2);

select sum(orderItem.quantity*item.itemprice) into x
from  orderItem
join item on orderItem.orderId = OId and orderitem.itemId = item.itemId;

return (x);
end$$
delimiter ;

select concat(firstname,' ',lastname) FullName from users where userId = '6e6bab90-e1dd-11e2-87a1-b827ebe08a9f';

select occupationId from users where UserId = '6e6bab90-e1dd-11e2-87a1-b827ebe08a9f';

select count(*) from orders where UserId = '6e6bab90-e1dd-11e2-87a1-b827ebe08a9f';

select count(*) from userdvd where UserId = '40425e32-e5d2-11e2-b2eb-b827eb1cfd10';

select count(*) from uservehicle where userId ='1e51e81c-e2c9-11e2-8281-b827ebe08a9f';

delimiter $$
drop procedure if exists userInfo$$

create procedure userInfo(in UID varchar(50), out FullName varchar(100), 
out occupation int(11), out orderCount int(11), out ownedDVDCount int(11), out ownedVehicleCount int(11))
begin
    
    select concat(firstname,' ',lastname) into FullName from users where userID = UID;
    
    select occupationID into  occupation from users where userID = UID;
    
	select count(*) into orderCount from orders where UserId = UID;

	select count(*) into ownedDVDCount from userdvd where UserId = UID;

	select count(*) into ownedVehicleCount from uservehicle where userId = UID;

end$$
delimiter ;





