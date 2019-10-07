SET SEARCH_PATH TO bd1;

-- UTENTE
INSERT INTO utente (email, bonus, ammontare)
    VALUES ('marco123@gmail.com', TRUE, 0.00);
INSERT INTO utente (email, bonus, ammontare)
    VALUES ('alice123@gmail.com', FALSE, 60.00);
INSERT INTO utente (email, bonus, ammontare)
    VALUES ('sara123@gmail.com', FALSE, 0.00);
INSERT INTO utente (email, bonus, ammontare)
    VALUES ('abc@gmail.com', FALSE, 0.00);
INSERT INTO utente (email, bonus, ammontare)
    VALUES ('luca_rossi@gmail.com', TRUE, 45.00);
INSERT INTO utente (email, bonus, ammontare)
    VALUES ('qwe@gmail.com', FALSE, 145.00);
INSERT INTO utente (email, bonus, ammontare)
    VALUES ('ttt2@gmail.com', FALSE, 0.00);
INSERT INTO utente (email, bonus, ammontare)
    VALUES ('giovanni93@gmail.com', FALSE, 30.00);

-- PRIVATO
INSERT INTO privato (codice_fiscale, indirizzo_residenza, professione, genere, email)
    VALUES ('PLTKXN68A48F476J', 'via torino 10, GE', 'studente', 'f', 'alice123@gmail.com');
INSERT INTO privato (codice_fiscale, indirizzo_residenza, professione, genere, email)
    VALUES ('BRKAUK31P67F160X', 'corso saracco 47, GE', 'impiegato', 'm', 'marco123@gmail.com');
INSERT INTO privato (codice_fiscale, indirizzo_residenza, professione, genere, email)
    VALUES ('SRTRNH55P21F080Q', 'via tommasini 11, GE', 'tecnico', 'm', 'giovanni93@gmail.com');
INSERT INTO privato (codice_fiscale, indirizzo_residenza, professione, genere, email)
    VALUES ('NABRMD43A11F921T', 'via san paolo 33, GE', 'impiegato', 'm', 'luca_rossi@gmail.com');
INSERT INTO privato (codice_fiscale, indirizzo_residenza, professione, genere, email)
    VALUES ('PBHFTO76W83M220J', 'via borgo nuovo 19, GE', 'dottore', 'f', 'sara123@gmail.com');

-- AZIENDA
INSERT INTO azienda (partita_iva, indirizzo_sede_legale, ragione_sociale, nome_referente, cognome_referente,
                     telefono_referente, indirizzo_sede_op, data_nascita_rappr, luogo_nascita_rappr, cognome_rappr,
                     nome_rappr, settore_attivita, telefono, email)
    VALUES ('18530718725', 'via verdi 12, GE', 'a', 'Luca', 'Pestarino', '3474432867', 'corso italia 11, GE',
            '1993-02-14', 'Brescia, MI', 'Barbieri', 'Filippo', 'Intermediazione', '3434268530', 'abc@gmail.com');
INSERT INTO azienda (partita_iva, indirizzo_sede_legale, ragione_sociale, nome_referente, cognome_referente,
                     telefono_referente, indirizzo_sede_op, data_nascita_rappr, luogo_nascita_rappr, cognome_rappr,
                     nome_rappr, settore_attivita, telefono, email)
    VALUES ('24136243257', 'via rossi 43, GE', 'b', 'Amedeo', 'Simoni', '3453086284', NULL, '1974-04-05', 'Voltri, GE',
            'Grandi', 'Francesco', 'Intermediazione', '3406005944', 'qwe@gmail.com');
INSERT INTO azienda (partita_iva, indirizzo_sede_legale, ragione_sociale, nome_referente, cognome_referente,
                     telefono_referente, indirizzo_sede_op, data_nascita_rappr, luogo_nascita_rappr, cognome_rappr,
                     nome_rappr, settore_attivita, telefono, email)
    VALUES ('82031669341', 'via nerone 10, GE', 'a', 'Tom', 'Scarpa', '3430089211', NULL, '1988-02-01', 'Genova',
            'Gualco', 'Andrea', 'Commercio', '3951738638', 'ttt2@gmail.com');

-- RID
INSERT INTO rid (coordinate, email)
    VALUES ('0000157841Z', 'sara123@gmail.com');
INSERT INTO rid (coordinate, email)
    VALUES ('0000139721L', 'ttt2@gmail.com');

