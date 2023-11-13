-- BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ; -- с1 к1
-- BEGIN TRANSACTION ISOLATION LEVEL REPEATABLE READ; -- с2 к1

-- SELECT rating FROM "Work_schema".pizzeria WHERE name = 'Pizza Hut'; -- с1 к2
--  rating -- с1 вывод
-- --------
--       5
-- (1 строка)

-- SELECT rating FROM "Work_schema".pizzeria WHERE name = 'Pizza Hut'; -- с2 к2
--  rating  -- с2 вывод
-- --------
--       5
-- (1 строка)

-- update "Work_schema".pizzeria set rating = 4 where name = 'Pizza Hut'; -- c1 к3
-- UPDATE 1 -- с1 вывод

-- update "Work_schema".pizzeria set rating = 3.6 where name = 'Pizza Hut'; -- с2 к3
-- ОШИБКА:  нет доступа к таблице pizzeria -- с2 вывод

-- COMMIT TRANSACTION; -- с1 к4

-- COMMIT -- с1 вывод

-- COMMIT TRANSACTION; -- с2 к4

-- ROLLBACK -- с2 вывод, т.к. обновление не было выполненно, по причине недоступности таблицы, транзакция откатывается до изначального состояния


кажется тут все надо переделывать