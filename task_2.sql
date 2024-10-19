/*добавьте сюда запрос для решения задания 2*/
select
	bc.brand as brand_name,
	avg(extract(year from c.date)) as year,
	round(avg(c.price), 2) as price_avg
from car_shop.car_sales c
join car_shop.car_models cm
on c.car_model_id = cm.id
join car_shop.brand_cars bc
on cm.brand_id = bc.id
group by bc.brand, extract(year from c.date)
order by bc.brand, extract(year from c.date);