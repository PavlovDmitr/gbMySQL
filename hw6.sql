-- create schema lesson6;
use lesson6;

drop table Time_list;
create table Time_list
(
	id SERIAL PRIMARY KEY,
    Sec_Text VARCHAR(255),
    Sec_Int INT
);

insert into time_list (Sec_Text, Sec_Int)
values('Начало ', 28800),
('Обед', 46800),
('Конец обеда', 50400),
('Конец рабочего дня', 61200);

insert into time_list (Sec_Text, Sec_Int)
values('test1 ', 12323656),
('test2', 4643654),
('test3', 345435),
('test4', 5435352);

insert into time_list (Sec_Text, Sec_Int)
values('hw1 ', 123456);

SET GLOBAL log_bin_trust_function_creators = 1;

DELIMITER //
CREATE function GetFormatTime(input_sec INT)
returns varchar(255)
deterministic
BEGIN
	declare days int;
    declare hours int;
    declare minutes int;
    declare result varchar(255);
    
    set result = '';
    
    if input_sec >= 86400 then
		set days = input_sec DIV 86400;
        set input_sec = input_sec - 86400 * days;
        set result = concat(result, days, ' days ');
        
	end if;
    
	if input_sec >= 3600 then
		set hours = input_sec DIV 3600;
        set input_sec = input_sec - 3600 * hours;
        set result = concat(result, hours, ' hours ');
        
    end if;
    
	if input_sec >= 60 then
		set minutes = input_sec DIV 60;
        set input_sec = input_sec - 60 * minutes;
        set result =  concat(result, minutes, ' minutes ');
    end if;
    
    if input_sec between 1 and 60 then
		set result =  concat(result, input_sec, ' seconds');
    end if;
    set result = concat(result, ' ');
	return result;
END; // 
DELIMITER ;

select Sec_Text as 'Name', Sec_int as 'Seconds', GetFormatTime(Sec_int) as 'Format' from time_list;

drop function GetFormatTime;
select GetFormatTime(50) as 'Format';

 /*

drop procedure if exists `test`;

DELIMITER $$
create procedure GetFormatTime(input_sec INT)
deterministic
BEGIN
	declare days int;
    declare hours int;
    declare minutes int;
    declare result varchar(255);
    
    set result = '';
    
    if input_sec >= 86400 then
		set days = input_sec DIV 86400;
        set input_sec = input_sec - 86400 * days;
        set result = concat(result, days, ' days ');
        
	end if;
    
	if input_sec >= 3600 then
		set hours = input_sec DIV 3600;
        set input_sec = input_sec - 3600 * hours;
        set result = concat(result, hours, ' hours ');
        
    end if;
    
	if input_sec >= 60 then
		set minutes = input_sec DIV 60;
        set input_sec = input_sec - 60 * minutes;
        set result =  concat(result, minutes, ' minutes ');
    end if;
    
    if input_sec between 1 and 60 then
		set result =  concat(result, input_sec, ' seconds');
    end if;
    set result = concat(result, ' ');
	select result;

END; $$

DELIMITER ;

call test(125912);
*/

drop procedure GetEvenNumbers;

DELIMITER //
create procedure GetEvenNumbers(input_sec INT)
deterministic

BEGIN
	declare i int;
    declare result varchar(250) default '';
    set i = 2;
	while i <= input_sec do
		set result = concat(result, ' ', i);
        set i = i + 2;
	end while;
    select result;
END; //
DELIMITER ;

call GetEvenNumbers(100);















