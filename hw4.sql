CREATE TABLE  AUTO 
(       
	REGNUM VARCHAR(10) PRIMARY KEY, 
	MARK VARCHAR(10), 
	COLOR VARCHAR(15),
	RELEASEDT DATE, 
	PHONENUM VARCHAR(15)
);
INSERT INTO AUTO (REGNUM, MARK,	COLOR, RELEASEDT, PHONENUM )
VALUES(111114, 'LADA', 'КРАСНЫЙ', date'2008-01-01', '9152222221'),
(111115, 'VOLVO', 'КРАСНЫЙ', date'2013-01-01', '9173333334'),
(111116, 'BMW', 'СИНИЙ', date'2015-01-01', '9173333334'),
(111121, 'AUDI', 'СИНИЙ', date'2009-01-01', '9173333332'),
(111122, 'AUDI', 'СИНИЙ', date'2011-01-01', '9213333336'),
(111113, 'BMW', 'ЗЕЛЕНЫЙ', date'2007-01-01', '9214444444'),
(111126, 'LADA', 'ЗЕЛЕНЫЙ', date'2005-01-01', null),
(111117, 'BMW', 'СИНИЙ', date'2005-01-01', null),
(111119, 'LADA', 'СИНИЙ', date'2017-01-01', 9213333331);

select * from auto;

select color, count(color) 
from auto 
where mark = 'BMW' or mark = 'LADA'
group by color;

select count(MARK) as 'BMW', (select count(MARK) from auto where mark != 'BMW') as 'NOT BMW'
from auto
where mark = 'BMW' ;

create table test_a (id INT, test varchar(10));
create table test_b (id INT);

insert into test_a(id, test) values
(10, 'A'),
(20, 'A'),
(30, 'F'),
(40, 'D'),
(50, 'C');
insert into test_b(id) values
(10),
(30),
(50);
 
 
select id, test from test_a where id <> all (select id from test_b);
