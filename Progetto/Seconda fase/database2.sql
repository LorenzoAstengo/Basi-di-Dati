set search_path to test;

CREATE TABLE utente(
email	VARCHAR(20) PRIMARY KEY,
ammontare NUMERIC(8,2) NOT NULL DEFAULT 0);

CREATE TABLE rid(
coordinateB CHAR(27) PRIMARY KEY,
email VARCHAR(20) NOT NULL,
FOREIGN KEY (email) REFERENCES utente);

CREATE TABLE cartaDiCredito(
numero CHAR(16) PRIMARY KEY,
circuito VARCHAR(20) NOT NULL,
dataS DATE CHECK (dataS > current_date),
email VARCHAR(20) NOT NULL,
FOREIGN KEY (email) REFERENCES utente);

CREATE TABLE abbonamento(
dataI DATE,
dataF DATE NOT NULL CHECK (dataF > dataI),
numSmartCard NUMERIC(20) NOT NULL,
email VARCHAR(20),
costo NUMERIC(4) CHECK (costo > 0),
tipo VARCHAR(20) NOT NULL,
riduzioneEta NUMERIC(4) DEFAULT 0,
riduzioneConv NUMERIC(4) DEFAULT 0,
cartaCarb NUMERIC(6) NOT NULL,
PRIMARY KEY (dataI,email),
FOREIGN KEY (email) REFERENCES utente);

CREATE TABLE parcheggio
(nome VARCHAR(20) PRIMARY KEY,
longitudine VARCHAR(20) NOT NULL,
latitudine VARCHAR(20) NOT NULL,
zona VARCHAR(20)  NOT NULL,
indirizzo VARCHAR(20) NOT NULL,
numPosti NUMERIC(5) NOT NULL CHECK (numPosti > 0));

CREATE TABLE categoria
(tipo VARCHAR(20) PRIMARY KEY);

CREATE TABLE modello
(nomemodello VARCHAR(20),
produttore VARCHAR(20),
numeroPosti NUMERIC(1) NOT NULL CHECK (numeroPosti > 0),
numeroPorte NUMERIC(1) NOT NULL,
velocitaMax NUMERIC(3) NOT NULL CHECK (velocitaMax > 0),
consumoMed NUMERIC(2) NOT NULL CHECK (consumoMed > 0),
airbag BOOL,
servosterzo BOOL,
ariaCond BOOL,
altezza NUMERIC(3,2) NOT NULL CHECK (altezza > 0),
capacitaBagagli NUMERIC(4) NOT NULL CHECK (capacitaBagagli > 0),
larghezza NUMERIC(3,2) NOT NULL CHECK (larghezza > 0),
cilindrata NUMERIC(4) NOT NULL CHECK (Cilindrata > 0),
kw NUMERIC(3,1) NOT NULL CHECK (kw > 0),
tipo VARCHAR(20) NOT NULL,
PRIMARY KEY (nome,produttore),
FOREIGN KEY (tipo) REFERENCES categoria);

CREATE TABLE vettura 
(targa CHAR(7) PRIMARY KEY,
nome VARCHAR(20) UNIQUE NOT NULL,
colore VARCHAR(20) NOT NULL,
chilometraggio NUMERIC(7) NOT NULL CHECK (chilometraggio >= 0),
seggiolini NUMERIC(1) NOT NULL CHECK (seggiolini >= 0),
trasportoAnimali BOOL,
nomeParcheggio VARCHAR(20) NOT NULL,
nomeModello VARCHAR(20) NOT NULL,
produttore VARCHAR(20) NOT NULL,
FOREIGN KEY (nomeModello, produttore) REFERENCES modello,
FOREIGN KEY (nomeParcheggio) REFERENCES parcheggio);

CREATE TABLE prenotazione
(dataRitiro DATE,
orarioRitiro TIME,
dataConsegna DATE NOT NULL CHECK (dataConsegna > dataRitiro),
orarioConsegna TIME NOT NULL,
targa CHAR(7),
dataRitiroE DATE,
orarioRitiroE TIME,
dataConsegnaE DATE,
orarioConsegnaE TIME,
penale NUMERIC(5) DEFAULT 0 CHECK (penale >= 0), 
kmPercorsi NUMERIC(6) DEFAULT 0 CHECK (kmPercorsi >= 0),
dataAnnullamento DATE,
orarioAnnullamento TIME,
email VARCHAR(20) NOT NULL,
PRIMARY KEY (dataRitiro, orarioRitiro, targa),
FOREIGN KEY (targa) REFERENCES vettura,
FOREIGN KEY (email) REFERENCES utente);

