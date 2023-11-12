-- команды и вывод сессии №1
postgres=# select rating from "Work_schema".pizzeria where name = 'Pizza Hut';
 rating
--------
    4.6
(1 ёЄЁюър)


postgres=# update "Work_schema".pizzeria set rating = 4 where name = 'Pizza Hut';
UPDATE 1
postgres=# commit transaction;
ПРЕДУПРЕЖДЕНИЕ:  нет незавершённой транзакции
COMMIT
postgres=# select rating from "Work_schema".pizzeria where name = 'Pizza Hut';
 rating
--------
    3.6
(1 ёЄЁюър)






-- команды и вывод сессии №2
postgres=# select rating from "Work_schema".pizzeria where name = 'Pizza Hut';
 rating
--------
    4.6
(1 ёЄЁюър)


postgres=# update "Work_schema".pizzeria set rating = 3.6 where name = 'Pizza Hut';
UPDATE 1
postgres=# commit transaction;
ПРЕДУПРЕЖДЕНИЕ:  нет незавершённой транзакции
COMMIT
postgres=# select rating from "Work_schema".pizzeria where name = 'Pizza Hut';
 rating
--------
    3.6
(1 ёЄЁюър)
