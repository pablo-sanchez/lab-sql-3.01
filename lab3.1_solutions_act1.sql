USE sakila;
-- 1.Drop column picture from staff.
alter table staff drop column picture;
select * from staff;

/* 2.A new person is hired to help Jon. Her name is TAMMY SANDERS, and she is a customer. 
Update the database accordingly.*/
select * from customer
where first_name='TAMMY' and last_name = 'SANDERS'; 
-- store_id, first_name, last_name, email(customer), address_id (79), active(1),
select * from staff;
-- staff_id, first_name, last_name, address_id, email(staff), store_id(2), active(1), username(Tammy), last_update(2023-01-25 14:30:51)


INSERT INTO staff(first_name, last_name, address_id, email, store_id, active, username, last_update) 
VALUES ('Tammy','Sanders',79,'Tammy.Sanders@sakilastaff.com',2,1,'Tammy', '2023-01-25 14:30:51');

/*3.Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 
You can use current date for the rental_date column in the rental table. Hint: 
Check the columns in the table rental and see what information you would need to add there. 
You can query those pieces of information. For eg., you would notice that you need customer_id
information as well. To get that you can use the following query:
select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER';
Use similar method to get inventory_id, film_id, and staff_id.*/ 
select * from rental;
select * from inventory;
select * from film;
select customer_id from sakila.customer
where first_name = 'CHARLOTTE' and last_name = 'HUNTER'; -- 130

insert into rental(rental_date, inventory_id, customer_id, staff_id)
values('2023-01-25 14:40:27',1,130,1);