-- CARTA DI CREDITO
INSERT INTO carta_di_credito (numero, circuito, data_scadenza, email)
    VALUES ('4556783724286910', 'Mastercard', '2025-01-21', 'marco123@gmail.com');
INSERT INTO carta_di_credito (numero, circuito, data_scadenza, email)
    VALUES ('4485967408516132', 'Visa', '2022-03-09', 'abc@gmail.com');
INSERT INTO carta_di_credito (numero, circuito, data_scadenza, email)
    VALUES ('4400961403416111', 'Visa', '2023-04-13', 'giovanni93@gmail.com');
INSERT INTO carta_di_credito (numero, circuito, data_scadenza, email)
    VALUES ('4226702724255550', 'Mastercard', '2021-02-09', 'luca_rossi@gmail.com');

-- PARCHEGGIO
INSERT INTO parcheggio (nome, longitudine, latitudine, zona, indirizzo, num_posti)
    VALUES ('Villa borghese', '86', '21', 'sestri', 'via rossi 13', 10);
INSERT INTO parcheggio (nome, longitudine, latitudine, zona, indirizzo, num_posti)
    VALUES ('Caboto', '86', '22', 'brignole', 'via caboto 44', 24);
INSERT INTO parcheggio (nome, longitudine, latitudine, zona, indirizzo, num_posti)
    VALUES ('Piazza rossa', '87', '21', 'albaro', 'piazza rossa 15', 36);
INSERT INTO parcheggio (nome, longitudine, latitudine, zona, indirizzo, num_posti)
    VALUES ('Piazza cavour', '85', '21', 'sturla', 'piazza cavour 33', 30);
INSERT INTO parcheggio (nome, longitudine, latitudine, zona, indirizzo, num_posti)
    VALUES ('Pellico', '87', '20', 'principe', 'via pellico 10', 20);

-- CATEGORIA
INSERT INTO categoria (tipo)
    VALUES ('City car');
INSERT INTO categoria (tipo)
    VALUES ('Comfort');
INSERT INTO categoria (tipo)
    VALUES ('Elettrico');
INSERT INTO categoria (tipo)
    VALUES ('Cargo');
INSERT INTO categoria (tipo)
    VALUES ('Media');

-- OSPITA
INSERT INTO ospita (nome, tipo)
    VALUES ('Elettrico', 'Villa borghese');
INSERT INTO ospita (nome, tipo)
    VALUES ('City car', 'Piazza cavour');
INSERT INTO ospita (nome, tipo)
    VALUES ('Comfort', 'Piazza cavour');
INSERT INTO ospita (nome, tipo)
    VALUES ('City car', 'Pellico');
INSERT INTO ospita (nome, tipo)
    VALUES ('Comfort', 'Piazza rossa');
INSERT INTO ospita (nome, tipo)
    VALUES ('Media', 'Piazza rossa');
INSERT INTO ospita (nome, tipo)
    VALUES ('City car', 'Piazza rossa');
INSERT INTO ospita (nome, tipo)
    VALUES ('Elettrico', 'Piazza rossa');
INSERT INTO ospita (nome, tipo)
    VALUES ('Cargo', 'Caboto');
INSERT INTO ospita (nome, tipo)
    VALUES ('Media', 'Caboto');

-- MODELLO
INSERT INTO modello (nome_modello, produttore, numero_posti, numero_porte, velocita_massima, consumo_medio, airbag,
                     servosterzo, aria_condizionata, altezza, lunghezza, larghezza, bagagliaio, cilindrata, kw, tipo)
    VALUES ('Panda 1.3 Multijet', 'Fiat', 4, 5, 160, 4.30, TRUE, TRUE, TRUE, 3540, 1580, 1540, 775, 1248, 51,
            'City car');
INSERT INTO modello (nome_modello, produttore, numero_posti, numero_porte, velocita_massima, consumo_medio, airbag,
                     servosterzo, aria_condizionata, altezza, lunghezza, larghezza, bagagliaio, cilindrata, kw, tipo)
    VALUES ('Leaf', 'Nissan', 5, 5, 144, 4.30, TRUE, TRUE, TRUE, 1550, 4445, 1770, 1110, NULL, 80, 'Elettrico');
