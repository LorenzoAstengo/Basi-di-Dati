create table utente(
email	VARCHAR(20) primary key,
ammontare NUMERIC(8,2));

create table rid(
coordinateB char(27) primary key,
email VARCHAR(20),
foreign key (email) references utente);

create table cartaDiCredito(
numero char(16) primary key,
circuito varchar(20),
dataS date,
email varchar(20),
foreign key (email) references utente);

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

create table parcheggio
(nome varchar(20) primary key,
longitudine varchar(20),
latitudine varchar(20),
zona varchar(20),
indirizzo varchar(20),
numPosti numeric(5));

create table categoria
(tipo varchar(20) primary key);

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

create table privato
(cf varchar(16) primary key,
indirizzoResidenza varchar(20),
professione varchar(20),
genere char(1),
email varchar(20),
foreign key (email) references utente);

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

create table rifornimento
(dataRif date,
oraRif time,
targa varchar(7),
litri numeric(3),
chilometraggio numeric(6),
primary key (dataRif, oraRif, targa),
foreign key (targa) references vettura);

create table incidente
(dataInc date,
oraInc time,
targa varchar(7),
luogo varchar(20),
danni varchar(100),
dinamica varchar(100),
primary key (dataInc, oraInc, targa),
foreign key (targa) references vettura);

create table conducenteEst
(targa varchar(7),
cognome varchar(20),
nome varchar(20),
primary key (targa));

create table coinvolge
(targaEst varchar(7),
datainc date,
orainc time,
targa varchar(7),
primary key (targaEst, datainc, orainc, targa),
foreign key (targaEst) references conducenteest,
foreign key (datainc,orainc,targa) references incidente);

create table testimoni
(telCell numeric(10),
nome varchar(20),
cognome varchar(20),
primary key (telCell));

create table testimonia
(telCell numeric(10),
dataInc date,
oraInc time,
targa varchar(7),
primary key (telCell, dataInc, oraInc, targa),
foreign key (telCell) references testimoni,
foreign key (dataInc, oraInc, targa) references incidente);
