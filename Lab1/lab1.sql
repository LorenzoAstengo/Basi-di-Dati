CREATE schema corsi;

set search_path to corsi;

CREATE TABLE Professori 
(	id NUMERIC(5) PRIMARY KEY,
	cognome CHAR VARYING(15) NOT NULL,
	nome CHAR VARYING(15) NOT NULL,
	stipendio NUMERIC(8,2) DEFAULT 15000,
 	inCongedo BOOL DEFAULT FALSE,
 	UNIQUE (cognome, nome));

INSERT INTO Professori VALUES (54661, 'guerrini','giovanna', 123456.78, FALSE);
INSERT INTO Professori VALUES (6610, 'rossi','anna', 123456.78, FALSE);
INSERT INTO Professori VALUES (6635, 'bianchi','paola', 123456.78, FALSE);
INSERT INTO Professori VALUES (6642, 'verdi','marco', 8200, TRUE);
INSERT INTO Professori VALUES (51403, 'verri','alessandro', 123456.78, FALSE);
INSERT INTO professori VALUES(54661, 'andrea', 'rossi', 45000);
--ERROR:  ERRORE:  un valore chiave duplicato viola il vincolo univoco "professori_pkey"
--DETTAGLI: La chiave (id)=(54661) esiste già.
INSERT INTO professori VALUES(5661, 'guerrini', 'giovanna', 45000);
--ERROR:  ERRORE:  un valore chiave duplicato viola il vincolo univoco "professori_cognome_nome_key"
--DETTAGLI: La chiave (cognome, nome)=(guerrini, giovanna) esiste già.
INSERT INTO professori VALUES (65420,14500);
--ERROR:  ERRORE:  valori null nella colonna "nome" violano il vincolo non-null
--DETTAGLI: La riga in errore contiene (65420, 14500, null, 15000.00, f).

create table Corsi
(	id char(10) primary key,
	corsoDiLaurea char(20),
	nome char(20),
 	professor numeric(5),
	foreign key (professor) references Professori on delete no action on update cascade,
 	attivato bool default false);

insert into corsi values ('bd01', 'Informatica', 'Basi di dati', 54661, TRUE);
INSERT INTO corsi VALUES ('el01', 'Informatica', 'Elettronica', 51403, TRUE);
INSERT INTO corsi VALUES ('calc01', 'Elettronica', 'Calcolatori', 6610, TRUE);
INSERT INTO corsi VALUES('fia01', 'Fisica', 'Fisica_A', 6635, FALSE);
INSERT INTO corsi VALUES('fia02', 'Fisica', 'Fisica_A', 6635, TRUE);
INSERT INTO corsi VALUES('a101', 'Matematica', 'Analisi1', 6642, TRUE);
INSERT INTO corsi VALUES ('geo1','Matematica', 'Geometria', 44110);
--ERROR:  ERRORE:  la INSERT o l'UPDATE sulla tabella "corsi" viola il vincolo di chiave esterna "corsi_professor_fkey"
--DETTAGLI: La chiave (professor)=(44110) non è presente nella tabella "professori".
INSERT INTO corsi VALUES ('geo1','Matematica', 'Geometria');
DELETE FROM professori WHERE id=6610;
--ERROR:  ERRORE:  l'istruzione UPDATE o DELETE sulla tabella "professori" viola il vincolo di chiave esterna "corsi_professor_fkey" sulla tabella "corsi"
--DETTAGLI: La chiave (id)=(6610) è ancora referenziata dalla tabella "corsi".

CREATE TABLE Studenti
(
	matricola SERIAL PRIMARY KEY,
	cognome CHAR VARYING (15),
	nome CHAR VARYING (15),
	corsoDiLaurea CHAR VARYING (20),
	iscrizione CHAR (9),
	relatore NUMERIC(5) DEFAULT NULL,
	FOREIGN KEY (relatore) REFERENCES professori ON DELETE NO ACTION ON UPDATE CASCADE);
	
INSERT INTO studenti VALUES (4368140, 'Rossi', 'Andrea', 'Informatica', '2017/2018');
INSERT INTO studenti VALUES (4678141, 'Verdi', 'Chiara', 'Matematica', '2018/2019');
INSERT INTO studenti VALUES (4120140, 'Rossi', 'Andrea', 'Informatica', '2010/2011', 6642);
INSERT INTO studenti VALUES (4312140, 'Rossi', 'Marta', 'Fisica', '2017/2018');

ALTER TABLE corsi
ADD mutuaDa CHAR(10),
ADD FOREIGN KEY (mutuaDa) REFERENCES corsi(id) ON DELETE SET NULL ON UPDATE CASCADE;

INSERT INTO corsi VALUES ('bdSmid01', 'Smid', 'Basi di Dati', 54661, TRUE, 'bd01');

ALTER TABLE professori
ALTER COLUMN stipendio TYPE numeric(9,2);

ALTER TABLE professori
ALTER COLUMN stipendio TYPE numeric(7,2);
--ERROR:  ERRORE:  il campo numeric causa un overflow
--DETTAGLI: Un campo con precisione 7 e 2 cifre decimali deve arrotondarsi ad un valore assoluto inferiore a 10^5.

INSERT INTO corsi VALUES (68,'Informatica', 'tcs', NULL, NULL);
INSERT INTO corsi VALUES (69,'Informatica', 'tcs', NULL, NULL);

ALTER TABLE corsi
ADD UNIQUE (nome,corsoDiLaurea);
--ERROR:  ERRORE:  creazione dell'indice univoco "corsi_nome_corsodilaurea_key" fallita
--DETTAGLI: La chiave (nome, corsodilaurea)=(Fisica_A            , Fisica              ) è duplicata.

ALTER TABLE professori DROP COLUMN incongedo;