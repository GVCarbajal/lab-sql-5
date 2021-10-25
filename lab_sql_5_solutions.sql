use sakila;

-- Drop column picture from staff.

alter table staff drop column picture;


/* A new person is hired to help Jon. 
Her name is TAMMY SANDERS, and she is a customer. Update the database accordingly. */

insert into staff values (3,'Tammy', 'Sanders',
(select address_id from customer where first_name = 'TAMMY' and last_name = 'SANDERS'),
'tammy.sanders@sakilastaff.org',2,1,'Tammy',null,CURRENT_TIME());


/* Add rental for movie "Academy Dinosaur" by Charlotte Hunter from Mike Hillyer at Store 1. 
You can use current date for the rental_date column in the rental table. */

insert into rental values (
(select (rental_id + 1) from payment order by rental_id desc limit 1), -- creating a rental_id
CURRENT_TIME(), -- specifying rental_date
(select inventory_id from inventory where store_id = 1 and film_id = -- getting inventory_id via film_id
(select film_id from film where title = 'ACADEMY DINOSAUR') limit 1), -- finding film_id given the title
(select customer_id from customer where first_name = 'CHARLOTTE' and last_name = 'HUNTER'),
null, -- there is no return date yet
(select staff_id from staff where first_name = 'MIKE' and last_name = 'HILLYER'),
CURRENT_TIME()); -- specifying last_update


/* Delete non-active users, but first, create a backup table deleted_users to store 
customer_id, email, and the date for the users that would be deleted. Follow these steps: 
- Check if there are any non-active users
- Create a table backup table as suggested
- Insert the non active users in the table backup table
- Delete the non active users from the table customer
*/

select * from customer where active = 0;

CREATE TABLE deleted_users(
  customer_id int UNIQUE NOT NULL,
  email varchar(254) DEFAULT NULL,
  `date` datetime DEFAULT NULL,
  CONSTRAINT PRIMARY KEY (customer_id)
) ;

insert into deleted_users values 
(16, 'SANDRA.MARTIN@sakilacustomer.org', current_time()),
(64, 'JUDITH.COX@sakilacustomer.org', current_time()),
(124, 'SHEILA.WELLS@sakilacustomer.org', current_time()),
(169, 'ERICA.MATTHEWS@sakilacustomer.org', current_time()),
(241, 'HEIDI.LARSON@sakilacustomer.org', current_time()),
(271, 'PENNY.NEAL@sakilacustomer.org', current_time()),
(315, 'KENNETH.GOODEN@sakilacustomer.org', current_time()),
(368, 'HARRY.ARCE@sakilacustomer.org', current_time()),
(406, 'NATHAN.RUNYON@sakilacustomer.org', current_time()),
(446, 'THEODORE.CULP@sakilacustomer.org', current_time()),
(482, 'MAURICE.CRAWLEY@sakilacustomer.org', current_time()),
(510, 'BEN.EASTER@sakilacustomer.org', current_time()),
(534, 'CHRISTIAN.JUNG@sakilacustomer.org', current_time()),
(558, 'JIMMIE.EGGLESTON@sakilacustomer.org', current_time()),
(592, 'TERRANCE.ROUSH@sakilacustomer.org', current_time());

delete from customer where active = 0;


