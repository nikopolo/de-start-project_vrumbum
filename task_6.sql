/*добавьте сюда запрос для решения задания 6*/
select count(*) as persons_from_usa_count
from car_shop.cars c
join car_shop.clients c2
on c.client_id = c2.id
where c2.phone like '+1%';