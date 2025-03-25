create table sms.Customer(
	customer_id int auto_increment primary key,
    customer_name varchar(255) not null
);

create table sms.Employee (
	employee_id int auto_increment primary key,
    employee_name varchar(255) not null,
    salary decimal(10, 2) not null
);

create table sms.Product (
	product_id int auto_increment primary key,
    product_name varchar(255) not null,
    list_price decimal(10, 2) not null
);

create table sms.Orders (
	order_id int auto_increment primary key,
    order_date datetime not null,
    customer_id int,
    employee_id int,
    foreign key (customer_id) references Customer(customer_id),
    foreign key (employee_id) references Employee(employee_id),
    total decimal(10, 2)
);

create table sms.LineItem (
	order_id int,
    product_id int,
	foreign key (order_id) references  Orders(order_id),
    foreign key (product_id) references Product(product_id),
    quantity int not null, 
    price decimal(10, 2)
);

-- câu 1
select c.customer_id, c.customer_name from sms.orders o
	join sms.customer c on o.customer_id = c.customer_id
    order by c.customer_id;

-- câu 2
select order_id, order_date, customer_id, employee_id, total from sms.orders
	where customer_id = 1
	order by total;

-- câu 3
select * from sms.lineitem
	where order_id = 1
	order by quantity;
    
-- câu 4
delimiter //
create function compute_order_total (order_id int) 
returns decimal(10, 2)
begin
	declare total decimal(10, 2);
    declare order_exists int;
    
    if order_id is null or order_id <= 0 then
		return 0;
    end if;
    
    select order_exists = count(*) from sms.orders 
    where sms.orders.order_id = order_id;
    
    if order_exists = 0 then
		return 0;
    end if;
    
    select total = sum(quantity * price) from sms.lineitem where sms.lineitem.order_id = order_id;
    return total;
end //
delimiter ;

-- câu 5 
delimiter //
create procedure addCus (p_customerName varchar(255))
begin
	if p_customerName is null then
		set message_text = 'Customer name cannot be null';
    end if;
    
    insert into sms.customer (customer_name)
    values (p_customerName);
end //
delimiter ;

-- câu 6
delimiter //
create procedure deleteCus (p_customer_id int)
begin
	declare cusExists int;
	if p_customer_id is null then
		set message_text = 'Customer id cannot be null';
	end if;
    
    select cusExists = count(*) from sms.customer
    where customer_id = p_customer_id;
    
    if cusExists = 0 then
		set message_text = 'Customer id does not exists';
	end if;
    
    delete from sms.lineitem
    where order_id in (
        select order_id from sms.orders 
        where customer_id = p_customer_id
    );
    
    delete from sms.orders
    where customer_id = p_customer_id;
    
    delete from sms.customer
    where customer_id = p_customer_id;
end //
delimiter ;

-- câu 7
delimiter //
create procedure updateCus (p_customer_id int, p_customer_name varchar(255))
begin
	declare cusExists int;
	if p_customer_id is null then
		set message_text = 'Customer id cannot be null';
	end if;
    
    if p_customer_name is null then
		set message_text = 'Customer name cannot be null';
	end if;
    
    select cusExists = count(*) from sms.customer
    where customer_id = p_customer_id;
    
    if cusExists = 0 then
		set message_text = 'Customer id does not exists';
	end if;
    
    update sms.customer
		set customer_name = p_customer_name
        where customer_id = p_customer_id;
end //
delimiter ;

-- câu 8
delimiter //
create procedure CreateOrder (p_orderDate datetime, p_cusId int, p_empId int)
begin
	declare cusExists int;
    declare empExists int;
    
    if p_orderDate is null then
		set message_text = 'Order date cannot be null';
	end if;
    
    if p_cusId is null then
		set message_text = 'Customer id cannot be null';
	end if;
    
    if p_empId is null then
		set message_text = 'Employee id cannot be null';
	end if;
    
    select empExists = count(*) from sms.employee
    where employee_id = p_empId;
    
    if empExists = 0 then
		set message_text = 'Employee id does not exists';
	end if;
    
    insert into sms.orders (order_date, customer_id, employee_id, total)
    values(p_orderDate, p_cusId, p_empId, 0.00);
end //
delimiter ;

-- câu 9
delimiter //
create procedure CreateLineItem (p_orderId int, p_prodId int, p_quantity int, p_price decimal(10, 2))
begin
	declare oderExists int;
    declare prodExists int;
    
    if p_orderId is null then
		set message_text = 'Order id cannot be null';
	end if;
    
    if p_prodId is null then
		set message_text = 'product id cannot be null';
	end if;
    
    if p_quantity is null or p_quantity <= 0 then
		set message_text = 'quantity cannot be null';
	end if;
    
    if p_price is null or p_price <= 0  then
		set message_text = 'price cannot be null';
	end if;
    
    select oderExists = count(*) from sms.orders
    where order_id = p_orderId;
    
    if oderExists = 0 then
		set message_text = 'Order id does not exists';
	end if;
    
    select prodExists = count(*) from sms.product
    where product_id = p_prodId;
    
    if prodExists = 0 then
		set message_text = 'Product id does not exists';
	end if;
    
    insert into sms.lineitem (order_id, product_id, quantity, price)
    values (p_orderId, p_prodId, p_quantity, p_price);
end//
delimiter ;

-- câu 10
delimiter //
create procedure updateOrderTotal (p_orderId int)
begin
	declare orderExists int;
    declare total decimal(10, 2);
    
    if p_orderId is null <= 0 then
		set message_text = 'Order id cannot be null';
	end if;
    
    select orderExists = count(*) from sms.orders
    where order_id = p_orderId;
    
    if orderExists = 0 then
		set message_text = 'Order id does not exists';
	end if;
    
    update sms.orders 
    SET total = v_total
    WHERE order_id = p_order_id;
end //
delimiter ;
