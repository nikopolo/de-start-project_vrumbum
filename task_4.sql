/*добавьте сюда запрос для решения задания 4*/
select
	(client.first_name || ' ' || client.last_name) as person,
	string_agg((bc.brand || ' ' || cm.model), ', ')  as cars
from car_shop.cars car
join car_shop.clients client
on car.client_id = client.id
join car_shop.brand_cars bc
on car.brand_car_id = bc.id
join car_shop.car_models cm
on car.car_model_id = cm.id
group by (client.first_name || ' ' || client.last_name)
order by person;