INSERT INTO modello (nome_modello, produttore, numero_posti, numero_porte, velocita_massima, consumo_medio, airbag,
                     servosterzo, aria_condizionata, altezza, lunghezza, larghezza, bagagliaio, cilindrata, kw, tipo)
    VALUES ('Up', 'Volkswagen', 4, 5, 130, 3.60, TRUE, TRUE, TRUE, 1504, 3600, 1645, 923, NULL, 60, 'Elettrico');
INSERT INTO modello (nome_modello, produttore, numero_posti, numero_porte, velocita_massima, consumo_medio, airbag,
                     servosterzo, aria_condizionata, altezza, lunghezza, larghezza, bagagliaio, cilindrata, kw, tipo)
    VALUES ('Ducato 35', 'Fiat', 3, 3, 150, 4.20, TRUE, TRUE, TRUE, 2254, 4963, 2050, 1640, 2200, 83, 'Cargo');
INSERT INTO modello (nome_modello, produttore, numero_posti, numero_porte, velocita_massima, consumo_medio, airbag,
                     servosterzo, aria_condizionata, altezza, lunghezza, larghezza, bagagliaio, cilindrata, kw, tipo)
    VALUES ('GOLF SPORTVAN', 'Volkswagen', 5, 5, 200, 4.60, TRUE, TRUE, TRUE, 1580, 4340, 1810, 1202, 1395, 125,
            'Comfort');

-- TARIFFA
INSERT INTO tariffa (nome_modello, produttore, supplemento_giornaliero, giornaliera, settimanale, oraria, chilometrica)
    VALUES ('Panda 1.3 Multijet', 'Fiat', 41.00, 50.00, 290.00, 3.25, 0.25);
INSERT INTO tariffa (nome_modello, produttore, supplemento_giornaliero, giornaliera, settimanale, oraria, chilometrica)
    VALUES ('Leaf', 'Nissan', 36.00, 50.00, 270.00, 3.00, 0.00);
INSERT INTO tariffa (nome_modello, produttore, supplemento_giornaliero, giornaliera, settimanale, oraria, chilometrica)
    VALUES ('Up', 'Volkswagen', 36.00, 47.00, 250.00, 2.75, 0.00);
INSERT INTO tariffa (nome_modello, produttore, supplemento_giornaliero, giornaliera, settimanale, oraria, chilometrica)
    VALUES ('Ducato 35', 'Fiat', 56.00, 80.00, 390.00, 3.90, 0.50);
INSERT INTO tariffa (nome_modello, produttore, supplemento_giornaliero, giornaliera, settimanale, oraria, chilometrica)
    VALUES ('GOLF SPORTVAN', 'Volkswagen', 41.00, 55.00, 390.00, 3.70, 0.50);

-- VETTURA
INSERT INTO vettura (targa, nome, colore, chilometraggio, seggiolini, trasporto_animali, nome_parcheggio, nome_modello,
                     produttore)
    VALUES ('3PPJ765', 'Alice', 'nero', 6486, 1, TRUE, 'Piazza cavour', 'Panda 1.3 Multijet', 'Fiat');
INSERT INTO vettura (targa, nome, colore, chilometraggio, seggiolini, trasporto_animali, nome_parcheggio, nome_modello,
                     produttore)
    VALUES ('7Z29X15', 'Lara', 'rosso', 8724, 0, TRUE, 'Villa borghese', 'Leaf', 'Nissan');
INSERT INTO vettura (targa, nome, colore, chilometraggio, seggiolini, trasporto_animali, nome_parcheggio, nome_modello,
                     produttore)
    VALUES ('7QFRF8R', 'Giulia', 'bianco', 20941, 0, FALSE, 'Piazza cavour', 'Panda 1.3 Multijet', 'Fiat');
INSERT INTO vettura (targa, nome, colore, chilometraggio, seggiolini, trasporto_animali, nome_parcheggio, nome_modello,
                     produttore)
    VALUES ('I4S30U7', 'Naomi', 'verde', 50169, 0, FALSE, 'Villa borghese', 'Leaf', 'Nissan');
INSERT INTO vettura (targa, nome, colore, chilometraggio, seggiolini, trasporto_animali, nome_parcheggio, nome_modello,
                     produttore)
    VALUES ('5ZEFX4X', 'Claire', 'blu', 65628, 0, FALSE, 'Pellico', 'Panda 1.3 Multijet', 'Fiat');
