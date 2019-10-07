SET SEARCH_PATH TO bd1;

-- Controlla se un utente ha un abbonamento attivo al momento dell'inserimento o dell'aggiornamento di una tupla in abbonamenti

CREATE OR REPLACE FUNCTION ABBONAMENTO_ATTIVO() RETURNS TRIGGER AS
$$
BEGIN
    PERFORM * FROM abbonamento WHERE email = new.email AND data_fine > new.data_inizio;
    IF found THEN RAISE EXCEPTION '% ha già un abbonamento attivo nel periodo selezionato!' , new.email; END IF;
    RETURN new;
END
$$ LANGUAGE PLPGSQL;

DROP TRIGGER IF EXISTS trigger_abbonamento_attivo ON abbonamento;

CREATE TRIGGER trigger_abbonamento_attivo
    BEFORE INSERT OR UPDATE
    ON abbonamento
    FOR EACH ROW
EXECUTE PROCEDURE ABBONAMENTO_ATTIVO();

---------------------------------------------------------------------------------------------------

-- Controlla se un utente ha associata una modalita di pagamento al momento dell' inserimento o aggiornamento di una tupla in abbonamento 

CREATE OR REPLACE FUNCTION modalita_pagamento() RETURNS TRIGGER AS
$$
BEGIN
    IF exists(SELECT * FROM utente WHERE email = new.email AND ammontare > 0) THEN
        RETURN new;
    ELSIF exists(SELECT * FROM rid WHERE email = new.email) THEN
        RETURN new;
    ELSIF exists(SELECT * FROM carta_di_credito WHERE email = new.email) THEN
        RETURN new;
    ELSE
        RAISE EXCEPTION '% non ha una nessuna modalita di pagamento!' , new.email;
    END IF;
END
$$ LANGUAGE PLPGSQL;

DROP TRIGGER IF EXISTS trigger_modalita_pagamento ON abbonamento;

CREATE TRIGGER trigger_modalita_pagamento
    BEFORE INSERT OR UPDATE
    ON abbonamento
    FOR EACH ROW
EXECUTE PROCEDURE modalita_pagamento();

-------------------------------------------------------------------------------------------------------

-- Al momento della prenotazione controlla se l'utente ha un abbonamento valido (la data ritiro deve essere sucessiva alla data di inizio dell'abbonamento)

CREATE OR REPLACE FUNCTION abbonamento_valido() RETURNS TRIGGER AS
$$
BEGIN
    PERFORM *
        FROM abbonamento
        WHERE new.email = abbonamento.email AND new.data_consegna < data_fine AND new.data_ritiro > data_inizio;
    IF NOT found THEN RAISE EXCEPTION '% non ha un abbonamento valido!', new.email; END IF;
    RETURN new;
END;
$$ LANGUAGE 'plpgsql';

DROP TRIGGER IF EXISTS trigger_abbonamento_valido ON prenotazione;

CREATE TRIGGER trigger_abbonamento_valido
    BEFORE INSERT OR UPDATE
    ON prenotazione
    FOR EACH ROW
EXECUTE PROCEDURE abbonamento_valido();

--------------------------------------------------------------------------------------------------------

-- Controlla se un conducente e' associato o a un codice fiscale o a una partita Iva

CREATE OR REPLACE FUNCTION conducente() RETURNS TRIGGER AS
$$
BEGIN
    IF ((new.partita_iva IS NOT NULL AND new.codice_fiscale IS NOT NULL)
            OR new.partita_iva IS NULL AND new.codice_fiscale IS NULL) THEN
        RAISE EXCEPTION 'Un conducente deve essere associato o a un codice fiscale o a una partita iva!';
    END IF;
    RETURN new;
END
$$ LANGUAGE PLPGSQL;

DROP TRIGGER IF EXISTS trigger_conducente ON conducente;

CREATE TRIGGER trigger_conducente
    BEFORE INSERT OR UPDATE
    ON conducente
    FOR EACH ROW
EXECUTE PROCEDURE conducente();
----------------------------------------------------------------------------------------------------------

-- Controlla se il conducente addizionale ha lo stesso indirizzo di residenza del privato a cui e' associato

CREATE OR REPLACE FUNCTION conducente_addizionale() RETURNS TRIGGER AS
$$
BEGIN
    IF (new.partita_iva IS NOT NULL) THEN RETURN new; END IF;
    IF NOT EXISTS(SELECT *
                      FROM privato
                      WHERE codice_fiscale = new.codice_fiscale AND indirizzo_residenza = new.indirizzo_residenza) THEN
        RAISE EXCEPTION 'Indirizzo e residenza di % non combaciano con i dati in privato!' , new.codice_fiscale;
    END IF;
    RETURN new;
END
$$ LANGUAGE PLPGSQL;

DROP TRIGGER IF EXISTS trigger_conducente_addizionale ON conducente;

CREATE TRIGGER trigger_conducente_addizionale
    BEFORE INSERT OR UPDATE
    ON conducente
    FOR EACH ROW
EXECUTE PROCEDURE conducente_addizionale();
-------------------------------------------------------------------------------------------------------------

-- Quando si inserisce una data di annullamento controlla che i campi di utilizzo efettivo non sia stati popolati

CREATE OR REPLACE FUNCTION annullamento_prenotazione() RETURNS TRIGGER AS
$$
BEGIN
    IF (new.data_annullamento IS NOT NULL AND (new.data_ritiro_e IS NOT NULL OR new.data_consegna_e IS NOT NULL)) THEN
        RAISE EXCEPTION 'Non si puo annullare una prenotazione in utilizzo';
    END IF;
    RETURN new;
END
$$ LANGUAGE PLPGSQL;

DROP TRIGGER IF EXISTS trigger_annullamento_prenotazione ON prenotazione;

CREATE TRIGGER trigger_annullamento_prenotazione
    AFTER INSERT OR UPDATE
    ON prenotazione
    FOR EACH ROW
EXECUTE PROCEDURE annullamento_prenotazione();
----------------------------------------------------------------------------------------------------------------

