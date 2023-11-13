SHOW TRANSACTION ISOLATION LEVEL;
 transaction_isolation
-----------------------
 read committed
(1 строка) -- проверяем уровень изоляции в С1

SHOW TRANSACTION ISOLATION LEVEL;
 transaction_isolation
-----------------------
 read committed
(1 строка) -- проеряем уровень изоляции в С2

BEGIN; -- запускаем ТЗ в С1

BEGIN; -- запускаем ТЗ в С2

SELECT rating FROM "Work_schema".pizzeria WHERE name = 'Pizza Hut';
 rating
--------
      4
(1 строка) -- запрашиваем данные в С1

postgres=*# update "Work_schema".pizzeria set rating = 3.6 where name = 'Pizza Hut';
UPDATE 1
postgres=*# commit;
COMMIT -- обновляем данные в С2 и тут же коммитим

postgres=*# SELECT rating FROM "Work_schema".pizzeria WHERE name = 'Pizza Hut';
 rating
--------
    3.6
(1 строка) -- запрашиваем данные внутри ТЗ в С1, получаем результат отличающицся от первого запроса (Аномалия неповторяющегося чтения)

commit;
COMMIT -- завершаем ТЗ в С1

SELECT rating FROM "Work_schema".pizzeria WHERE name = 'Pizza Hut';
 rating
--------
    3.6
(1 строка) --запрашиваем данные в С1 после коммита ТЗ, ничего не изменилось, данные были изменены вслепую для С1, плохо

SELECT rating FROM "Work_schema".pizzeria WHERE name = 'Pizza Hut';
 rating
--------
    3.6
(1 строка) -- запрашиваем данные в С2, с точки зрения С2 все в порядке