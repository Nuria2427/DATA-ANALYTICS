--- Nivell 1
/*Descàrrega els arxius CSV, estudia'ls i dissenya una base de dades amb un esquema d'estrella que contingui, 
almenys 4 taules de les quals puguis realitzar les següents consultes:*/

-- DROP DATABASE skycaster; -- si m'equivoco
CREATE DATABASE Skycaster
CHARACTER SET utf8mb4
COLLATE utf8mb4_general_ci;

USE Skycaster;

CREATE TABLE IF NOT EXISTS company (
	id_company VARCHAR(100) PRIMARY KEY,
	company_name VARCHAR(255) NOT NULL,
	phone VARCHAR(15),
	email VARCHAR(100),
	country VARCHAR(100),
	website VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS credit_card (
	id_card VARCHAR(100) PRIMARY KEY, -- Identificador únic de la targeta
    user_id VARCHAR (100) NOT NULL, -- el identificador d'usuari
    iban VARCHAR(34) NOT NULL, -- El IBAN pot tenir fins 34 caracters segosn standard
    pan VARCHAR(20) NOT NULL, -- PAN (Primary Account Number, 16 dígits)
    pin CHAR(4) NOT NULL,  -- PIN (4 dígits)
    cvv CHAR(3) NOT NULL, -- CVV (3 dígits)
    track1 VARCHAR (255), -- texte
	track2 VARCHAR (255), --
	expiring_date VARCHAR(20)  -- Data de caducitat
);
    
CREATE TABLE IF NOT EXISTS product (
	id_product VARCHAR(100) PRIMARY KEY,
	product_name VARCHAR(255) NOT NULL,
    price VARCHAR(50) NOT NULL,
	colour VARCHAR(100),
	weight INT,
	warehouse_id VARCHAR(15) NOT NULL
);

CREATE TABLE IF NOT EXISTS users (
	id_user VARCHAR(100) PRIMARY KEY,
	name VARCHAR(100),
	surname VARCHAR(100),
	phone VARCHAR(20),
	email VARCHAR(150),
	birth_date VARCHAR(100),
	country VARCHAR(150),
	city VARCHAR(150),
	postal_code VARCHAR(20),
	address VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS transactions (
	id_transactions VARCHAR(255) PRIMARY KEY,
	card_id VARCHAR(100) NOT NULL,
	business_id VARCHAR(100) NOT NULL,
	timestamp DATETIME NOT NULL,
	amount DECIMAL(10, 2) NOT NULL,
    declined boolean NOT NULL DEFAULT 0, -- 0 = acceptada, 1 = denegada
    product_id VARCHAR(100) NOT NULL,
    user_id VARCHAR(100) NOT NULL,
    lat DECIMAL(9,6), 
    longitude DECIMAL(9,6),
	FOREIGN KEY (card_id) REFERENCES credit_card(id_card),
	FOREIGN KEY (business_id) REFERENCES company(id_company),
    FOREIGN KEY (user_id) REFERENCES users(id_user)
);

-- Ara carreguem les taules:
SHOW GLOBAL VARIABLES LIKE 'local_infile';

SHOW VARIABLES LIKE 'secure_file_priv';

-- SET GLOBAL local_infile = 1;-- si volem posar-ho en ON (no recomanat)
-- SET GLOBAL local_infile = 0; -- per tornar-ho a OFF
-- SHOW GLOBAL VARIABLES LIKE 'local_infile'; -- comprobació

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Skycaster\\companies.csv'
INTO TABLE company
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Skycaster\\credit_cards.csv'
INTO TABLE credit_card
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id_card, user_id, iban, pan, pin, cvv, track1, track2, @expiring_date)
SET expiring_date = STR_TO_DATE(@expiring_date, '%m/%d/%y'); -- y25 Y2025

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Skycaster\\products.csv'
INTO TABLE product
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Skycaster\\american_users.csv'
INTO TABLE users
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id_user, name, surname, phone, email, @birth_date, country, city, postal_code, address)
SET birth_date = STR_TO_DATE(@birth_date, '%b %d, %Y');

-- SET birth_date = STR_TO_DATE(@birth_date, '%m/%d/%Y'); -- y25 Y2025-- no funciona

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Skycaster\\european_users.csv'
INTO TABLE users
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id_user, name, surname, phone, email, @birth_date, country, city, postal_code, address)
SET birth_date = STR_TO_DATE(@birth_date, '%b %d, %Y');

ALTER TABLE users
ADD COLUMN continent_id VARCHAR(50);

SELECT @@sql_mode; 
/* per evitar l'errorCode 1175:You are using safe update mode and you tried to update a table whiout a WHERE
 that uses a KEY column.  To disable safe mode, toggle the option in Preferences */
SET SQL_SAFE_UPDATES=0;

UPDATE users
SET continent_id = CASE
    WHEN country IN ('United States', 'Canada') THEN 'america'
    ELSE 'europe'
END;
SET SQL_SAFE_UPDATES=1;-- tornar a la situació anterior

