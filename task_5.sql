/*добавьте сюда запрос для решения задания 5*/
select
	oc.origin_country as brand_origin,
	max(c.price + (c.price * cd.discount)/100) as price_max,
	min(c.price + (c.price * cd.discount)/100) as price_min
from car_shop.cars c
join car_shop.origins_country oc
on c.brand_origin_id = oc.id
join car_shop.clients_discount cd
on c.id = cd.auto_id
where oc.origin_country != 'null'
group by oc.origin_country;