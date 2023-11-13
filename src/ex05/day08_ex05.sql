SHOW TRANSACTION ISOLATION LEVEL; -- проверяем уровень изоляции в обеих сессиях, ждем read commited

BEGIN; -- запускаем транзакцию в 1ой и во 2ой сессиях

select sum(rating) from "Work_schema".pizzeria; -- запрашиваем сумму рейтинга в 1ой сессии, результат 21.9

update "Work_schema".pizzeria set rating = 1 where name = 'Pizza Hut';

commit; -- обновляем данные в сессии 2 и тут же коммитим

select sum(rating) from "Work_schema".pizzeria; -- запршиваем сумму еще раз в сессии 1, не делая при этом коммита, резльтат изменился 19.9

commit; -- в 1ой сессии

select sum(rating) from "Work_schema".pizzeria; -- повторный запрос суммы, теперь уже в обеих сессиях, результат обновленный 19.9 в силе