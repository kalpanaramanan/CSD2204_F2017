-- 1.10 Select all the data from the products, including all the data for each product's manufacturer.

MariaDB [mytestdb]> SELECT * FROM products AS p INNER JOIN manufacturers AS m ON m.code = p.manufacturer;
+------+-----------------+-------+--------------+------+-----------------+
| Code | Name            | Price | Manufacturer | CODE | NAME            |
+------+-----------------+-------+--------------+------+-----------------+
|    1 | Hard drive      |   240 |            5 |    5 | Fujitsu         |
|    2 | Memory          |   120 |            6 |    6 | Winchester      |
|    3 | ZIP drive       |   150 |            4 |    4 | Iomega          |
|    4 | Floppy disk     |     5 |            6 |    6 | Winchester      |
|    5 | Monitor         |   240 |            1 |    1 | Sony            |
|    6 | DVD drive       |   180 |            2 |    2 | Creative Labs   |
|    7 | CD drive        |    90 |            2 |    2 | Creative Labs   |
|    8 | Printer         |   270 |            3 |    3 | Hewlett-Packard |
|    9 | Toner cartridge |    66 |            3 |    3 | Hewlett-Packard |
|   10 | DVD burner      |   180 |            2 |    2 | Creative Labs   |
+------+-----------------+-------+--------------+------+-----------------+
10 rows in set (0.00 sec)

-- 1.11 Select the product name, price, and manufacturer name of all the products.
MariaDB [mytestdb]> SELECT p.name AS Product_Name,p.price AS Price,m.name AS Manufacturer FROM products AS p INNER JOIN manufacturers AS m ON m.code = p.manufacturer;
+-----------------+-------+-----------------+
| Product_Name    | Price | Manufacturer    |
+-----------------+-------+-----------------+
| Hard drive      |   240 | Fujitsu         |
| Memory          |   120 | Winchester      |
| ZIP drive       |   150 | Iomega          |
| Floppy disk     |     5 | Winchester      |
| Monitor         |   240 | Sony            |
| DVD drive       |   180 | Creative Labs   |
| CD drive        |    90 | Creative Labs   |
| Printer         |   270 | Hewlett-Packard |
| Toner cartridge |    66 | Hewlett-Packard |
| DVD burner      |   180 | Creative Labs   |
+-----------------+-------+-----------------+
10 rows in set (0.00 sec)
-- 1.12 Select the average price of each manufacturer's products, showing only the manufacturer's code.
MariaDB [mytestdb]> SELECT AVG(price),Manufacturer FROM products GROUP BY Manufacturer;
+------------+--------------+
| AVG(price) | Manufacturer |
+------------+--------------+
|    47.0000 |         NULL |
|   240.0000 |            1 |
|   150.0000 |            2 |
|   168.0000 |            3 |
|   150.0000 |            4 |
|   240.0000 |            5 |
|    62.5000 |            6 |
+------------+--------------+
7 rows in set (0.00 sec)

-- 1.13 Select the average price of each manufacturer's products, showing the manufacturer's name.
MariaDB [mytestdb]> SELECT AVG(price),m.name FROM products AS p,Manufacturers AS m WHERE m.code = p.manufacturer GROUP BY Manufacturer;
+------------+-----------------+
| AVG(price) | name            |
+------------+-----------------+
|   240.0000 | Sony            |
|   150.0000 | Creative Labs   |
|   168.0000 | Hewlett-Packard |
|   150.0000 | Iomega          |
|   240.0000 | Fujitsu         |
|    62.5000 | Winchester      |
+------------+-----------------+
6 rows in set (0.05 sec)
-- 1.14 Select the names of manufacturer whose products have an average price larger than or equal to $150.
MariaDB [mytestdb]> SELECT m.name AS Manufacturer FROM products AS p,Manufacturers AS m where m.code = p.manufacturer GROUP BY Manufacturer HAVING AVG(p.price)>= 150;
+-----------------+
| Manufacturer    |
+-----------------+
| Sony            |
| Creative Labs   |
| Hewlett-Packard |
| Iomega          |
| Fujitsu         |
+-----------------+
5 rows in set, 1 warning (0.00 sec)
-- 1.15 Select the name and price of the cheapest product.
MariaDB [mytestdb]> SELECT name,price FROM products ORDER BY price ASC LIMIT 1 ;
+-------------+-------+
| name        | price |
+-------------+-------+
| Floppy disk |     5 |
+-------------+-------+
1 row in set (0.00 sec)
-- 1.16 Select the name of each manufacturer along with the name and price of its most expensive product.
