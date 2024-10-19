/*добавьте сюда запрос для решения задания 3*/
select
	extract(month from c.date) as month,
	extract(year from c.date) as year,
	round(avg(c.price), 2) as price_avg
from car_shop.car_sales c
group by extract(month from c.date), extract(year from c.date)
having extract(year from c.date) = '2022'
order by extract(month from c.date);