CREATE TABLE privato
(cf VARCHAR(16) PRIMARY KEY,
indirizzoResidenza VARCHAR(20) NOT NULL,
professione VARCHAR(20) NOT NULL,
genere CHAR(1) NOT NULL,
email VARCHAR(20) NOT NULL,
FOREIGN KEY (email) REFERENCES utente);

CREATE TABLE azienda
(partitaIva NUMERIC(11) PRIMARY KEY,
indirizzoSedeLegale VARCHAR(20) NOT NULL,
ragioneSociale VARCHAR(20) NOT NULL,
nomeReferente VARCHAR(20) NOT NULL,
cognomeReferente VARCHAR(20) NOT NULL,
telefonoReferente NUMERIC(10) NOT NULL,
indirizzoSedeOp VARCHAR(20),
dataNascitaRapp DATE NOT NULL,
luogoNascitaRapp VARCHAR(20) NOT NULL,
cognomeRapp VARCHAR(20) NOT NULL,
nomeRapp VARCHAR(20) NOT NULL,
settoreAttivita VARCHAR(20) NOT NULL,
telefono NUMERIC(10) NOT NULL UNIQUE,
email VARCHAR(20) NOT NULL,
FOREIGN KEY (email) REFERENCES utente);

CREATE TABLE conducente
(numPatente VARCHAR(20) PRIMARY KEY,
cf VARCHAR(16),
categoriaPatente VARCHAR(20) NOT NULL,
numCartaIdentita VARCHAR(9) NOT NULL,
luogoNascita VARCHAR(20) NOT NULL,
dataNascita DATE NOT NULL,
cognome VARCHAR(20) NOT NULL,
nome VARCHAR(20) NOT NULL,
indirizzoResidenza VARCHAR(20) NOT NULL,
partitaIva NUMERIC(11),
FOREIGN KEY (cf) REFERENCES privato,
FOREIGN KEY (partitaIva) REFERENCES azienda);

CREATE TABLE tariffa
(nomeModello VARCHAR(20),
produttore VARCHAR(20),
supplementoGiornaliero NUMERIC(4) NOT NULL CHECK (supplementoGiornaliero > 0),
giornaliera NUMERIC(4) NOT NULL CHECK (giornaliera >0),
settimanale NUMERIC(4) NOT NULL CHECK (settimanale > 0),
oraria NUMERIC(4) NOT NULL CHECK (oraria > 0),
chilometrica NUMERIC(4) NOT NULL CHECK (chilometrica > 0),
PRIMARY KEY (nomeModello, produttoreModello),
FOREIGN KEY (nomeModello, produttoreModello) REFERENCES modello);

CREATE TABLE rifornimento
(dataRif DATE,
oraRif TIME,
targa VARCHAR(7),
litri NUMERIC(3) NOT NULL CHECK (litri > 0),
chilometraggio NUMERIC(6) NOT NULL CHECK (chilometraggio > 0),
PRIMARY KEY (dataRif, oraRif, targa),
FOREIGN KEY (targa) REFERENCES vettura);

CREATE TABLE incidente
(dataInc DATE,
oraInc TIME,
targa VARCHAR(7),
luogo VARCHAR(20) NOT NULL,
danni VARCHAR(100),
dinamica VARCHAR(100),
numPatente VARCHAR(20) NOT NULL,
PRIMARY KEY (dataInc, oraInc, targa),
FOREIGN KEY (targa) REFERENCES vettura,
FOREIGN KEY (numPatente) REFERENCES conducente);

CREATE TABLE conducenteEst
(targa VARCHAR(7),
cognome VARCHAR(20) NOT NULL,
nome VARCHAR(20) NOT NULL,
PRIMARY KEY (targa));

CREATE TABLE coinvolge
(targaEst VARCHAR(7),
datainc DATE,
orainc TIME,
targa VARCHAR(7),
PRIMARY KEY (targaEst, datainc, orainc, targa),
FOREIGN KEY (targaEst) REFERENCES conducenteEst,
FOREIGN KEY (datainc, orainc, targa) REFERENCES incidente);

CREATE TABLE testimoni
(telCell NUMERIC(10),
nome VARCHAR(20) NOT NULL,
cognome VARCHAR(20) NOT NULL,
PRIMARY KEY (telCell));

CREATE TABLE testimonia
(telCell NUMERIC(10),
dataInc DATE,
oraInc TIME,
targa VARCHAR(7),
PRIMARY KEY (telCell, dataInc, oraInc, targa),
FOREIGN KEY (telCell) REFERENCES testimoni,
FOREIGN KEY (dataInc, oraInc, targa) REFERENCES incidente);
