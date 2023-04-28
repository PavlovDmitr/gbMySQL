CREATE SCHEMA `gbcourse` ;
use `gbcourse`;

CREATE TABLE mobile_phones(
	id SERIAL PRIMARY KEY,    -- SERIAL = BIGINT NOT NULL AI UNIGUE
    product_name VARCHAR(50) NOT NULL,
    manufacturer VARCHAR(50) NOT NULL,
    product_count INT NOT NULL,
    price TEXT NOT NULL
);



insert into mobile_phones (
	product_name,
    manufacturer,
    product_count,
    price
    )
    values('iPhone X', 'Apple', 3, 76000),
    ('iPhone 8', 'Apple',2 , 51000),
    ('Galaxy S9','Samsung', 2, 56000),
    ('Galaxy S8','Samsung', 1, 41000),
    ('P20 Pro','Huawei', 5, 36000);
    
# select * from mobile_phones;

select * from mobile_phones where product_count > 2;

select * from mobile_phones where manufacturer = 'Samsung';

select * from mobile_phones where product_name like 'iPhone%';

select * from mobile_phones where manufacturer like '%Samsung%';

select * from mobile_phones where product_name regexp '[0-9]';

select * from mobile_phones where product_name regexp '[8]';






    
    
    