INSERT INTO vettura (targa, nome, colore, chilometraggio, seggiolini, trasporto_animali, nome_parcheggio, nome_modello,
                     produttore)
    VALUES ('E2F34I5', 'Monica', 'beige', 33032, 0, FALSE, 'Villa borghese', 'Up', 'Volkswagen');
INSERT INTO vettura (targa, nome, colore, chilometraggio, seggiolini, trasporto_animali, nome_parcheggio, nome_modello,
                     produttore)
    VALUES ('3PMSG8T', 'Marta', 'nero', 11543, 0, FALSE, 'Piazza rossa', 'GOLF SPORTVAN', 'Volkswagen');
INSERT INTO vettura (targa, nome, colore, chilometraggio, seggiolini, trasporto_animali, nome_parcheggio, nome_modello,
                     produttore)
    VALUES ('B2J32H5', 'Jennifer', 'giallo', 22511, 0, FALSE, 'Caboto', 'Ducato 35', 'Fiat');

-- ABBONAMENTO
INSERT INTO abbonamento (data_inizio, data_fine, num_smartcard, email, costo, tipo, carta_carburante)
    VALUES ('2019-06-10', '2019-07-10', 987654321, 'alice123@gmail.com', 20.00, 'Mensile', 1234);
INSERT INTO abbonamento (data_inizio, data_fine, num_smartcard, email, costo, tipo, carta_carburante)
    VALUES ('2019-07-11', '2019-08-11', 987654321, 'alice123@gmail.com', 20.00, 'Mensile', 1234);
INSERT INTO abbonamento (data_inizio, data_fine, num_smartcard, email, costo, tipo, carta_carburante)
    VALUES ('2019-07-13', '2019-08-01', 193053945, 'luca_rossi@gmail.com', 36.00, 'Mensile', 5576);
INSERT INTO abbonamento (data_inizio, data_fine, num_smartcard, email, costo, tipo, carta_carburante)
    VALUES ('2019-07-07', '2019-08-04', 203570453, 'giovanni93@gmail.com', 30.00, 'Mensile', 8900);
INSERT INTO abbonamento (data_inizio, data_fine, num_smartcard, email, costo, tipo, carta_carburante)
    VALUES ('2019-07-06', '2019-10-03', 174087365, 'abc@gmail.com', 40.00, 'Trimestrale', 2212);
INSERT INTO abbonamento (data_inizio, data_fine, num_smartcard, email, costo, tipo, carta_carburante)
    VALUES ('2019-07-22', '2019-08-13', 152074735, 'qwe@gmail.com', 40.00, 'Mensile', 5512);
INSERT INTO abbonamento (data_inizio, data_fine, num_smartcard, email, costo, tipo, carta_carburante)
    VALUES ('2019-07-24', '2019-11-11', 153986098, 'sara123@gmail.com', 20.00, 'Trimesrtale', 3476);
INSERT INTO abbonamento (data_inizio, data_fine, num_smartcard, email, costo, tipo, carta_carburante)
    VALUES ('2019-07-17', '2019-12-10', 345632908, 'ttt2@gmail.com', 40.00, 'Trimestrale', 7734);
INSERT INTO abbonamento (data_inizio, data_fine, num_smartcard, email, costo, tipo, carta_carburante)
    VALUES ('2019-07-28', '2019-08-09', 167945289, 'marco123@gmail.com', 20.00, 'Mensile', 9145);

-- PRENOTAZIONE
INSERT INTO prenotazione (data_ritiro, data_consegna, targa, data_ritiro_e, data_consegna_e, penale, km_percorsi,
                          data_annullamento, email)
    VALUES ('2019-07-12 09:00:00.000', '2019-07-14 17:00:00.000', '3PPJ765', '2019-07-12 09:20:00.000',
            '2019-07-14 16:00:00.000', 0.00, 20, NULL, 'alice123@gmail.com');
INSERT INTO prenotazione (data_ritiro, data_consegna, targa, data_ritiro_e, data_consegna_e, penale, km_percorsi,
                          data_annullamento, email)
    VALUES ('2019-07-10 13:00:00.000', '2019-07-15 16:00:00.000', '7QFRF8R', NULL, NULL, 0.00, 0, NULL,
            'abc@gmail.com');
INSERT INTO prenotazione (data_ritiro, data_consegna, targa, data_ritiro_e, data_consegna_e, penale, km_percorsi,
                          data_annullamento, email)
    VALUES ('2019-07-25 17:00:00.000', '2019-08-30 09:00:00.000', 'I4S30U7', NULL, NULL, 0.00, 0, NULL,
            'sara123@gmail.com');
