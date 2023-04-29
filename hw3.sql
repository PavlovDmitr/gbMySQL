
CREATE TABLE SALESPEOPLE(
	snum SERIAL PRIMARY KEY,    -- SERIAL = BIGINT NOT NULL AI UNIGUE
    sname TEXT NOT NULL,
    city TEXT NOT NULL,
    comm text
);

insert into SALESPEOPLE(snum, sname, city, comm) 
values(1001, 'Peel', 'London', '.12'),
   (1002, 'Serres', 'San Jose', '.13'),
   (1004, 'Motika', 'London', '.11'),
   (1007, 'Rifkin', 'Barcelona', '.15'),
   (1003, 'Axelrod', 'New York', '.10');
    
select * from SALESPEOPLE;

CREATE TABLE CUSTOMERS(
	cnum SERIAL PRIMARY KEY,    -- SERIAL = BIGINT NOT NULL AI UNIGUE
    cname TEXT NOT NULL,
    city TEXT NOT NULL,
    rating int,
    snum BIGINT unsigned,
    foreign key (snum) references SALESPEOPLE (snum)
);

insert into CUSTOMERS(cnum, cname, city, rating, snum) 
values(2001, 'Hoffman', 'London', 100, 1001),
   (2002, 'Giovanni', 'Rome', 200, 1003),
   (2003, 'Liu', 'San Jose', 200, 1002),
   (2004, 'Grass', 'Berlin', 300,  1002),
   (2006, 'Clemens', 'London', 100, 1001),
   (2008, 'Cisneros', 'San Jose', 300, 1007),
   (2007, 'Pereira', 'Rome', 100, 1004);

select * from CUSTOMERS;

# update CUSTOMERS set city = 'San Jose' where cnum=2008;

drop table orders;  -- table from hw2

CREATE TABLE ORDERS(
	onum SERIAL PRIMARY KEY,    -- SERIAL = BIGINT NOT NULL AI UNIGUE
    amt DECIMAL(6,2) default 0,
    odate date,
    cnum BIGINT unsigned,
    snum BIGINT unsigned,
    foreign key (cnum) references CUSTOMERS (cnum)
);

insert into ORDERS(onum, amt, odate, cnum, snum) 
values(3001, 18.69, '1990-10-03', 2008, 1007),
   (3003, 767.19, '1990-10-03', 2001, 1001),
   (3002, 1900.10, '1990-10-03', 2007, 1004),
   (3005, 5160.45, '1990-10-03', 2003, 1002),
   (3006, 1098.16, '1990-10-03', 2008, 1007),
   (3009, 1713.23, '1990-10-04', 2002, 1003),
   (3007, 75.75, '1990-10-04', 2004, 1002),
   (3008, 4723.00, '1990-10-05', 2006, 1001),
   (3010, 1309.95, '1990-10-06', 2004, 1002),
   (3011, 9891.88, '1990-10-06', 2006, 1001);

select * from ORDERS;

/*
1.	 Напишите запрос, который вывел бы таблицу со столбцами в следующем порядке: city, sname, snum, comm. (к первой или второй таблице, используя SELECT)
2.	 Напишите команду SELECT, которая вывела бы оценку(rating), сопровождаемую именем каждого заказчика в городе San Jose. (“заказчики”)
3.	 Напишите запрос, который вывел бы значения snum всех продавцов из таблицы заказов без каких бы то ни было повторений. (уникальные значения в  “snum“ “Продавцы”)
4*. 	Напишите запрос, который бы выбирал заказчиков, чьи имена начинаются с буквы G. Используется оператор "LIKE": (“заказчики”) https://dev.mysql.com/doc/refman/8.0/en/string-comparison-functions.html
5. 	Напишите запрос, который может дать вам все заказы со значениями суммы выше чем $1,000. (“Заказы”, “amt”  - сумма)
6.	Напишите запрос который выбрал бы наименьшую сумму заказа. (Из поля “amt” - сумма в таблице “Заказы” выбрать наименьшее значение)
7. 	Напишите запрос к таблице “Заказчики”, который может показать всех заказчиков, у которых рейтинг больше 100 и они находятся не в Риме.
*/

# 1
select city, sname, snum, comm from SALESPEOPLE;

# 2
select rating, cname from CUSTOMERS where city = 'San Jose';

# 3
select DISTINCT snum from orders;

# 4*
select * from customers where cname like 'G%';

# 5
select * from orders where amt > 1000;

# 6
select * from orders order by amt limit 1;

# 7
select cname from CUSTOMERS where rating > 100 and city != 'Rome';

create table specialty(
	id int unsigned not null auto_increment unique primary key,
    specialty text)
    ;

insert into specialty(specialty)
values('начальник'),
('инженер'),
('рабочий'),
('уборщик');


CREATE TABLE lesson3(
	id SERIAL PRIMARY KEY,    -- SERIAL = BIGINT NOT NULL AI UNIG
    name TEXT NOT NULL,
    surname TEXT NOT NULL,
    specialty int unsigned,
    seniority int unsigned,
    salary INT,
    age INT unsigned,
	foreign key (specialty) references specialty (id)  
);

insert into lesson3(name, surname, specialty, seniority, salary, age)
values('Вася', 'Васькин', 'начальник', 40, 100000, 60),
('Петя', 'Петькин', 'начальник', 8, 70000, 30),
('Катя', 'Катькина', 'инженер', 2, 70000, 25),
('Саша', 'Сашкин', 'инженер', 12, 50000, 35),
('Иван', 'Иванов', 'рабочий', 40, 30000, 59),
('Петр', 'Петров', 'рабочий', 20, 25000, 40),
('Сидор', 'Сидоров', 'рабочий', 10, 20000, 35),
('Антон', 'Антонов', 'рабочий', 8, 19000, 28),
('Юра', 'Юркин', 'рабочий', 5, 15000, 25),
('Максим', 'Воронин', 'рабочий', 2, 11000, 22),
('Юра', 'Галкин', 'рабочий', 3, 12000, 24),
('Люся', 'Лоськина', 'уборщик', 10, 10000, 49);

select lesson3.id, lesson3.name, lesson3.surname, specialty.specialty, lesson3.salary, lesson3.age
from specialty, lesson3 where lesson3.specialty = specialty.id;

/*
1. Отсортируйте поле “зарплата” в порядке убывания и возрастания
2. ** Отсортируйте по возрастанию поле “Зарплата” и выведите 5 строк с наибольшей заработной платой (возможен подзапрос)
3. Выполните группировку всех сотрудников по специальности , суммарная зарплата которых превышает 100000
*/
-- 1
select lesson3.id, lesson3.name, lesson3.surname, specialty.specialty, lesson3.salary, lesson3.age
from specialty, lesson3 where lesson3.specialty = specialty.id order by salary;

select lesson3.id, lesson3.name, lesson3.surname, specialty.specialty, lesson3.salary, lesson3.age
from specialty, lesson3 where lesson3.specialty = specialty.id order by salary desc;
-- 2
select lesson3.id, lesson3.name, lesson3.surname, specialty.specialty, lesson3.salary, lesson3.age
from specialty, lesson3 where lesson3.specialty = specialty.id order by salary desc limit 5;

-- 3
select specialty.specialty as spec, sum(lesson3.salary) as salsum
from specialty, lesson3 
where lesson3.specialty = specialty.id
group by spec
having salsum > 100000;