-- comprovo que no queda cap registre orfe ambas de crear la clau foranea
SELECT *
FROM transactions t
LEFT JOIN credit_card c
ON t.card_id = c.id_card
WHERE c.id_card IS NULL AND t.card_id IS NOT NULL;

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Skycaster\\transactions.csv'
INTO TABLE transactions
FIELDS TERMINATED BY ';' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(id_transactions, card_id, business_id, timestamp, amount, declined, product_id, user_id, lat, longitude);

--- 
-- Exercici 1
/* Realitza una subconsulta que mostri tots els usuaris amb més de 80 transaccions utilitzant almenys 2 taules.*/

SELECT u.id_user,
       (
         SELECT COUNT(t.id_transactions)
         FROM transactions t
         WHERE t.user_id = u.id_user
       ) AS num_transactions
FROM users u
WHERE (
         SELECT COUNT(t.id_transactions)
         FROM transactions t
         WHERE t.user_id = u.id_user
      ) > 80;
-- comprobació fàcil
SELECT user_id, count(id_transactions) AS num_transactions
FROM transactions
GROUP BY user_id
HAVING COUNT(id_transactions) > 80;
      
-- Exercici 2
/* Mostra la mitjana d'amount per IBAN de les targetes de crèdit a la companyia Donec Ltd, utilitza almenys 2 taules.*/
SELECT c.id_company, cc.iban, ROUND(AVG(t.amount),2)
FROM transactions t
LEFT JOIN credit_card cc -- probablement no sigui consistent amb altres queries
ON t.card_id = cc.id_card
LEFT JOIN company c
ON t.business_id = c.id_company
WHERE c.company_name = 'Donec Ltd'
GROUP BY c.id_company, cc.iban;

-- si afegim la targeta de credit tenim el mateix resultat
SELECT c.id_company, cc.iban, cc.id_card, ROUND(AVG(t.amount),2)
FROM transactions t
LEFT JOIN credit_card cc
ON t.card_id = cc.id_card
LEFT JOIN company c
ON t.business_id = c.id_company
WHERE c.company_name = 'Donec Ltd'
GROUP BY c.id_company, cc.iban, cc.id_card;

--- Nivell 2
/* Crea una nova taula que reflecteixi l'estat de les targetes de crèdit basat en si les últimes tres transaccions van ser declinades i genera la següent consulta:*/

CREATE TABLE estat_targetes AS
SELECT ultimes_3transaccions.card_id,
    CASE 
        WHEN SUM(CASE WHEN ultimes_3transaccions.declined = 1 THEN 1 ELSE 0 END) = 3 THEN 'Inactiva'
        ELSE 'Activa'
    END AS estat_targeta
FROM (
    SELECT 
        t.card_id,
        t.declined,
        t.timestamp,
        ROW_NUMBER() OVER (PARTITION BY t.card_id ORDER BY timestamp DESC) AS rn
    FROM transactions t
) ultimes_3transaccions
WHERE rn <= 3
GROUP BY ultimes_3transaccions.card_id;



-- Exercici 1
/* Quantes targetes estan actives?. */

SELECT COUNT(*) 
FROM skycaster.estat_targetes
WHERE estat_targeta='Activa';


--- Nivell 3
/* Crea una taula amb la qual puguem unir les dades del nou arxiu products.csv amb la base de dades creada, tenint en compte que des de transaction
 tens product_ids. Genera la següent consulta:*/
/* La taula transactions té un camp product_ids que conté més d’un id de producte per transacció 
(per exemple: 00043A49-2949-494B-A5DD-A5BAE3BB19DD te com procuct_id: “16,26,97,87”) i volem unir-ho amb products (del CSV) 
per obtenir informació de cada producte. Aquest tipus de situació no permet un JOIN directe, perquè product_ids no és un valor normalitzat, 
sinó una cadena separada per comes. Haurem de crear una taula temporal de relació normalitzada (transaction_products) */
CREATE TABLE transaction_products (
    id_transactions VARCHAR(255),
    id_product VARCHAR(100),
    PRIMARY KEY (id_transactions, id_product),
    FOREIGN KEY (id_transactions) REFERENCES transactions(id_transactions),
    FOREIGN KEY (id_product) REFERENCES product(id_product)
);

INSERT INTO transaction_products (id_transactions, id_product)
SELECT
    t.id_transactions,
    j.product_id
FROM transactions t
JOIN JSON_TABLE(
    CONCAT('[', t.product_id, ']'),
    "$[*]" COLUMNS (product_id VARCHAR(100) PATH "$")
) AS j;

-- comprovem que les dades son compatibles:
SHOW COLUMNS FROM transactions;
SHOW COLUMNS FROM product;


-- Exercici 1
/* Necessitem conèixer el nombre de vegades que s'ha venut cada producte.*/
-- si volem el nom haurem d´utilitzar també la taula product
SELECT tp.id_product, p.product_name, count(tp.id_transactions) AS nombre_productes_venuts
FROM transaction_products tp
JOIN product p
ON tp.id_product = p.id_product
GROUP BY tp.id_product, p.product_name
ORDER BY nombre_productes_venuts DESC;

-- si no necessitem el nom del producte:
SELECT tp.id_product, count(tp.id_transactions) AS nombre_productes_venuts
FROM transaction_products tp
GROUP BY tp.id_product
ORDER BY nombre_productes_venuts DESC;
