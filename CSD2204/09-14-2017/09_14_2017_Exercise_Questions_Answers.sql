

show tables;

select * from Pieces;
+------+----------+
| Code | Name     |
+------+----------+
|    1 | Sprocket |
|    2 | Screw    |
|    3 | Nut      |
|    4 | Bolt     |
+------+----------+
select * from Providers;
+------+----------------------+
| Code | Name                 |
+------+----------------------+
| HAL  | Clarke Enterprises   |
| RBT  | Susan Calvin Corp.   |
| TNBC | Skellington Supplies |
+------+----------------------+
select * from provides; 
+------+-------+----------+-------+
| Code | Piece | Provider | Price |
+------+-------+----------+-------+
|    1 |     1 | HAL      | 10.00 |
|    2 |     1 | RBT      | 15.00 |
|    3 |     2 | HAL      | 20.00 |
|    4 |     2 | RBT      | 15.00 |
|    5 |     2 | TNBC     | 14.00 |
|    6 |     3 | RBT      | 50.00 |
|    7 |     3 | TNBC     | 45.00 |
|    8 |     4 | HAL      |  5.00 |
|    9 |     4 | RBT      |  7.00 |
+------+-------+----------+-------+

-- 5.1
-- Select the name of all the pieces. 
MariaDB [mytestdb]> SELECT Name FROM pieces;
+----------+
| Name     |
+----------+
| Sprocket |
| Screw    |
| Nut      |
| Bolt     |
+----------+
4 rows in set (0.00 sec)

-- 5.2 
-- Select all the providers' data. 
MariaDB [mytestdb]> SELECT * FROM providers;
+------+----------------------+
| Code | Name                 |
+------+----------------------+
| HAL  | Clarke Enterprises   |
| RBT  | Susan Calvin Corp.   |
| TNBC | Skellington Supplies |
+------+----------------------+
3 rows in set (0.00 sec)

 
-- 5.3
-- Obtain the average price of each piece (show only the piece code and the average price).
MariaDB [mytestdb]> SELECT pi.Name,AVG(pr.Price) from Pieces as pi INNER JOIN Provides as pr ON pr.Piece = pi.code GROUP BY pi.code;
+----------+---------------+
| Name     | AVG(pr.Price) |
+----------+---------------+
| Sprocket |     12.500000 |
| Screw    |     16.333333 |
| Nut      |     47.500000 |
| Bolt     |      6.000000 |
+----------+---------------+
4 rows in set (0.01 sec)

-- 5.4 
-- Obtain the names of all providers who supply piece 1.


/* Without subquery */
 
MariaDB [mytestdb]> SELECT DISTINCT Provider FROM Provides WHERE Piece = 1;
+----------+
| Provider |
+----------+
| HAL      |
| RBT      |
+----------+
2 rows in set (0.00 sec)    
/* With subquery */
MariaDB [mytestdb]>  SELECT DISTINCT Provider FROM Provides WHERE piece = (SELECT code FROM pieces WHERE code = 1 );
+----------+
| Provider |
+----------+
| HAL      |
| RBT      |
+----------+
2 rows in set (0.00 sec)

-- 5.5
-- Select the name of pieces provided by provider with code "HAL".

/* Without EXISTS subquery */ 
SELECT pi.Name FROM Pieces as pi
INNER JOIN Provides as pr ON pr.Piece = pi.code
INNER JOIN Providers as prs ON prs.code = pr.provider
AND prs.Code = 'HAL';
+----------+
| Name     |
+----------+
| Sprocket |
| Screw    |
| Bolt     |
+----------+
3 rows in set (0.00 sec)

/* With EXISTS subquery */   
-- Interesting clause
SELECT Name FROM Pieces as pi
WHERE EXISTS (SELECT piece FROM Provides as pr,Providers as prs  where pr.Piece = pi.code AND 
prs.code = pr.provider AND prs.Code = 'HAL');

+----------+
| Name     |
+----------+
| Sprocket |
| Screw    |
| Bolt     |
+----------+
3 rows in set (0.00 sec)

--(OR)

MariaDB [mytestdb]> SELECT Name FROM Pieces 
WHERE EXISTS (   SELECT * FROM Provides     WHERE Provider = 'HAL'       AND Piece = Pieces.Code );
+----------+
| Name     |
+----------+
| Sprocket |
| Screw    |
| Bolt     |
+----------+
3 rows in set (0.00 sec)

-- 5.6
-- ---------------------------------------------
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- Intereting and important one.
-- For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price 
-- (note that there could be two providers who supply the same piece at the most expensive price).

MariaDB [mytestdb]> SELECT pi.name,prs.name,MAX(pr.price) as price FROM Pieces as pi INNER JOIN Provides as pr ON pr.Piece = pi.code INNER JOIN Providers as prs ON prs.code = pr.provider GROUP BY pi.code;
+----------+--------------------+-------+
| name     | name               | price |
+----------+--------------------+-------+
| Sprocket | Clarke Enterprises | 15.00 |
| Screw    | Clarke Enterprises | 20.00 |
| Nut      | Susan Calvin Corp. | 50.00 |
| Bolt     | Clarke Enterprises |  7.00 |
+----------+--------------------+-------+
4 rows in set (0.00 sec)

-- 5.7
-- Add an entry to the database to indicate that "Skellington Supplies" (code "TNBC") will provide sprockets (code "1") for 7 cents each.

MariaDB [mytestdb]> INSERT INTO provides(Piece,Provider,Price) VALUES(1,'TNBC',7.00);
Query OK, 1 row affected (0.09 sec)

