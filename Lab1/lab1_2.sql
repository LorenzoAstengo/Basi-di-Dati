set search_path to corsi;
CREATE TABLE Studenti
(
	matricola SERIAL PRIMARY KEY,
	cognome CHAR VARYING (15),
	nome CHAR VARYING (15),
	corsoDiLaurea CHAR VARYING (20),
	iscrizione CHAR (9),
	relatore NUMERIC(5) DEFAULT NULL,
	FOREIGN KEY (relatore) REFERENCES professori ON DELETE NO ACTION ON UPDATE CASCADE);