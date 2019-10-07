CREATE SCHEMA "bd1";

SET SEARCH_PATH TO "bd1";

CREATE TABLE utente (
    email VARCHAR(20) NOT NULL,
    bonus BOOL NOT NULL,
    ammontare NUMERIC(6, 2) NOT NULL DEFAULT 0,
    PRIMARY KEY (email)
);
CREATE TABLE abbonamento (
    data_inizio DATE NOT NULL,
    data_fine DATE NOT NULL,
    num_smartcard INT NOT NULL,
    email VARCHAR(20) NOT NULL REFERENCES utente,
    costo NUMERIC(6, 2) NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    carta_carburante INT NOT NULL,
    PRIMARY KEY (data_inizio, email),
    FOREIGN KEY (email) REFERENCES utente(email)
);
CREATE TABLE azienda (
    partita_iva VARCHAR(11) NOT NULL,
    indirizzo_sede_legale VARCHAR(100) NOT NULL,
    ragione_sociale VARCHAR(20) NOT NULL,
    nome_referente VARCHAR(20) NOT NULL,
    cognome_referente VARCHAR(20) NOT NULL,
    telefono_referente VARCHAR(10) NOT NULL,
    indirizzo_sede_op VARCHAR(100) NULL,
    data_nascita_rappr DATE NOT NULL,
    luogo_nascita_rappr VARCHAR(40) NOT NULL,
    cognome_rappr VARCHAR(20) NOT NULL,
    nome_rappr VARCHAR(20) NOT NULL,
    settore_attivita VARCHAR(20) NOT NULL,
    telefono VARCHAR(10) NOT NULL,
    email VARCHAR(20) NOT NULL,
    PRIMARY KEY (partita_iva),
    FOREIGN KEY (email) REFERENCES utente(email),
    CONSTRAINT azienda_telefono_key UNIQUE (telefono),
    CONSTRAINT azienda_email_key UNIQUE (email)
);
CREATE TABLE privato (
    codice_fiscale VARCHAR(16) NOT NULL,
    indirizzo_residenza VARCHAR(100) NOT NULL,
    professione VARCHAR(20) NOT NULL,
    genere CHAR(1) NOT NULL,
    email VARCHAR(20) NOT NULL,
    PRIMARY KEY (codice_fiscale),
    FOREIGN KEY (email) REFERENCES utente(email),
    CONSTRAINT privato_email_key UNIQUE (email),
    CONSTRAINT privato_genere_check CHECK (genere LIKE 'm' OR genere LIKE 'f')
);
CREATE TABLE carta_di_credito (
    numero VARCHAR(16) NOT NULL,
    circuito VARCHAR(20) NOT NULL,
    data_scadenza DATE NULL,
    email VARCHAR(20) NOT NULL,
    PRIMARY KEY (numero),
    FOREIGN KEY (email) REFERENCES utente(email),
    CONSTRAINT carta_di_credito_data_scadenza_check CHECK ((data_scadenza > CURRENT_DATE))
);
CREATE TABLE categoria (
    tipo VARCHAR(20) NOT NULL,
    PRIMARY KEY (tipo)
);
CREATE TABLE modello (
    nome_modello VARCHAR(20) NOT NULL,
    produttore VARCHAR(20) NOT NULL,
    numero_posti SMALLINT NOT NULL,
    numero_porte SMALLINT NOT NULL,
    velocita_massima SMALLINT NOT NULL,
    consumo_medio NUMERIC(4, 2) NOT NULL,
    airbag BOOL NULL,
    servosterzo BOOL NULL,
    aria_condizionata BOOL NULL,
    altezza SMALLINT NOT NULL,
    lunghezza SMALLINT NOT NULL,
    larghezza SMALLINT NOT NULL,
    bagagliaio SMALLINT NOT NULL,
    cilindrata SMALLINT NULL,
    kw SMALLINT NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    PRIMARY KEY (nome_modello, produttore),
    FOREIGN KEY (tipo) REFERENCES bd1.categoria(tipo),
    CONSTRAINT modello_altezza_check CHECK (altezza > (0)),
    CONSTRAINT modello_bagagliaio_check CHECK (bagagliaio > (0)),
    CONSTRAINT modello_cilindrata_check CHECK (cilindrata > (0)),
    CONSTRAINT modello_consumo_medio_check CHECK (consumo_medio > (0)),
    CONSTRAINT modello_kw_check CHECK ( kw > (0) ),
    CONSTRAINT modello_larghezza_check CHECK (larghezza > (0)),
    CONSTRAINT modello_numero_posti_check CHECK (numero_posti > (0)),
    CONSTRAINT modello_velocita_massima_check CHECK (velocita_massima > (0))
);
CREATE TABLE parcheggio (
    nome VARCHAR(20) NOT NULL,
    longitudine VARCHAR(20) NOT NULL,
    latitudine VARCHAR(20) NOT NULL,
    zona VARCHAR(20) NOT NULL,
    indirizzo VARCHAR(40) NOT NULL,
    num_posti SMALLINT NOT NULL,
    PRIMARY KEY (nome),
    CONSTRAINT parcheggio_num_posti_check CHECK (num_posti > (0))
);
CREATE TABLE vettura (
    targa VARCHAR(7) NOT NULL,
    nome VARCHAR(20) NOT NULL,
    colore VARCHAR(20) NOT NULL,
    chilometraggio INT NOT NULL,
    seggiolini SMALLINT NOT NULL,
    trasporto_animali BOOL NULL,
    nome_parcheggio VARCHAR(20) NOT NULL,
    nome_modello VARCHAR(20) NOT NULL,
    produttore VARCHAR(20) NOT NULL,
    PRIMARY KEY (targa),
    FOREIGN KEY (nome_modello, produttore) REFERENCES modello(nome_modello, produttore),
    FOREIGN KEY (nome_parcheggio) REFERENCES parcheggio(nome),
    CONSTRAINT vettura_chilometraggio_check CHECK (chilometraggio >= (0)),
    CONSTRAINT vettura_nome_key UNIQUE (nome),
    CONSTRAINT vettura_seggiolini_check CHECK (seggiolini >= (0))
);
CREATE TABLE prenotazione (
    data_ritiro TIMESTAMP NOT NULL,
    data_consegna TIMESTAMP NOT NULL,
    targa VARCHAR(7) NOT NULL,
    data_ritiro_e TIMESTAMP NULL,
    data_consegna_e TIMESTAMP NULL,
    penale NUMERIC(6, 2) NULL DEFAULT 0,
    km_percorsi SMALLINT NULL DEFAULT 0,
    data_annullamento DATE NULL,
    email VARCHAR(20) NOT NULL,
    PRIMARY KEY (data_ritiro, targa),
    FOREIGN KEY (email) REFERENCES utente(email),
    FOREIGN KEY (targa) REFERENCES vettura(targa),
    CONSTRAINT prenotazione_check CHECK ((data_consegna > data_ritiro)),
    CONSTRAINT data_consegna_e CHECK ((data_consegna_e < data_consegna)),
    CONSTRAINT data_ritiro_e CHECK ((data_ritiro_e > data_ritiro)),
    CONSTRAINT data_ritiro_valida CHECK ((data_ritiro > current_timestamp + INTERVAL '15 minutes')),
    CONSTRAINT prenotazione_km_percorsi_check CHECK (km_percorsi >= (0)),
    CONSTRAINT prenotazione_penale_check CHECK (penale >= (0))
);
CREATE TABLE rid (
    coordinate VARCHAR(27) NOT NULL,
    email VARCHAR(20) NOT NULL,
    PRIMARY KEY (coordinate),
    FOREIGN KEY (email) REFERENCES utente(email)
);
CREATE TABLE rifornimento (
    data_rifornimento TIMESTAMP NOT NULL,
    targa VARCHAR(7) NOT NULL,
    litri SMALLINT NOT NULL,
    chilometraggio INT NOT NULL,
    CONSTRAINT rifornimento_chilometraggio_check CHECK (chilometraggio > (0)),
    CONSTRAINT rifornimento_litri_check CHECK (litri > (0)),
    PRIMARY KEY (data_rifornimento, targa),
    FOREIGN KEY (targa) REFERENCES vettura(targa)
);
CREATE TABLE tariffa (
    nome_modello VARCHAR(20) NOT NULL,
    produttore VARCHAR(20) NOT NULL,
    supplemento_giornaliero NUMERIC(5, 2) NOT NULL,
    giornaliera NUMERIC(5, 2) NOT NULL,
    settimanale NUMERIC(5, 2) NOT NULL,
    oraria NUMERIC(5, 2) NOT NULL,
    chilometrica NUMERIC(4, 2) NOT NULL,
    PRIMARY KEY (nome_modello, produttore),
    FOREIGN KEY (nome_modello, produttore) REFERENCES modello(nome_modello, produttore),
    CONSTRAINT tariffa_chilometrica_check CHECK (chilometrica >= (0)),
    CONSTRAINT tariffa_giornaliera_check CHECK (giornaliera > (0)),
    CONSTRAINT tariffa_oraria_check CHECK (oraria > (0)),
    CONSTRAINT tariffa_settimanale_check CHECK (settimanale > (0)),
    CONSTRAINT tariffa_supplemento_giornaliero_check CHECK (supplemento_giornaliero > (0))
);
CREATE TABLE conducente (
    num_patente VARCHAR(20) NOT NULL,
    codice_fiscale VARCHAR(16) NULL,
    categoria_patente VARCHAR(20) NOT NULL,
    num_carta_identita VARCHAR(9) NOT NULL,
    luogo_nascita VARCHAR(40) NOT NULL,
    data_nascita DATE NOT NULL,
    cognome VARCHAR(20) NOT NULL,
    nome VARCHAR(20) NOT NULL,
    indirizzo_residenza VARCHAR(40) NOT NULL,
    partita_iva VARCHAR(11) NULL,
    PRIMARY KEY (num_patente),
    FOREIGN KEY (codice_fiscale) REFERENCES privato(codice_fiscale),
    FOREIGN KEY (partita_iva) REFERENCES azienda(partita_iva)
);
CREATE TABLE incidente (
    data_incidente TIMESTAMP NOT NULL,
    targa VARCHAR(7) NOT NULL,
    luogo VARCHAR(40) NOT NULL,
    danni VARCHAR(100) NULL,
    dinamica VARCHAR(100) NULL,
    num_patente VARCHAR(20) NOT NULL,
    PRIMARY KEY (data_incidente, targa),
    FOREIGN KEY (num_patente) REFERENCES conducente(num_patente),
    FOREIGN KEY (targa) REFERENCES vettura(targa)
);
CREATE TABLE testimoni (
    telefono VARCHAR(10) NOT NULL,
    nome VARCHAR(20) NOT NULL,
    cognome VARCHAR(20) NOT NULL,
    PRIMARY KEY (telefono)
);
CREATE TABLE testimonia (
    telefono VARCHAR(10) NOT NULL,
    data_incidente TIMESTAMP NOT NULL,
    targa VARCHAR(7) NOT NULL,
    PRIMARY KEY (telefono, data_incidente, targa),
    FOREIGN KEY (data_incidente, targa) REFERENCES incidente(data_incidente, targa),
    FOREIGN KEY (telefono) REFERENCES testimoni(telefono)
);
CREATE TABLE conducente_esterno (
    targa VARCHAR(7) NOT NULL,
    cognome VARCHAR(20) NOT NULL,
    nome VARCHAR(20) NOT NULL,
    PRIMARY KEY (targa)
);
CREATE TABLE coinvolge (
    targa_esterna VARCHAR(7) NOT NULL,
    data_incidente TIMESTAMP NOT NULL,
    targa VARCHAR(7) NOT NULL,
    PRIMARY KEY (targa_esterna, data_incidente, targa),
    FOREIGN KEY (data_incidente, targa) REFERENCES incidente(data_incidente, targa),
    FOREIGN KEY (targa_esterna) REFERENCES conducente_esterno(targa)
);
CREATE TABLE ospita (
    nome VARCHAR(20) NOT NULL,
    tipo VARCHAR(20) NOT NULL,
    FOREIGN KEY (nome) REFERENCES categoria(tipo),
    FOREIGN KEY (tipo) REFERENCES parcheggio(nome)
);