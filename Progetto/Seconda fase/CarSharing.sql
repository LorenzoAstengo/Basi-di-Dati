--CAR SHARING gruppo 7

--Utente
create table utente(
email	VARCHAR(30) primary key,
ammontare NUMERIC(8,2));

INSERT INTO utente VALUES ('matteo.bianchi@gmail.com', 40.50);
INSERT INTO utente VALUES ('giorgia.rossi@gmail.com', 10);
INSERT INTO utente VALUES ('maria.ferrero@gmail.com', 30);
INSERT INTO utente VALUES ('luca.lombardo@gmail.com', 5);
INSERT INTO utente VALUES ('roberta.testa@gmail.com', 27);
INSERT INTO utente VALUES ('giacomo.perrone@gmail.com', 33);
INSERT INTO utente VALUES ('giorgio.ivaldi@gmail.com', 45);
INSERT INTO utente VALUES ('ludovico.fedele@gmail.com', 22);
INSERT INTO utente VALUES ('elisa.franceschini@gmail.com', 18);
INSERT INTO utente VALUES ('simone.caviglia@gmail.com', 28);
INSERT INTO utente VALUES ('francesco.massetti@gmail.com', 23);
------------------------------------------------------------------------------------------------
create table rid(
coordinateB char(27) primary key,
email VARCHAR(30),
foreign key (email) references utente);
				  
INSERT INTO rid VALUES ('IT02L1234512345123456789012','matteo.bianchi@gmail.com');
INSERT INTO rid VALUES ('IT13S9365765738284956748456','giorgia.rossi@gmail.com');
INSERT INTO rid VALUES ('IT54T3214467543346543787654','maria.ferrero@gmail.com');
INSERT INTO rid VALUES ('IT67H1242487543545457543888','luca.lombardo@gmail.com');
INSERT INTO rid VALUES ('IT99K2341489456787634321768','roberta.testa@gmail.com');
INSERT INTO rid VALUES ('IT65D6754698053467842376547','giacomo.perrone@gmail.com');
INSERT INTO rid VALUES ('IT98W2134265322763578754776','giorgio.ivaldi@gmail.com');
INSERT INTO rid VALUES ('IT34I8768723421564235444657','ludovico.fedele@gmail.com');
INSERT INTO rid VALUES ('IT98S5432432654876432567776','elisa.franceschini@gmail.com');
INSERT INTO rid VALUES ('IT04E7786578987234214675809','simone.caviglia@gmail.com');
INSERT INTO rid VALUES ('IT67K5467865436764257865560','francesco.massetti@gmail.com');
----------------------------------------------------------------------------------------------------------------
create table cartaDiCredito(
numero numeric(16) primary key,
circuito varchar(20),
dataS date,
email varchar(30),
foreign key (email) references utente);
				  
INSERT INTO cartaDiCredito VALUES ('8463547894538462','Mastercard','25/04/2020','matteo.bianchi@gmail.com');
INSERT INTO cartaDiCredito VALUES ('5678665435642135','American Express','04/12/2022','giorgia.rossi@gmail.com');
INSERT INTO cartaDiCredito VALUES ('9863675432657843','Mastercard','12/06/2024','maria.ferrero@gmail.com');
INSERT INTO cartaDiCredito VALUES ('5636864326785432','Mastercard','05/07/2021','luca.lombardo@gmail.com');
INSERT INTO cartaDiCredito VALUES ('0976547854324677','Visa','23/08/2022','roberta.testa@gmail.com');
INSERT INTO cartaDiCredito VALUES ('6876545754334567','Mastercard','15/06/2025','giacomo.perrone@gmail.com');
INSERT INTO cartaDiCredito VALUES ('5766522234688900','Mastercard','09/01/2022','giorgio.ivaldi@gmail.com');
INSERT INTO cartaDiCredito VALUES ('5646443334678776','CartaSi','11/11/2023','ludovico.fedele@gmail.com');
INSERT INTO cartaDiCredito VALUES ('6677896544532667','Visa','14/05/2024','elisa.franceschini@gmail.com');
INSERT INTO cartaDiCredito VALUES ('1127897654456673','Visa','07/03/2025','simone.caviglia@gmail.com');
INSERT INTO cartaDiCredito VALUES ('9875435787976543','American Express','12/03/2021','francesco.massetti@gmail.com');
-----------------------------------------------------------------------------------------------------------------------
create table abbonamento(
dataI date,
dataF date,
numSmartCard numeric(20),
email varchar(20),
costo numeric(4),
tipo varchar(20),
riduzioneEta numeric(4),
riduzioneConv numeric(4),
cartaCarb numeric(6),
primary key (dataI,dataF,email),
foreign key (email) references utente);
				  
