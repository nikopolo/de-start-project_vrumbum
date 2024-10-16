/*добавьте сюда запрос для решения задания 1*/
select (((count(*) - count(gasoline_consumption))::real * 100)/count(*)) as nulls_percentage_gasoline_consumption
from car_shop.cars;