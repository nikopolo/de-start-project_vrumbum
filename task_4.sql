/*добавьте сюда запрос для решения задания 4*/
select
	(client.first_name || ' ' || client.last_name) as person,
	string_agg((bc.brand || ' ' || cm.model), ', ')  as cars
from car_shop.car_sales car
join car_shop.clients client
on car.client_id = client.id
join car_shop.car_models cm
on car.car_model_id = cm.id
join car_shop.brand_cars bc
on cm.brand_id = bc.id
group by (client.first_name || ' ' || client.last_name)
order by person;