MariaDB [mytestdb]> SELECT * FROM provides;
+------+-------+----------+-------+
| Code | Piece | Provider | Price |
+------+-------+----------+-------+
|    1 |     1 | HAL      | 10.00 |
|    2 |     1 | RBT      | 15.00 |
|    3 |     2 | HAL      | 20.00 |
|    4 |     2 | RBT      | 15.00 |
|    5 |     2 | TNBC     | 14.00 |
|    6 |     3 | RBT      | 50.00 |
|    7 |     3 | TNBC     | 45.00 |
|    8 |     4 | HAL      |  5.00 |
|    9 |     4 | RBT      |  7.00 |
|   10 |     1 | TNBC     |  7.00 |
+------+-------+----------+-------+
10 rows in set (0.00 sec)


-- 5.8
-- Increase all prices by one cent.

MariaDB [mytestdb]> SELECT * FROM provides;
+------+-------+----------+-------+
| Code | Piece | Provider | Price |
+------+-------+----------+-------+
|    1 |     1 | HAL      | 10.00 |
|    2 |     1 | RBT      | 15.00 |
|    3 |     2 | HAL      | 20.00 |
|    4 |     2 | RBT      | 15.00 |
|    5 |     2 | TNBC     | 14.00 |
|    6 |     3 | RBT      | 50.00 |
|    7 |     3 | TNBC     | 45.00 |
|    8 |     4 | HAL      |  5.00 |
|    9 |     4 | RBT      |  7.00 |
|   10 |     1 | TNBC     |  7.00 |
+------+-------+----------+-------+
10 rows in set (0.00 sec)

MariaDB [mytestdb]> UPDATE provides SET price = price + 1;
Query OK, 10 rows affected (0.08 sec)
Rows matched: 10  Changed: 10  Warnings: 0

MariaDB [mytestdb]> SELECT * FROM provides;
+------+-------+----------+-------+
| Code | Piece | Provider | Price |
+------+-------+----------+-------+
|    1 |     1 | HAL      | 11.00 |
|    2 |     1 | RBT      | 16.00 |
|    3 |     2 | HAL      | 21.00 |
|    4 |     2 | RBT      | 16.00 |
|    5 |     2 | TNBC     | 15.00 |
|    6 |     3 | RBT      | 51.00 |
|    7 |     3 | TNBC     | 46.00 |
|    8 |     4 | HAL      |  6.00 |
|    9 |     4 | RBT      |  8.00 |
|   10 |     1 | TNBC     |  8.00 |
+------+-------+----------+-------+
10 rows in set (0.00 sec)

-- 5.9
-- Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply bolts (code 4).

MariaDB [mytestdb]> SELECT * FROM provides;
+------+-------+----------+-------+
| Code | Piece | Provider | Price |
+------+-------+----------+-------+
|    1 |     1 | HAL      | 11.00 |
|    2 |     1 | RBT      | 16.00 |
|    3 |     2 | HAL      | 21.00 |
|    4 |     2 | RBT      | 16.00 |
|    5 |     2 | TNBC     | 15.00 |
|    6 |     3 | RBT      | 51.00 |
|    7 |     3 | TNBC     | 46.00 |
|    8 |     4 | HAL      |  6.00 |
|    9 |     4 | RBT      |  8.00 |
|   10 |     1 | TNBC     |  8.00 |
+------+-------+----------+-------+
10 rows in set (0.00 sec)

MariaDB [mytestdb]> DELETE FROM provides WHERE Provider = 'RBT' AND piece = 4;
Query OK, 1 row affected (0.09 sec)

MariaDB [mytestdb]> SELECT * FROM provides;
+------+-------+----------+-------+
| Code | Piece | Provider | Price |
+------+-------+----------+-------+
|    1 |     1 | HAL      | 11.00 |
|    2 |     1 | RBT      | 16.00 |
|    3 |     2 | HAL      | 21.00 |
|    4 |     2 | RBT      | 16.00 |
|    5 |     2 | TNBC     | 15.00 |
|    6 |     3 | RBT      | 51.00 |
|    7 |     3 | TNBC     | 46.00 |
|    8 |     4 | HAL      |  6.00 |
|   10 |     1 | TNBC     |  8.00 |
+------+-------+----------+-------+
9 rows in set (0.00 sec)

-- 5.10
-- Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply any pieces 
-- (the provider should still remain in the database).

MariaDB [mytestdb]> SELECT * FROM provides;
+------+-------+----------+-------+
| Code | Piece | Provider | Price |
+------+-------+----------+-------+
|    1 |     1 | HAL      | 11.00 |
|    2 |     1 | RBT      | 16.00 |
|    3 |     2 | HAL      | 21.00 |
|    4 |     2 | RBT      | 16.00 |
|    5 |     2 | TNBC     | 15.00 |
|    6 |     3 | RBT      | 51.00 |
|    7 |     3 | TNBC     | 46.00 |
|    8 |     4 | HAL      |  6.00 |
|   10 |     1 | TNBC     |  8.00 |
+------+-------+----------+-------+
9 rows in set (0.00 sec)

MariaDB [mytestdb]> DELETE FROM provides WHERE Provider = 'RBT' ;
Query OK, 3 rows affected (0.09 sec)

MariaDB [mytestdb]> SELECT * FROM provides;
+------+-------+----------+-------+
| Code | Piece | Provider | Price |
+------+-------+----------+-------+
|    1 |     1 | HAL      | 11.00 |
|    3 |     2 | HAL      | 21.00 |
|    5 |     2 | TNBC     | 15.00 |
|    7 |     3 | TNBC     | 46.00 |
|    8 |     4 | HAL      |  6.00 |
|   10 |     1 | TNBC     |  8.00 |
+------+-------+----------+-------+
6 rows in set (0.00 sec)