-----------------------------------------------------------------------------------------
create table parcheggio
(nome varchar(20) primary key,
longitudine varchar(20),
latitudine varchar(20),
zona varchar(20),
indirizzo varchar(20),
numPosti numeric(5));
-----------------------------------------------------------------
create table categoria
(tipo varchar(20) primary key);
-----------------------------------------------------------------
create table modello
(nome varchar(20),
produttore varchar(20),
numeroPosti numeric(1),
numeroPorte numeric(1),
velocitaMax numeric(3),
consumoMed numeric(2),
airbag bool,
servosterzo bool,
ariaCond bool,
altezza numeric(3,2),
capacitaBagagli numeric(4),
larghezza numeric(3,2),
cilindrata numeric(4),
kw numeric(4,1),
tipo varchar(20),
primary key (nome,produttore),
foreign key (tipo) references categoria);
-----------------------------------------------------------------
create table vettura 
(targa char(7) primary key,
nome varchar(20),
colore varchar(20),
chilometraggio numeric(7),
seggiolini numeric(1),
trasportoAnimali bool,
nomeParcheggio varchar(20),
nomeModello varchar(20),
produttore varchar(20),
foreign key (nomeModello, produttore) references modello,
foreign key (nomeParcheggio) references parcheggio);
-----------------------------------------------------------------
create table prenotazione
(dataRitiro date,
orarioRitiro time,
dataConsegna date,
orarioConsegna time,
targa char(7),
dataRitiroE date,
orarioRitiroE time,
dataConsegnaE date,
orarioConsegnaE time,
penale numeric(5),
kmPercorsi numeric(6),
dataAnnullamento date,
orarioAnnullamento time,
email varchar(20),
primary key (dataRitiro, orarioRitiro, targa),
foreign key (targa) references vettura,
foreign key (email) references utente);
-----------------------------------------------------------------
create table privato
(cf varchar(16) primary key,
indirizzoResidenza varchar(20),
professione varchar(20),
genere char(1),
email varchar(20),
foreign key (email) references utente);
-----------------------------------------------------------------
create table conducente
(numPatente varchar(20) primary key,
cf varchar(16),
categoriaPatente varchar(20),
numCartaIdentita varchar(9),
luogoNascita varchar(20),
dataNascita date,
cognome varchar(20),
nome varchar(20),
indirizzoResidenza varchar(20),
foreign key (cf) references privato);
-----------------------------------------------------------------
create table azienda
(partitaIva numeric(11) primary key,
indirizzoSedeLegale varchar(20),
ragioneSociale varchar(20),
nomeReferente varchar(20),
cognomeReferente varchar(20),
telefonoReferente numeric(10),
indirizzoSedeOp varchar(20),
dataNascitaRapp date,
luogoNascitaRapp varchar(20),
cognomeRapp varchar(20),
nomeRapp varchar(20),
settoreAttivita varchar(20),
telefono numeric(10),
email varchar(20),
foreign key (email) references utente);
-----------------------------------------------------------------
create table dipendente
(numPatente varchar(20),
partitaIva numeric(11),
categoriaPatente varchar(20),
numCartaIdentita varchar(9),
luogoNascita varchar(20),
dataNascita date,
cognome varchar(20),
nome varchar(20),
indirizzoResidenza varchar(20),
primary key (numPatente, partitaIva),
foreign key (partitaIva) references azienda);
-----------------------------------------------------------------
create table tariffa
(nomeModello varchar(20),
produttoreModello varchar(20),
supplementoGiornaliero numeric(4),
giornaliera numeric(4),
settimanale numeric(4),
oraria numeric(4),
chilometrica numeric(4),
primary key (nomeModello, produttoreModello),
foreign key (nomeModello, produttoreModello) references modello);
-----------------------------------------------------------------
create table rifornimento
(dataRif date,
oraRif time,
targa varchar(7),
litri numeric(3),
chilometraggio numeric(6),
primary key (dataRif, oraRif, targa),
foreign key (targa) references vettura);
-----------------------------------------------------------------
create table incidente
(dataInc date,
oraInc time,
targa varchar(7),
luogo varchar(20),
danni varchar(100),
dinamica varchar(100),
primary key (dataInc, oraInc, targa),
foreign key (targa) references vettura);
-----------------------------------------------------------------
create table conducenteEst
(targa varchar(7),
cognome varchar(20),
nome varchar(20),
primary key (targa));
-----------------------------------------------------------------
create table coinvolge
(targaEst varchar(7),
datainc date,
orainc time,
targa varchar(7),
primary key (targaEst, datainc, orainc, targa),
foreign key (targaEst) references conducenteest,
foreign key (datainc,orainc,targa) references incidente);
-----------------------------------------------------------------
create table testimoni
(telCell numeric(10),
nome varchar(20),
cognome varchar(20),
primary key (telCell));
-----------------------------------------------------------------
create table testimonia
(telCell numeric(10),
dataInc date,
oraInc time,
targa varchar(7),
primary key (telCell, dataInc, oraInc, targa),
foreign key (telCell) references testimoni,
foreign key (dataInc, oraInc, targa) references incidente);
-----------------------------------------------------------------		 
--Vista fatturazione
--Interrogazioni semplici
--Manipolazione
--Interrogazioni di analisi
			 
---------------------------------------------------------------

			 

