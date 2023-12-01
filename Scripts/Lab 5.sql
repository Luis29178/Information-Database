use example2202;

#enable = 1 desable = 0 for auto save 
set autocommit = 1;
set autocommit = 0; #allows use of rollback(undo)
commit;				#Commits work disbaleing rollback for all commited actions


set sql_safe_updates = 0;
set sql_safe_updates = 1;


alter table item
add quantityInStock int(11);

update item
set quantityInStock =10;

select * from item;


delimiter $$
drop trigger if exists orderQuantity$$

create trigger orderQuantity 
after insert on orderItem
for each row
begin
update item
	set quantityInStock = quantityInStock - orderitem.quantity;
end$$
delimiter ;

select itemId,itemName,quantityInstock from item where itemId =15 or itemId =23;



insert into orderitem (orderId, itemId, quantity)
values(1,15, 3);

insert into orderitem (orderId, itemId, quantity)
values(2,23, 5);

select itemId,itemName,quantityInStock from item where itemId =15 or itemId =23;


delimiter $$
drop trigger if exists UserStatusChange$$

create trigger UserStatusChange 
after update on users
for each row
begin
 IF (new.userStatusId != old.userStatusId) then
 insert into activitylog (activityDate,activityText,userId)
 values(GETDATE(),comcat('Stautus Update--Old:',old.userStatusId,'--New:',new.userStatusId),  userid);
 end if;
end$$
delimiter ;

## create numbers table
CREATE TABLE `numbers` (
  `n` int(11) NOT NULL,
  PRIMARY KEY (`n`)
) ENGINE=INNODB DEFAULT CHARSET=latin1;

/*!40000 ALTER TABLE `numbers` DISABLE KEYS */;
INSERT INTO `numbers` (`n`)
VALUES
	(1),	(2),	(3),	(4),	(5),	(6),	(7),	(8),
	(9),	(10),	(11),	(12),	(13),	(14),	(15),	(16),
	(17),	(18),	(19),	(20),	(21),	(22),	(23),	(24),
	(25),	(26),	(27),	(28),	(29),	(30),	(31),	(32),
	(33),	(34),	(35),	(36),    (37),	(38),	(39),	(40),
	(41),	(42),	(43),	(44),    (45),	(46),	(47),	(48),	
    (49),	(50),	(51),	(52),	(53),	(54),	(55),	(56),
	(57),	(58),	(59),	(60),	(61),	(62),	(63),	(64),
	(65),	(66),	(67),	(68),	(69),	(70),	(71),	(72),
	(73),	(74),	(75),	(76),	(77),	(78),	(79),	(80),
	(81),	(82),	(83),	(84),	(85),	(86),	(87),	(88),
	(89),	(90),	(91),	(92),	(93),	(94),	(95),	(96),
	(97),	(98),	(99),	(100);

select * from numbers;



select numbers.n , (select count(price) from dvd where dvd.price >(numbers.n-1) 
and dvd.price <=numbers.n) as DvdCount from numbers;



select numbers.n,
case when vehicleCount is not null then vehicleCount
else 0
end as vehicleCount
from numbers 
left join (
select cylinders, count(*) as vehicleCount from vehicle
join numbers on cylinders = numbers.n and vehicle.year =1985
group by cylinders
order by cylinders
) as vCount 
on vCount.cylinders = numbers.n
where numbers.n >= 0
and numbers.n <= 16;



