/*добавьте сюда запрос для решения задания 5*/

select
	oc.origin_country as brand_origin,
	max(c.price/(1 - cd.discount/100)) as price_max, /*Формула полной стоимости: цена_со_скидкой/(1 - скидка_в_процентах)*/
	min(c.price/(1 - cd.discount/100)) as price_min
from car_shop.car_sales c
join car_shop.car_models cm
on c.car_model_id = cm.id
join car_shop.brand_cars bc
on cm.brand_id = bc.id
join car_shop.origins_country oc
on bc.country_id = oc.id
join car_shop.clients_discount cd
on c.client_id = cd.id
where oc.origin_country != 'null'
group by oc.origin_country;