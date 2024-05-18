-- install the required extension
create extension postgres_fdw;

-- create a foreign server that connects to 'db_two'
create server same_server_postgres
    foreign data wrapper postgres_fdw
    options (dbname 'db_two');

-- create a user mapping for the current user
create user mapping for current_user
    server same_server_postgres
    options (user 'postgres', password 'lfifrjh,en');

-- define a foreign table that maps to 'remote_table' in 'db_two'
create foreign table local_remote_table (
   id integer,
   name varchar(255),
   age integer
)
server same_server_postgres
options (schema_name 'public', table_name 'remote_table');

-- select all records from the foreign table
select * from local_remote_table;

-- insert a new record into the foreign table
insert into local_remote_table (id, name, age) values (4, 'maksim talkachou', 30);

-- update an existing record in the foreign table
update local_remote_table set age = 40 where name = 'darya korbut';

-- delete a record from the foreign table
delete from local_remote_table where name = 'lizaveta piskunova';

create table local_table (
    id serial primary key,
    name varchar(255),
    email varchar(255) unique not null
);

-- the student has performed some operations using their own queries
insert into local_table (name, email) values
    ('darya korbut',  'darya.korbut@example.com'),
    ('dmitry pytaylo','dmitry.pytaylo@example.com'),
    ('lizaveta piskunova','lizaveta.piskunova@example.com');

select r.*, l.email
from local_remote_table as r 
left join local_table as l on (r.name = l.name);
