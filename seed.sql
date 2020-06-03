-- Joins

-- 1
select *
from invoice i
join invoice_lin il on il.invoice_id = i.invoice_id
where il.unit_price > .99;

-- 2
select i.invoice_date, c.first_name, c.last_name, i.total from invoice i
join customer c on i.customer_id > c.customer_id;

-- 3
select c.first_name, c.last_name, e.first_name, e.last_name
from customer c
join employee e on c.support_rep_id = e.employee_id;

-- 4
select al.title, ar.name
from album al
join artist ar on al.artist_id = ar.artist_id;

-- 5
select pt.track_id
from playlist_track pt
join playlist p on p.playlist_id = pt.playlist_track_id
where p.name = 'Music';

-- 6
select t.name
from track t
join playlist_track pt on pt.track_id = t.track_id
where pt.playlist_id = 5;

-- 7
select t.name, p.name
from track t
join playlist_track pt on t.track_id = pt.track_id
join playlist p on pt.playlist_id = p.playlist_id;

-- 8
select t.name, a.title
from track t
join album a on t.album_id = a.album_id
join genre g on g.genre_id = t.genre_id
where g.name = 'Alternative & Punk';

-- BD
select t.name, p.name, g.name, al.title, ar.name
from track t
join playlist_track pt on pt.track_id = t.track_id
join playlist p on p.playlist_id = pt.playlist_id
join genre g on g.genre_id = t.genre_id
join album al on al.album_id = t.album_id
join artist ar on ar.artist_id = al.artist_id
where p.name = 'Music';


-- Nested Queries

-- 1
select *
from invoice
where invoice_id in (select invoice_id from invoice_line where unit_price > 0.99);

-- 2
select *
from playlist_track
where playlist_id in (select playlist_id from playlist where name = 'Music');

-- 3
select name
from track
where track_id in (select track_id from playlist_track where playlist_id = 5);

-- 4
select *
from track
where genre_id in (select genre_id from genre where name = 'Comedy');

-- 5
select *
from track
where album_id in (select album_id from album where title = 'Fireball');

-- 6
select *
from track
where album_id in (select album_id from album where artist_id in (select artist_id from artist where name = 'Queen'));


-- Updating Rows

-- 1
update customer
set fax = null
where fax is not null;

-- 2
update customer
set company = 'Self'
where company is null;

-- 3
update customer
set last_name = 'Thompson'
where first_name = 'Julia'
and last_name = 'Barnett';

-- 4
update customer
set support_rep_id = 4
where email = 'luisrojas@yahoo.cl';

-- 5
update track
set composer = 'The darkness around us'
where genre_id = (select genre_id from genre where name = 'Metal')
and composer is null;


-- Group by

-- 1
select count(*), g.name
from track t
join genre g on t.genre_id = g.genre_id
group by g.name;

-- 2
select count(*), g.name
from track t
join genre g on g.genre_id = t.genre_id
where g.name = 'Pop'
or g.name = 'Rock'
group by g.name;

-- 3
select count(*), ar.name
from album al
join artist ar on ar.artist_id = al.artist_id
group by ar.name;


-- Use Distinct

-- 1
select distinct composer
from track;

-- 2
select distinct billing_postal_code
from invoice;

-- 3
select distinct company
from customer;


-- Delete Rows

-- 1 Copied code from summary to keep problem numbers consistent
CREATE TABLE practice_delete ( name TEXT, type TEXT, value INTEGER );
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'bronze', 50);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'bronze', 50);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'bronze', 50);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'silver', 100);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'silver', 100);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);
INSERT INTO practice_delete ( name, type, value ) VALUES ('delete', 'gold', 150);

SELECT * FROM practice_delete;

-- 2
delete from practice_delete
where type = 'bronze';

-- 3
delete from practice_delete
where type = 'silver';

-- 4
delete from practice_delete
where value = 150;


-- eCommerce Simulation

-- 1
create table users (
id serial primary key,
  name varchar(50),
  email text
);

create table products (
id serial primary key,
  name varchar(50),
  price numeric(9, 2)
);

create table orders (
id serial primary key,
  product_id int references products(id)
);

-- 2
insert into users (email, name)
values
('Fred@gmail.com', 'Fred'),
('Bob@yahoo.com', 'Bob'),
('George@hotmail.com', 'George');

insert into products (name, price)
values
('Hat', 9.99),
('Pants', 14.99),
('Shirt', 19.99);

insert into orders (product_id)
values
(1),
(2),
(3);

-- 3
    -- 3.1
    select *
    from orders o
    join products p on p.id = o.product_id
    where o.id = 1;

    -- 3.2
    select *
    from orders o
    join products p on p.id = o.product_id;

    -- 3.3
    select sum(price)
    from orders o
    join products p on p.id = o.product_id
    where o.id = 3;

-- 4
alter table orders
add column user_id int references users(id);

-- 5
update orders
set user_id = 1
where id = 1;

update orders
set user_id = 2
where id = 2;

update orders
set user_id = 3
where id = 3;

-- 6
    --6.1
    select *
    from orders o
    join users u on u.id = o.user_id
    where user_id = 1;

    --6.2
    select count(*)
    from orders o
    join users u on u.id = o.user_id
    where u.id = 1;

    select count(*)
    from orders o
    join users u on u.id = o.user_id
    where u.id = 2;

    select count(*)
    from orders o
    join users u on u.id = o.user_id
    where u.id = 3;