--- Nivell 1
-- Exercici 1
/*La teva tasca és dissenyar i crear una taula anomenada "credit_card" que emmagatzemi detalls crucials sobre les targetes de crèdit. 
La nova taula ha de ser capaç d'identificar de manera única cada targeta i establir una relació adequada amb les altres dues taules 
("transaction" i "company"). Després de crear la taula serà necessari que ingressis la informació del document denominat "dades_introduir_credit". 
Recorda mostrar el diagrama i realitzar una breu descripció d'aquest.*/
USE transactions;
DROP TABLE IF EXISTS credit_card;
CREATE TABLE IF NOT EXISTS credit_card (
	id VARCHAR(10) PRIMARY KEY, -- Identificador únic de la targeta
    iban VARCHAR(34) NOT NULL, -- El IBAN pot tenir fins 34 caracters segosn standard
    pan VARCHAR(20) NOT NULL, -- PAN (Primary Account Number, 16 dígits)
    pin CHAR(4) NOT NULL,  -- PIN (4 dígits)
    cvv CHAR(3) NOT NULL, -- CVV (3 dígits)
    expiring_date VARCHAR(10) NOT NULL -- Data de caducitat
    );
/* No puc carregar els registres de "datos_introducir_sprint3_credit". Si  la columna és VARCHAR(10) hauria d'acceptar la cadena tal cual;
com no ho fa reviso els errors/warnings o si la transacció va ser revertida. En un altre full SQL comprobo:
SELECT @@sql_mode;
i carrego temporalment:
SET @@sql_mode = 'NO_ENGINE_SUBSTITUTION'
per poder carregar els registres de les targetes de crèdit*/

ALTER TABLE transaction
ADD CONSTRAINT fk_transaction_credit_card_id
FOREIGN KEY (credit_card_id)
REFERENCES credit_card(id);
                                                                                                                                                                                                                                                                                                    
/*ALTER TABLE transaction
DROP FOREIGN KEY fk_transaction_credit_card_id;*/ -- ho he utilitzat per eliminar el constraint per poder eliminar la taula per fer el pdf

-- Exercici 2
/* El departament de Recursos Humans ha identificat un error en el número de compte associat a la targeta de crèdit amb ID CcU-2938. 
La informació que ha de mostrar-se per a aquest registre és: TR323456312213576817699999. Recorda mostrar que el canvi es va realitzar.*/
SELECT *
FROM credit_card
WHERE id ="CcU-2938";-- identifiquem el iban actual

UPDATE credit_card
SET iban = 'TR323456312213576817699999'
WHERE id = 'CcU-2938';-- actualitzem les dades

SELECT *
FROM credit_card
WHERE id ="CcU-2938";-- mostrem que s'ha fet el canvi


-- Exercici 3
/* En la taula "transaction" ingressa un nou usuari amb la següent informació:
Id	108B1D1D-5B23-A76C-55EF-C568E49A99DD
credit_card_id	CcU-9999
company_id	b-9999
user_id	9999
lat	829.999
longitude	-117.999
amount	111.11
declined	0 */

-- es necessari introduir primer la companyia en la taula company i la credit card en la per introduir una transacció
INSERT INTO company (
	id,
    company_name,
    phone,
    email,
    country,
    website
) VALUES (
	'b-9999',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
);
INSERT INTO credit_card (
	id,
    iban,
    pan,
    pin,
    cvv,
    expiring_date
) VALUES (
	'CcU-9999',
    'TR304050312213576927638662',
    '5101552687251312',
    '3852',
    '564',
    '01/09/28'
);
INSERT INTO transaction (
    id,
    credit_card_id,
    company_id,
    user_id,
    lat,
    longitude,
    amount,
    declined
) VALUES (
    '108B1D1D-5B23-A76C-55EF-C568E49A99DD',
    'CcU-9999',
    'b-9999',
    9999,
    829.999,
    -117.999,
    111.11,
    0
);

-- Exercici 4
/* Des de recursos humans et sol·liciten eliminar la columna "pan" de la taula credit_card. Recorda mostrar el canvi realitzat.*/
ALTER TABLE credit_card
DROP COLUMN pan;

DESCRIBE credit_card;

--  vaig a canviar el format de expiring_date
/* UPDATE necessita una condició (és una opció que impedeix fer UPDATE o DELETE sense un WHERE amb clau primària o índex) 
però em continua donant error 1175. Desactivo i activo de nou el safe Mode*/
SET SQL_SAFE_UPDATES = 0;
UPDATE credit_card
SET expiring_date = STR_TO_DATE(expiring_date, '%m/%d/%y');
SET SQL_SAFE_UPDATES = 1;  -- per tornar a activar-lo 

