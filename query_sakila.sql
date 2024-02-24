use sakila;
show tables;

SELECT 
    COUNT(*) AS total_tables
FROM
    information_schema.tables
WHERE
    table_schema = 'sakila';

SELECT 
    table_name
FROM
    information_schema.tables
WHERE
    table_schema = 'sakila';
    

-- Scoprite quanti clienti si sono registrati nel 2006.
select count(*) from customer
where YEAR(create_date) = 2006;

-- Trovate il numero totale di noleggi effettuati il giorno 1/1/2006.
select distinct count(*) rental_01012006 from rental r
where DATE(r.rental_date) = 2006-1-1


-- Elencate tutti i film noleggiati nell’ultima settimana e tutte le informazioni legate al cliente che li ha noleggiati.
select film.film_id, film.title, c.customer_id, r.rental_date, concat(c.first_name,' ',c.last_name) as Nome_Cognome 
from film
join inventory using(film_id)
join rental r using(inventory_id)
join customer c using(customer_id)
join address using(address_id)
where week(r.rental_date) = (select MAX(week(rental_date)) from rental)
order by 2;


-- Calcolate la durata media del noleggio per ogni categoria di film.
select FLOOR(AVG(f.rental_duration)), c.name from film f
join film_category using(film_id)
join category c using (category_id) 
group by c.name


-- Trovate la durata del noleggio più lungo.
SELECT MAX(DATEDIFF(r.return_date, r.rental_date))
FROM rental r



/****************************************************************************************************************
								ESERCIZIO 2
*****************************************************************************************************/

-- Identificate tutti i clienti che non hanno effettuato nessun noleggio a gennaio 2006.


select c.customer_id, concat(first_name," ",last_name) from customer c where not exists
(select r.customer_id from rental r 
where DATE_FORMAT(rental_date, "%m - %Y") = "01 - 2006" 
and r.customer_id = c.customer_id);

-- oppure

SELECT c.customer_id, concat(first_name," ",last_name) as cliente
FROM customer c
LEFT JOIN rental r ON c.customer_id = r.customer_id AND MONTH(r.rental_date) = 1 AND YEAR(r.rental_date) = 2006
GROUP BY c.customer_id
HAVING COUNT(r.rental_id) = 0;

-- Elencate tutti i film che sono stati noleggiati più di 10 volte nell’ultimo quarto del 2005

select f.Title, count(r.rental_id) as n_rental
from film f
join inventory i using(film_id)
join rental r using(inventory_id)
where year(r.rental_date) = 2005
	and QUARTER(r.rental_date)= 4 --  between '2005-10-01'and '2005-12-31'
group by f.film_id 
having n_rental > 10;
 

-- Trovate il numero totale di noleggi effettuati il giorno 1/1/2006.

select count(*) as total_rental
from rental r
where date(r.rental_date) = '2006-01-01'


-- Calcolate la somma degli incassi generati nei weekend (sabato e domenica).
select SUM(p.amount) AS total_amount
from rental r
left join payment p using(rental_id)
where DAYOFWEEK(r.rental_date) IN (1, 7);

select SUM(p.amount) AS total_amount
from payment p
where DAYOFWEEK(p.payment_date) IN (1, 7);

-- Individuate il cliente che ha speso di più in noleggi.

SELECT concat(first_name," ",last_name) as cliente, SUM(p.amount) AS total
FROM customer c
JOIN payment p using(customer_id)
JOIN rental r using(rental_id)
GROUP BY cliente
ORDER BY total DESC
LIMIT 1;



-- Elencate i 5 film con la maggior durata media di noleggio.
SELECT f.film_id, f.title, AVG(DATEDIFF(r.return_date, r.rental_date)) AS avg_rental
from film f
JOIN inventory i using(film_id)
JOIN rental r using(inventory_id)
GROUP BY f.film_id, f.title
ORDER BY avg_rental DESC
LIMIT 5;


-- Calcolate il tempo medio tra due noleggi consecutivi da parte di un cliente.



WITH RentalDifferences AS 
(SELECT customer_id, return_date AS current_rental_end,
LEAD(rental_date) OVER (PARTITION BY customer_id ORDER BY rental_date) AS next_rental_start
FROM rental), 
RentalGaps AS (SELECT customer_id, DATEDIFF(next_rental_start, current_rental_end) AS gap
FROM RentalDifferences
WHERE next_rental_start IS NOT NULL AND current_rental_end IS NOT NULL)
SELECT customer_id,
AVG(gap) AS avg_gap_days
FROM RentalGaps
GROUP BY customer_id;


select c.customer_id, concat(c.first_name, " ", c.last_name) as Nome, 
avg(timestampdiff(day, r.rental_date, r.return_date)) as diff_tempo_noleggi
from customer as c
join rental as r using(customer_id)
left join rental as next_rental
on r.customer_id = next_rental.customer_id
and r.rental_date < next_rental.rental_date
group by c.customer_id
order by diff_tempo_noleggi desc;



SELECT
customer_id, AVG(DATEDIFF(next_rental_date, rental_date)) AS avg_time_between_rentals
FROM
(SELECT
r1.customer_id,
r1.rental_date,
MIN(r2.rental_date) AS next_rental_date
FROM rental AS r1
LEFT JOIN rental AS r2 ON r1.customer_id = r2.customer_id
AND r1.rental_date < r2.rental_date
GROUP BY r1.customer_id, r1.rental_date) AS rental_pairs
GROUP BY customer_id;


select c.customer_id, r.rental_id, avg(datediff(r.return_date, rental_date)) as avg_diff
from customer c
join rental r using(customer_id)
group by c.customer_id, r.rental_id


-- Individuate il numero di noleggi per ogni mese del 2005.

select count(rental_id) as n_rental, month(rental_date) as mese
from rental
where year(rental_date) = 2005
group by mese;


-- Trovate i film che sono stati noleggiati almeno due volte lo stesso giorno.

select f.film_id, f.title, count(day(r.rental_date)) as n_rentalperday, 
from film f
join inventory i using(film_id)
join rental r using(inventory_id)
group by day(r.rental_date), film_id
having n_rentalperday > 2;

-- Calcolate il tempo medio di noleggio.
select r.rental_id, avg(datediff(r.return_date, rental_date)) as avg_diff
from rental r
group by r.rental_id



