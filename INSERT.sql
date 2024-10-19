/*Добавьте в этот файл запросы, которые наполняют данными таблицы в схеме автосалона*/
insert into car_shop.colors (color)
select distinct(split_part(auto, ',', 2))
from raw_data.sales s;

insert into car_shop.origins_country (origin_country)
select distinct(brand_origin)
from raw_data.sales;

-- создание временной таблицы для ФИО клиента
create table if not exists car_shop.temp_person (
	id serial primary key,
	fullname text, /*для PostgreSQL text не имеет никаких преимуществ или недостатков перед типом varchar без ограничения по длине*/
	phone text  /*может содержать текс и другие спецсимволы*/
);

insert into car_shop.temp_person(fullname, phone)
select
	distinct(trim(substr(replace(person_name, 'Jr.', ''), strpos(replace(person_name, 'Jr.', ''), '.') + 1))),
	phone
from raw_data.sales;

insert into car_shop.clients (first_name, last_name, phone)
select
	split_part(fullname, ' ', 1),
	split_part(fullname, ' ', 2),
	phone
from car_shop.temp_person;

insert into car_shop.brand_cars (brand, country_id)
select
	distinct(trim(split_part(split_part(auto, ',', 1), ' ', 1))),
	oc.id
from raw_data.sales s
join car_shop.origins_country oc
on s.brand_origin = oc.origin_country;

insert into car_shop.car_models (model, brand_id)
select
	distinct(trim(substr(split_part(auto, ',', 1), strpos(split_part(auto, ',', 1), ' ')))),
	bc.id
from raw_data.sales s
join car_shop.brand_cars bc
on trim(split_part(split_part(auto, ',', 1), ' ', 1)) = bc.brand;

insert into car_shop.car_sales (
	car_model_id,
	gasoline_consumption,
	price,
	date,
	color_id,
	client_id
	)
select
	cm.id,
	case
		when gasoline_consumption = 'null' then null
		else gasoline_consumption::real
	end,
	price::numeric(9, 2),
	date::date,
	col.id,
	c.id
from raw_data.sales s
left join car_shop.brand_cars bc
on trim(split_part(split_part(auto, ',', 1), ' ', 1)) = bc.brand
left join car_shop.car_models cm
on trim(substr(split_part(auto, ',', 1), strpos(split_part(auto, ',', 1), ' '))) = cm.model
join car_shop.colors as col
on split_part(auto, ',', 2) = col.color
join car_shop.origins_country oc
on s.brand_origin = oc.origin_country
join car_shop.clients c
on s.phone = c.phone;

insert into car_shop.clients_discount (client_id, auto_id, discount)
select
	cli.id,
	c.id,
	s.discount::smallint
from car_shop.clients cli
join car_shop.car_sales c
on c.client_id = cli.id
left join raw_data.sales s
on s.phone = cli.phone
and c.date = s.date::date;