DESCRIBE credit_card; -- encara apareix com VARCHAR hem de modificar la taula amb expiring_date com DATE
ALTER TABLE credit_card
MODIFY expiring_date DATE NOT NULL;
DESCRIBE credit_card;
--- Nivell 2

-- Exercici 1
/* Elimina de la taula transaction el registre amb ID 000447FE-B650-4DCF-85DE-C7ED0EE1CAAD de la base de dades.*/
DELETE FROM transaction
WHERE id = '000447FE-B650-4DCF-85DE-C7ED0EE1CAAD';

-- Exercici 2
/* La secció de màrqueting desitja tenir accés a informació específica per a realitzar anàlisi i estratègies efectives. 
S'ha sol·licitat crear una vista que proporcioni detalls clau sobre les companyies i les seves transaccions. Serà necessària 
que creïs una vista anomenada VistaMarketing que contingui la següent informació: Nom de la companyia. Telèfon de contacte. 
País de residència. Mitjana de compra realitzat per cada companyia. Presenta la vista creada, ordenant les dades de major a menor mitjana de compra.*/

DROP VIEW IF EXISTS VistaMarketing; -- per esborrar si la ja haviem creat

CREATE VIEW VistaMarketing AS
SELECT c.company_name, c.phone, c.country, ROUND(AVG(t.amount),2) AS mitjanaCompra
FROM company c
LEFT JOIN  transaction t 
ON c.id = t.company_id
GROUP BY c.company_name, c.phone, c.country
ORDER BY mitjanaCompra DESC;

-- SHOW CREATE VIEW VistaMarketing;

-- SELECT * FROM VistaMarketing;

--  Exercici 3
/* Filtra la vista VistaMarketing per a mostrar només les companyies que tenen el seu país de residència en "Germany"*/
SELECT * 
FROM vistaMarketing
WHERE country='Germany';


--- Nivell 3
-- Exercici 1
/* La setmana vinent tindràs una nova reunió amb els gerents de màrqueting. Un company del teu equip va realitzar modificacions en la base de dades, 
però no recorda com les va realitzar. Et demana que l'ajudis a deixar els comandos executats per a obtenir el següent diagrama:*/

CREATE TABLE IF NOT EXISTS user (
	id CHAR(10) PRIMARY KEY,
	name VARCHAR(100),
	surname VARCHAR(100),
	phone VARCHAR(150),
	email VARCHAR(150),
	birth_date VARCHAR(100),
	country VARCHAR(150),
	city VARCHAR(150),
	postal_code VARCHAR(100),
	address VARCHAR(255)    
);


SELECT t.user_id
FROM transaction t
LEFT JOIN user u ON t.user_id = u.id
WHERE u.id IS NULL AND t.user_id IS NOT NULL;

SET SQL_SAFE_UPDATES = 0;
DELETE FROM transaction
WHERE user_id=9999;
SET SQL_SAFE_UPDATES = 1;

-- comprovo que no queda cap registre orfe ambas de crear la clau foranea
SELECT *
FROM transaction t
LEFT JOIN user u 
ON t.user_id = u.id
WHERE u.id IS NULL AND t.user_id IS NOT NULL;

-- Canviem user.id a INT però hem d´eliminar la clau primària per fer-ho
ALTER TABLE user DROP PRIMARY KEY;

ALTER TABLE user 
MODIFY id INT AUTO_INCREMENT PRIMARY KEY;

-- crear clau forànea
ALTER TABLE transaction
ADD CONSTRAINT fk_transaction_user_id
FOREIGN KEY (user_id)
REFERENCES user(id);

-- afegir la columna fecha_actual DATE a la taula credit_card
ALTER TABLE credit_card
ADD COLUMN fecha_actual DATE;

-- Exercici 2
/*L'empresa també us demana crear una vista anomenada "InformeTecnico" que contingui la següent informació:
o	ID de la transacció
o	Nom de l'usuari/ària
o	Cognom de l'usuari/ària
o	IBAN de la targeta de crèdit usada.
o	Nom de la companyia de la transacció realitzada.
o	Assegureu-vos d'incloure informació rellevant de les taules que coneixereu i utilitzeu àlies per canviar de nom columnes segons calgui.
Mostra els resultats de la vista, ordena els resultats de forma descendent en funció de la variable ID de transacció.*/

CREATE VIEW InformeTecnico AS
SELECT t.id, u.name, u.surname, cc.iban, c.company_name
FROM company c
LEFT JOIN  transaction t 
ON c.id = t.company_id
LEFT JOIN user u
ON t.user_id = u.id
LEFT JOIN credit_card cc 
ON t.credit_card_id = cc.id
ORDER BY t.id DESC;

SELECT * FROM InformeTecnico;
