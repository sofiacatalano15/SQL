-- CREAZIONE DEL DATABASE
CREATE DATABASE VideogameStoreDB;

USE VideogameStoreDB;

-- CREAZIONE DELLA TABELLA DELLO STORE
CREATE TABLE STORE (CodiceStore INT NOT NULL auto_increment,
IndirizzoFisico VARCHAR(50),
NumeroTelefono VARCHAR(15), PRIMARY KEY(CodiceStore));

-- CREAZIONE DELLA TABELLA IMPIEGATO
CREATE TABLE IMPIEGATO (CodiceFiscale VARCHAR(16),
Nome VARCHAR(50),
TitoloStudio VARCHAR(50),
Recapito VARCHAR(40), PRIMARY KEY(CodiceFiscale));

-- CREAZIONE DELLA TABELLA SERVIZIO_IMPIEGATO
CREATE TABLE SERVIZIO_IMPIEGATO (Id_Servizio INT NOT NULL auto_increment,
CodiceFiscale VARCHAR(16),
CodiceStore INT,
DataInizio DATE,
DataFine DATE,
Carica VARCHAR(30),
PRIMARY KEY (Id_Servizio),
FOREIGN KEY (CodiceFiscale) REFERENCES IMPIEGATO(CodiceFiscale),
FOREIGN KEY (CodiceStore) REFERENCES STORE(CodiceStore));

-- CREAZIONE DELLA TABELLA VIDEOGIOCO
CREATE TABLE VIDEOGIOCO (Titolo VARCHAR(30),
Sviluppatore VARCHAR(30),
AnnoDistribuzione DATE,
CostoAcquisto DECIMAL(10,2),
Genere VARCHAR(30),
RemakeDi VARCHAR(30),
CodiceStore INT,
PRIMARY KEY(Titolo),
FOREIGN KEY (CodiceStore) REFERENCES STORE(CodiceStore));

-- INSERIMENTO DEI DATI NELLA TABELLA DELLO STORE
INSERT INTO STORE (CodiceStore, IndirizzoFisico, NumeroTelefono) VALUES
(1, 'Via Roma 123, Milano', '+39 02 1234567'),
(2, 'Corso Italia 456, Roma', '+39 06 7654321'),
(3, 'Piazza San Marco 789, Venezia', '+39 041 9876543'),
(4, 'Viale degli Ulivi 234, Napoli', '+39 081 3456789'),
(5, 'Via Torino 567, Torino', '+39 011 8765432'),
(6, 'Corso Vittorio Emanuele 890, Firenze', '+39 055 2345678'),
(7, 'Piazza del Duomo 123, Bologna', '+39 051 8765432'),
(8, 'Via Garibaldi 456, Genova', '+39 010 2345678'),
(9, 'Lungarno Mediceo 789, Pisa', '+39 050 8765432'),
(10, 'Corso Cavour 101, Palermo', '+39 091 2345678');

-- INSERIMENTO DEI DATI NELLA TABELLA IMPIEGATO
INSERT INTO IMPIEGATO (CodiceFiscale, Nome, TitoloStudio, Recapito)
VALUES 
('ABC12345XYZ67890', 'Mario Rossi', 'Laurea in Economia', 'mario.rossi@email.com'),
('DEF67890XYZ12345', 'Anna Verdi', 'Diploma di Ragioneria', 'anna.verdi@email.com'),
('GHI12345XYZ67890', 'Luigi Bianchi', 'Laurea in Informatica', 'luigi.bianchi@email.com'),
('JKL67890XYZ12345', 'Laura Neri', 'Laurea in Lingue', 'laura.neri@email.com'),
('MNO12345XYZ67890', 'Andrea Moretti', 'Diploma di Geometra', 'andrea.moretti@email.com'),
('PQR67890XYZ12345', 'Giulia Ferrara', 'Laurea in Psicologia', 'giulia.ferrara@email.com'),
('STU12345XYZ67890', 'Marco Esposito', 'Diploma di Elettronica', 'marco.esposito@email.com'),
('VWX67890XYZ12345', 'Sara Romano', 'Laurea in Giurisprudenza', 'sara.romano@email.com'),
('YZA12345XYZ67890', 'Roberto De Luca', 'Diploma di Informatica', 'roberto.deluca@email.com'),
('BCD67890XYZ12345', 'Elena Santoro', 'Laurea in Lettere', 'elena.santoro@email.com');

