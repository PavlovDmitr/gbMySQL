create schema lesson5;
use lesson5;

CREATE TABLE  CARS
(       
	id serial PRIMARY KEY, 
	Name VARCHAR(10), 
	Cost INT
	
);
INSERT INTO CARS (Name, Cost)
VALUES('Audi', 52642),
('Mercedes', 57127),
('Skoda', 9000),
('Volvo', 29000),
('Bentley', 350000),
('Citroen', 21000),
('Hammer', 41400),
('Volkswagen', 21600);

CREATE view b_cars as (select * from cars where Cost < 25000);
alter view b_cars as (select * from cars where Cost < 25000);
SELECT * FROM cars;

select * from b_cars;

alter view b_cars as (select * from cars where Cost < 30000);

create view sh_aud_cars as (select * from cars where Name in ('Skoda', 'Audi'));

select * from sh_aud_cars;

select * from an_groups;
delete from an_groups where gr_id >0;

drop table an_groups;

create table an_groups
(gr_id serial primary key,
gr_name varchar(200),
gr_temp int
);

drop table analysis;

create table analysis
(an_id serial primary key,
an_name VARCHAR(200),
an_cost int,
an_price INT,
an_group bigint unsigned,
foreign key (an_group) references an_groups (gr_id)
);

drop table orders;

create table orders
(ord_id serial primary key,
ord_datetime datetime,
ord_an bigint unsigned,
foreign key (ord_an) references analysis (an_id)
);

select * from an_groups;

insert INTO an_groups (gr_name, gr_temp)
VALUES("Freeze", -20), 
        ("Cold", 5),
        ("Hot", 20);

select * from analysis;

insert INTO analysis(an_name, an_cost, an_price, an_group)
VALUES('Кровь_общ', 700, 1500, (select gr_id from an_groups where gr_temp = 5)),
    ('Моча_общ', 400, 1000, (select gr_id from an_groups where gr_temp = 5)),
    ('Кровь_биохим', 800, 2000, (select gr_id from an_groups where gr_temp = -20)),
    ('Кровь_иммун', 750, 2100, (select gr_id from an_groups where gr_temp = -20)),
    ('Кровь_ПЦР', 500, 2200, (select gr_id from an_groups where gr_temp = 5)),
    ('Мокрота', 600, 1400, (select gr_id from an_groups where gr_temp = 20));

select * from orders;

insert into orders(ord_datetime, ord_an)
values('2020-02-01', (select an_id from analysis where an_name = 'Кровь_общ')),
('2020-02-01', (select an_id from analysis where an_name = 'Кровь_общ')),
('2020-02-01', (select an_id from analysis where an_name = 'Моча_общ')),
('2020-02-02', (select an_id from analysis where an_name = 'Кровь_иммун')),
('2020-02-02', (select an_id from analysis where an_name = 'Кровь_иммун')),
('2020-02-02', (select an_id from analysis where an_name = 'Мокрота')),
('2020-02-02', (select an_id from analysis where an_name = 'Моча_общ')),
('2020-02-02', (select an_id from analysis where an_name = 'Кровь_ПЦР')),
('2020-02-03', (select an_id from analysis where an_name = 'Моча_общ')),
('2020-02-03', (select an_id from analysis where an_name = 'Мокрота')),
('2020-02-03', (select an_id from analysis where an_name = 'Кровь_общ')),
('2020-02-03', (select an_id from analysis where an_name = 'Моча_общ')),
('2020-02-04', (select an_id from analysis where an_name = 'Кровь_ПЦР')),
('2020-02-04', (select an_id from analysis where an_name = 'Моча_общ')),
('2020-02-05', (select an_id from analysis where an_name = 'Мокрота')),
('2020-02-05', (select an_id from analysis where an_name = 'Кровь_общ')),
('2020-02-06', (select an_id from analysis where an_name = 'Моча_общ')),
('2020-02-06', (select an_id from analysis where an_name = 'Кровь_ПЦР')),
('2020-02-06', (select an_id from analysis where an_name = 'Кровь_общ')),
('2020-02-07', (select an_id from analysis where an_name = 'Моча_общ')),
('2020-02-07', (select an_id from analysis where an_name = 'Кровь_общ')),
('2020-02-07', (select an_id from analysis where an_name = 'Мокрота')),
('2020-02-10', (select an_id from analysis where an_name = 'Моча_общ')),
('2020-02-10', (select an_id from analysis where an_name = 'Кровь_общ')),
('2020-02-11', (select an_id from analysis where an_name = 'Мокрота')),
('2020-02-12', (select an_id from analysis where an_name = 'Кровь_ПЦР'));

select * from orders where ord_datetime between "2020-02-05 00:00:00" and ("2020-02-05 00:00:00" + interval 1 week);

create table railway
(train_id int,
station varchar(20),
station_time time,
time_to_next_station time
);



with cte_time as
(
	select *,
	lead (station_time, 1, '') over(partition by train_id order by station_time) - station_time as time_to_next_station
	from railway
)

select * from cte_time;

select date_sub('10:54:00', interval '10:00:00' hour_second);

select date_sub(station_time, interval 1 minute) from railway;


select *, 
time_format(sec_to_time(
	time_to_sec(lead (station_time, 1, '') over(partition by train_id order by station_time)) 
	- time_to_sec(station_time)), '%H:%i:%S') as time_to_next_station
from railway;
    

