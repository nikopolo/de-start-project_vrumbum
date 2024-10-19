/*Добавьте в этот файл все запросы, для создания схемы данных автосалона и
 таблиц в ней в нужном порядке*/
create schema if not exists car_shop;

create table if not exists car_shop.colors (
	id serial primary key,
	color text not null constraint colors_color_unique unique /*для PostgreSQL text не имеет никаких преимуществ или недостатков перед типом varchar без ограничения по длине*/
);

create table if not exists car_shop.clients (
	id serial primary key,
	first_name text not null, /*для PostgreSQL text не имеет никаких преимуществ или недостатков перед типом varchar без ограничения по длине*/
	last_name text, /*для PostgreSQL text не имеет никаких преимуществ или недостатков перед типом varchar без ограничения по длине*/
	phone text not null /*может содержать текс и другие спецсимволы*/
);

create table if not exists car_shop.origins_country (
	id serial primary key,
	origin_country text /*для PostgreSQL text не имеет никаких преимуществ или недостатков перед типом varchar без ограничения по длине*/
);

create table if not exists car_shop.brand_cars (
	id serial primary key,
	brand text not null, /*для PostgreSQL text не имеет никаких преимуществ или недостатков перед типом varchar без ограничения по длине*/
	country_id integer references car_shop.origins_country /*ссылка на id иммеющий тип integer*/
);

create table if not exists car_shop.car_models (
	id serial primary key,
	model text not null, /*для PostgreSQL text не имеет никаких преимуществ или недостатков перед типом varchar без ограничения по длине*/
	brand_id integer references car_shop.brand_cars(id) /*ссылка на id иммеющий тип integer*/
);

create table if not exists car_shop.car_sales (
	id serial primary key,
	car_model_id integer references car_shop.car_models(id), /*ссылка на id иммеющий тип integer*/
	gasoline_consumption real, /*операции совершаются гораздо быстрее, чем с numeric*/
	price numeric(9, 2) not null, /*нужна точность при хранении и вычислениях*/
	date date, /*дата в данных указана без временной части*/
	color_id integer references car_shop.colors(id), /*ссылка на id иммеющий тип integer*/
	client_id integer references car_shop.clients(id) /*ссылка на id иммеющий тип integer*/
);

create table if not exists car_shop.clients_discount (
	id serial primary key,
	client_id integer references car_shop.clients, /*ссылка на id иммеющий тип integer*/
	auto_id integer references car_shop.car_sales, /*ссылка на id иммеющий тип integer*/
	discount smallint /*скидка имеет небольшой диапазон чисел*/
);