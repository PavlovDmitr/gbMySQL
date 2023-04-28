use `gbcourse`;

CREATE TABLE sales(
	id SERIAL PRIMARY KEY,    -- SERIAL = BIGINT NOT NULL AI UNIGUE
    order_date DATE NOT NULL,
    product_id TEXT NOT NULL,
    product_count INT    
);

insert into sales(
	order_date,
    product_id,
    product_count
    )
    values('2022-01-01', 'OrById-00001', 156),
    ('2022-01-02', 'OrById-00002', 180),
    ('2022-01-03', 'OrById-00003', 21),
    ('2022-01-04', 'OrById-00004', 124),
	('2022-01-05', 'OrById-00005', 341);
    
   
select * from sales;

ALTER TABLE sales
ADD COLUMN order_type TEXT;

UPDATE sales SET order_type = 'Маленький заказ' WHERE product_count < 100 limit 100; #limit для обхода safe mode
UPDATE sales SET order_type = 'Средний заказ' WHERE id > 0 and product_count between 100 and 300; #другой вариант с указанием первичного ключа в конструкции where
UPDATE sales SET order_type = 'Большой заказ' WHERE id > 0 and product_count > 300;

select id as 'id заказа', order_type as 'Тип заказа' from sales ;

CREATE TABLE orders(
	id SERIAL PRIMARY KEY,    -- SERIAL = BIGINT NOT NULL AI UNIGUE
    employee_id TEXT NOT NULL,
    amount DECIMAL(6,2) default 0,
    order_status TEXT
);

insert into orders(
	employee_id,
    amount,
    order_status
    )
    values('e03', 15.00, 'OPEN'),
    ('e01', 25.50, 'OPEN'),
    ('e05', 100.70, 'CLOSED'),
    ('e02', 22.18, 'OPEN'),
    ('e04', 9.50, 'CANCELLED');
    
select id, employee_id, amount,
    order_status,
	case
		when order_status = 'OPEN' THEN 'Order is in open state'
        when order_status = 'CLOSED' THEN 'Order is closed'
        when order_status = 'CANCELLED' THEN 'Order is cancelled'
        ELSE 'Не определено'
	END AS 'full_order_status'
from orders;