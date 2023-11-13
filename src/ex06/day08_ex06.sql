BEGIN ISOLATION LEVEL REPEATABLE READ; -- запускаем ТЗ в режиме изоляции REPEATABLE READ в С1

BEGIN; -- запускаем ТЗ в С2

select sum(rating) from "Work_schema".pizzeria; -- запршиваем сумму рейтингов в ТЗ С1, результат 19.9

update "Work_schema".pizzeria set rating = 5 where name = 'Pizza Hut';
commit; -- обновляем рейтинг для Пиццы Хат до 5 и коммитим

select sum(rating) from "Work_schema".pizzeria; -- запршиваем сумму рейтингов в ТЗ С1, результат тот же 19.9, т.е. результат обновления данных недоступен
commit; -- коммитим ТЗ в С1

select sum(rating) from "Work_schema".pizzeria; -- проверяем сумму рейтингов после завершения ТЗ в С1, результат ФАНТОМНО изменился до 23.9

select sum(rating) from "Work_schema".pizzeria; -- проверяем результат запроса суммы рейтингов на С2, там тоже обновились данные результат 23.9