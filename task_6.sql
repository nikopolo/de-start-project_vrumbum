/*добавьте сюда запрос для решения задания 6*/
select count(*) as persons_from_usa_count
from car_shop.clients
where phone like '+1%';