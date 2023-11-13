BEGIN ISOLATION LEVEL SERIALIZABLE; -- запуск транзации С1

BEGIN ISOLATION LEVEL SERIALIZABLE; -- запуск ранзакции С2

select rating from "Work_schema".pizzeria where name = 'Pizza Hut'; -- команда 1 С1, результат rating = 5

update  "Work_schema".pizzeria set rating = 3 where name = 'Pizza Hut'; -- обновление данных С2

commit; -- коммит транзации С2

select rating from "Work_schema".pizzeria where name = 'Pizza Hut'; -- команда 2 С1, по-прежнему результат rating = 5

commit; -- коммит транзации С1 

select rating from "Work_schema".pizzeria where name = 'Pizza Hut'; -- команда 3 С1, результат rating = 3, т.е. реузльтат обновился только после коммита

select rating from "Work_schema".pizzeria where name = 'Pizza Hut'; -- команда 1 С2, результат rating = 3, т.е. реузльтат обновился после коммита