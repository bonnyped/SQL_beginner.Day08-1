-- сессия 1 комманда 1
postgres=# select rating from "Work_schema".pizzeria where name = 'Pizza Hut';
 rating
--------
    4.6
(1 строка)

-- ссесия 2 комманда 1
postgres=# select rating from "Work_schema".pizzeria where name = 'Pizza Hut';
 rating
--------
    4.6
(1 строка)

-- сессия 1 комманда 2 и 3

postgres=# BEGIN TRANSACTION;
BEGIN
postgres=*# update "Work_schema".pizzeria set rating = 5 where name = 'Pizza Hut';
UPDATE 1

-- сессия 2 комманда 2 и вывод (без изменений, т.к. транзакция не завершена)

postgres=# select rating from "Work_schema".pizzeria where name = 'Pizza Hut';
 rating
--------
    4.6
(1 строка)

-- сессия 1 комманда 4 (завершенеие транзакции)

postgres=*# commit transaction;
COMMIT

-- сессия 2 комманда 3 и вывод, видны изменения, т.к. был сделан коммит

postgres=# select rating from "Work_schema".pizzeria where name = 'Pizza Hut';
 rating
--------
      5
(1 строка)