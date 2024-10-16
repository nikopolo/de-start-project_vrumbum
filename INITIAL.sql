/*сохраните в этом файле запросы для первоначальной загрузки данных - создание схемы raw_data и таблицы sales и наполнение их данными из csv файла*/
create schema if not exists raw_data;

create table if not exists raw_data.sales(
	id integer primary key,
	auto varchar,
	gasoline_consumption varchar,
	price varchar,
	date varchar,
	person_name varchar,
	phone varchar,
	discount varchar,
	brand_origin varchar
);

copy raw_data.sales(id,auto,gasoline_consumption,price,date,person_name,phone,discount,brand_origin) FROM 'C:\Temp\cars.csv' CSV HEADER;