INSERT INTO prenotazione (data_ritiro, data_consegna, targa, data_ritiro_e, data_consegna_e, penale, km_percorsi,
                          data_annullamento, email)
    VALUES ('2019-08-01 11:00:00.000', '2019-08-03 18:00:00.000', '5ZEFX4X', NULL, NULL, 0.00, 0, NULL,
            'marco123@gmail.com');
INSERT INTO prenotazione (data_ritiro, data_consegna, targa, data_ritiro_e, data_consegna_e, penale, km_percorsi,
                          data_annullamento, email)
    VALUES ('2019-07-11 12:00:00.000', '2019-07-12 09:00:00.000', '7Z29X15', NULL, NULL, 0.00, 0, NULL,
            'giovanni93@gmail.com');

-- RIFORNIMENTO
INSERT INTO rifornimento (data_rifornimento, targa, litri, chilometraggio)
    VALUES ('2019-07-13 00:00:00.000', '3PPJ765', 10, 90);

-- CONDUCENTE
INSERT INTO conducente (num_patente, codice_fiscale, categoria_patente, num_carta_identita, luogo_nascita, data_nascita,
                        cognome, nome, indirizzo_residenza, partita_iva)
    VALUES ('01234567', 'PBHFTO76W83M220J', 'B', '54321', 'Genova', '1993-04-12', 'Repetto', 'Sara',
            'via borgo nuovo 19, GE', NULL);
INSERT INTO conducente (num_patente, codice_fiscale, categoria_patente, num_carta_identita, luogo_nascita, data_nascita,
                        cognome, nome, indirizzo_residenza, partita_iva)
    VALUES ('09876132', NULL, 'B', '79399', 'Genova', '1990-01-01', 'Calcagno', 'Giorgio', 'via dodecaneso 33, GE',
            '18530718725');
INSERT INTO conducente (num_patente, codice_fiscale, categoria_patente, num_carta_identita, luogo_nascita, data_nascita,
                        cognome, nome, indirizzo_residenza, partita_iva)
    VALUES ('82639268', NULL, 'B', '82563', 'Genova', '1963-09-23', 'Barbieri', 'Filippo', 'via donghi 12, GE',
            '24136243257');
INSERT INTO conducente (num_patente, codice_fiscale, categoria_patente, num_carta_identita, luogo_nascita, data_nascita,
                        cognome, nome, indirizzo_residenza, partita_iva)
    VALUES ('10273791', NULL, 'B', '11583', 'Genova', '1969-08-22', 'Camera', 'Mattia', 'via matteotti 16, GE',
            '82031669341');
INSERT INTO conducente (num_patente, codice_fiscale, categoria_patente, num_carta_identita, luogo_nascita, data_nascita,
                        cognome, nome, indirizzo_residenza, partita_iva)
    VALUES ('25835023', 'PLTKXN68A48F476J', 'B', '96456', 'Genova', '1973-11-21', 'Priano', 'Alice',
            'via torino 10, GE', NULL);
INSERT INTO conducente (num_patente, codice_fiscale, categoria_patente, num_carta_identita, luogo_nascita, data_nascita,
                        cognome, nome, indirizzo_residenza, partita_iva)
    VALUES ('44682902', 'BRKAUK31P67F160X', 'B', '23756', 'Genova', '1975-12-20', 'Alfieri', 'Marco',
            'corso saracco 47, GE', NULL);
INSERT INTO conducente (num_patente, codice_fiscale, categoria_patente, num_carta_identita, luogo_nascita, data_nascita,
                        cognome, nome, indirizzo_residenza, partita_iva)
    VALUES ('17794562', 'NABRMD43A11F921T', 'B', '12876', 'Genova', '1988-01-27', 'Rossi', 'Luca',
            'via san paolo 33, GE', NULL);
INSERT INTO conducente (num_patente, codice_fiscale, categoria_patente, num_carta_identita, luogo_nascita, data_nascita,
                        cognome, nome, indirizzo_residenza, partita_iva)
    VALUES ('03785929', 'SRTRNH55P21F080Q', 'B', '23450', 'Genova', '1982-05-02', 'Ronco', 'Giovanni',
            'via tommasini 11, GE', NULL);

