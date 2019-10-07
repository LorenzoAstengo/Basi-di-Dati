SET SEARCH_PATH TO "bd1";

--1. Interrogazioni semplici
--Porzione B
--1. Si decide di selezionare tutte le prenotazioni con penale nulla

SELECT targa, data_ritiro
    FROM prenotazione
    WHERE prenotazione.penale = '0';

--2. Selezionare tutti gli utenti che non hanno un'annullamento di prenotazione

SELECT DISTINCT email
    FROM prenotazione
    WHERE data_annullamento IS NULL;

--3. Determinare tutte le prenotazioni effettuate da un utente con mail che ha la d come terza lettera

SELECT targa, email
    FROM prenotazione
    WHERE email LIKE '__d%';

--Porzione comune
--1. Si seleziona la targa delle vetture che non hanno parcheggiato nel parcheggio 'gGLqdcGKHUNvAHrNtuzJ' (con differenza)

SELECT targa
    FROM vettura EXCEPT
SELECT targa
    FROM vettura
    WHERE nome_parcheggio = 'gGLqdcGKHUNvAHrNtuzJ';

--2. Per ogni vettura di categoria CityCar vogliamo visualizzare la sua collocazione nel parcheggio e il modello a cui appartiene (con outer join)

/*SELECT vettura.targa, parcheggio.nome, parcheggio.latitudine, parcheggio.longitudine, modello.nomemodello
    FROM categoria
        NATURAL JOIN vettura
        NATURAL LEFT OUTER JOIN modello
    WHERE categoria.tipo = 'citycar';*/

--3. Si selezionano tutti gli abbonamenti effettuati a partire dal 1 giugno(compreso)

SELECT *
    FROM abbonamento
    WHERE data_inizio > '31/05/2019';


--2. Interrogazioni di manipolazione
--1. Si decide di cancellare tutte le prenotazioni tranne quelle avvenute nel mese di aprile (cancellazione)

DELETE
    FROM prenotazione
    WHERE data_consegna < '31/03/2019' AND data_consegna > '30/04/2019';

--2. Si inserisce una nuova prenotazione (inserimento)

/*INSERT INTO prenotazione(data_ritiro, data_consegna, targa, data_ritiro_e, data_consegna_e, penale, km_percorsi,
                         data_annullamento,
                         email)
    VALUES ('11/5/2019', '20:38', '15/5/2020', '1:57', 'MT891hx', '11/5/2019', '20:38', '15/5/2020', '11:19', '2627',
            '3177', '16/7/2019', '6:0', 'qTTyLO@gmail.com');*/

--3. Aumentare la penale del 10% per le prenotazioni avvenute dopo il '31/07/2019' (modifica)

UPDATE prenotazione
SET penale=penale * 1.1
    WHERE data_ritiro_e > '31/07/2019';

--Porzione comune
--1. Inserimento di un nuovo parcheggio (inserimento)

INSERT INTO parcheggio(nome, longitudine, latitudine, zona, indirizzo, num_posti)
    VALUES ('afXhVQflkulMVwnzpWSY', 'JBit8SSyznyhatsEH2JJ', 'xdrokMkoQUnkdbhtxV0A', 'EyVvUg', 'h 23/7', '49693');

--2. Cancellare i clienti che non hanno effettuato abbonamenti dopo il 30/04/2019

DELETE
    FROM utente
    WHERE email NOT IN (SELECT email FROM abbonamento WHERE data_inizio > '30/04/2019');

--3. Modificare la numerosità del parcheggio 'afXhVQflkWlMVwnzpWSY in '50000'

/*UPDATE parcheggio
SET num_posti='500';*/


--3. Interrogazioni di analisi
--1. Si decide di selezionare tutte le targhe (con i relativi parcheggi in cui sono state) che hanno più di due prenotazioni (raggruppamento)

SELECT prenotazione.targa, vettura.nome_parcheggio, COUNT(*)
    FROM prenotazione
        JOIN vettura ON prenotazione.targa = vettura.targa
    WHERE data_annullamento IS NULL
    GROUP BY prenotazione.targa, vettura.nome_parcheggio
    HAVING COUNT(*) > 2
    ORDER BY prenotazione.targa;

--2. Determinare le vetture di tutte le prenotazioni che hanno lo stesso nome del modello della vettura con targa 'cC708Sv' (sottointerrogazione)

SELECT targa
    FROM vettura
    WHERE nome_modello = (SELECT nome_modello FROM vettura WHERE targa = 'cC708Sv');

--3. Si selezionano tutti gli annulamenti effettuati da ogni utenti (raggruppamento)

SELECT email, data_annullamento
    FROM prenotazione
    GROUP BY email;
--Porzione comune
--1. Determinare il numero di abbonamenti e costo minimo e massimo (funzioni di gruppo)

SELECT count(*) AS numabbonamenti, MIN(costo), max(costo)
    FROM abbonamento;

--2. Determinare gli utenti che hanno prenotato tutte le vetture con km percorsi '3178' (divisione)

SELECT email
    FROM prenotazione
        NATURAL JOIN utente
    WHERE km_percorsi = '3178'
    GROUP BY email
    HAVING count(DISTINCT targa) = (SELECT count(DISTINCT targa) FROM vettura WHERE chilometraggio = '3178');

--3. Si decide di contare per ogni utente quante riduzioni ha ricevuto (funzioni di gruppo)

SELECT count(*) AS numrid
    FROM rid
    GROUP BY email;