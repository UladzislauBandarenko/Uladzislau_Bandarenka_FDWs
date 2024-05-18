-- create a sample table
create table remote_table (
    id serial primary key,
    name varchar(255),
    age integer
);

-- insert sample data into the table
insert into remote_table (name, age) values
    ('Uladzislau Bandarenka', 20),
    ('Artur Podpalov', 19),
    ('Mikita Dubravin', 20);






