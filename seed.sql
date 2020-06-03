-- Practice Joins

-- 1
select * from invoice_line
where unit_price > .99;

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


-- 6


-- 7


-- 8