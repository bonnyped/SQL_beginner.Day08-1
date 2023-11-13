SHOW TRANSACTION ISOLATION LEVEL; -- проверяем уровень изолиции в С1

SHOW TRANSACTION ISOLATION LEVEL; -- проверяем уровень изолиции в С2

BEGIN; --запускаем ТЗ в С1

BEGIN; --запускаем ТЗ в С2

select rating from "Work_schema".pizzeria where name = 'Pizza Hut'; -- проверяем данные внутри ТЗ в С1

select rating from "Work_schema".pizzeria where name = 'Pizza Hut'; -- проверяем данные внутри ТЗ в С2

UPDATE "Work_schema".pizzeria SET rating = 4 WHERE name = 'Pizza Hut'; -- обновляем данные внутри ТЗ в С1

UPDATE "Work_schema".pizzeria SET rating = 3.6 WHERE name = 'Pizza Hut'; -- обновляем данные внутри ТЗ в С2

COMMIT; -- коммитим ТЗ в С1

COMMIT; -- коммитим ТЗ в С2

select rating from "Work_schema".pizzeria where name = 'Pizza Hut'; -- проверяем данные внутри ТЗ в С1

 rating
--------
    3.6
(1 строка) -- таков вывод в С1

 rating
--------
    3.6
(1 строка) -- таков же вывод в С2

-- т.е. данные обновились по последнему коммиту ТЗ из С2, обновленные данные из ТЗ в С1 были утеряна == Аномалия потери обновления