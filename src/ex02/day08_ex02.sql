BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ; -- запускаем ТЗ в С1

BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ; -- запускаем ТЗ в С2

SELECT rating FROM "Work_schema".pizzeria WHERE name = 'Pizza Hut';
 rating
--------
    3.6
(1 строка) -- запршиваем данные в С1

SELECT rating FROM "Work_schema".pizzeria WHERE name = 'Pizza Hut';
 rating
--------
    3.6
(1 строка) -- запрашиваем данные в С2

update "Work_schema".pizzeria set rating = 4 where name = 'Pizza Hut';
UPDATE 1 -- обновляем данные в С1, успешно обновляется

ОШИБКА:  не удалось сериализовать доступ из-за параллельного изменения -- в С2 снимается блокировка, появляется сообщение об ошибке

update "Work_schema".pizzeria set rating = 3.6 where name = 'Pizza Hut'; -- обновляем данные в С2, происходит блокировка

commit;
COMMIT -- коммитим в С1, успешно

commit;
ROLLBACK -- коммитим в С2, неуспешно, откатывается

SELECT rating FROM "Work_schema".pizzeria WHERE name = 'Pizza Hut';
 rating
--------
      4
(1 строка) -- запрашиваем данные в С1, изменения произошли по обновлению из ТЗ в С1

SELECT rating FROM "Work_schema".pizzeria WHERE name = 'Pizza Hut';
 rating
--------
      4
(1 строка) -- запрашиваем данные в С2, изменения произошли по обновлению из ТЗ в С1, измененеия из С2 были аннулированы из-за ошибки, следовательно потерялось обновление для повторяемого чтения