-- INSERIMENTO DEI DATI NELLA TABELLA SERVIZIO_IMPIEGATO
INSERT INTO SERVIZIO_IMPIEGATO (Id_Servizio, CodiceFiscale, CodiceStore, DataInizio, DataFine, Carica)
VALUES 
(1,'ABC12345XYZ67890', 1, '2023-01-01', '2023-12-31', 'Cassiere'),
(2,'DEF67890XYZ12345', 2, '2023-02-01', '2023-11-30', 'Commesso'),
(3,'GHI12345XYZ67890', 3, '2023-03-01', '2023-10-31', 'Magazziniere'),
(4,'JKL67890XYZ12345', 4, '2023-04-01', '2023-09-30', 'Addetto alle vendite'),
(5,'MNO12345XYZ67890', 5, '2023-05-01', '2023-08-31', 'Addetto alle pulizie'),
(6,'PQR67890XYZ12345', 6, '2023-06-01', '2023-07-31', 'Commesso'),
(7,'STU12345XYZ67890', 7, '2023-07-01', '2023-06-30', 'Commesso'),
(8,'VWX67890XYZ12345', 8, '2023-08-01', '2023-05-31', 'Cassiere'),
(9,'YZA12345XYZ67890', 9, '2023-09-01', '2023-04-30', 'Cassiere'),
(10,'BCD67890XYZ12345', 10, '2023-10-01', '2023-03-31', 'Cassiere');

-- INSERIMENTO DEI DATI NELLA TABELLA VIDEOGIOCO
INSERT INTO VIDEOGIOCO (Titolo, Sviluppatore, AnnoDistribuzione, CostoAcquisto, Genere, RemakeDi, CodiceStore)
VALUES 
    ('Fifa 2023', 'EA Sports', '2023-01-01', 49.99, 'Calcio', NULL, 5),
    ('Assassin''s Creed: Valhalla', 'Ubisoft', '2020-01-01', 59.99, 'Action', NULL,2),
    ('Super Mario Odyssey', 'Nintendo', '2017-01-01', 39.99, 'Platform', NULL,1),
    ('The Last of Us Part II', 'Naughty Dog', '2020-01-01', 69.99, 'Action', NULL,4),
    ('Cyberpunk 2077', 'CD Projekt Red', '2020-01-01', 49.99, 'RPG', NULL,3),
    ('Animal Crossing: New Horizons', 'Nintendo', '2020-01-01', 54.99, 'Simulation', NULL,8),
    ('Call of Duty: Warzone', 'Infinity Ward', '2020-01-01', 0.00, 'FPS', NULL,7),
    ('The Legend of Zelda', 'Nintendo', '2017-01-01', 59.99, 'Action-Adventure', NULL,6),
    ('Fortnite', 'Epic Games', '2017-01-01', 0.00, 'Battle Royale', NULL,10),
    ('Red Dead Redemption 2', 'Rockstar Games', '2018-01-01', 39.99, 'Action-Adventure', NULL,9);

-- DROP table VIDEOGIOCO;

-- ESEGUE LA QUERY PER RITROVARE LA COLLOCAZIONE DEL VIDEOGIOCO
SELECT videogioco.Titolo, store.IndirizzoFisico
FROM store
JOIN videogioco ON store.CodiceStore = videogioco.CodiceStore;

-- DESCRIBE VIDEOGIOCO;
`classicmodels`
-- SHOW tables;