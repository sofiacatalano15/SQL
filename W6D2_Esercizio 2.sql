-- Creazione del database
CREATE DATABASE GestioneOrdiniDB;

-- Utilizzo del database creato
USE GestioneOrdiniDB;

-- Creazione della tabella Prodotti
CREATE TABLE Prodotti (
IDProdotto INT NOT NULL auto_increment,
NomeProdotto VARCHAR(100),
Prezzo DECIMAL(10,2),
PRIMARY KEY(IDProdotto));

-- Inserimento dei dati nella tabella Prodotti
INSERT INTO Prodotti (IDProdotto, NomeProdotto, Prezzo) VALUES
(1, 'Tablet', 300.00),
(2, 'Mouse', 20.00),
(3, 'Tastiera', 25.00),
(4, 'Monitor', 180.00),
(5, 'HDD', 90.00),
(6, 'SSD', 200.00),
(7, 'RAM', 100.00),
(8, 'Router', 80.00),
(9, 'Webcam', 45.00),
(10, 'GPU', 1250.00),
(11, 'Trackpad', 500.00),
(12, 'Techmagazine', 5.00),
(13, 'Martech', 50.00);

-- Creazione della tabella Clienti
CREATE TABLE Clienti (
IDCliente INT NOT NULL auto_increment,
Nome VARCHAR(50),
Email VARCHAR(100),
PRIMARY KEY(IDCliente));

-- Inserimento dei dati nella tabella Clienti
INSERT INTO Clienti (IDCliente, Nome, Email) VALUES
(1, 'Antonio', NULL),
(2, 'Battista', 'battista@mailmail.it'),
(3, 'Maria', 'maria@posta.it'),
(4, 'Franca', 'franca@lettere.it'),
(5, 'Ettore', NULL),
(6, 'Arianna', 'arianna@posta.it'),
(7, 'Piero', 'piero@lavoro.it');

-- Creazione della tabella Ordini
CREATE TABLE Ordini (
    IDOrdine INT NOT NULL auto_increment,
    IDProdotto INT,
    IDCliente INT,
    Quantità INT,
    PRIMARY KEY(IDOrdine),
    FOREIGN KEY (IDProdotto) REFERENCES Prodotti(IDProdotto),
    FOREIGN KEY (IDCliente) REFERENCES Clienti(IDCliente));

-- Inserimento dei dati nella tabella Ordini
INSERT INTO Ordini (IDOrdine, IDProdotto, IDCliente, Quantità) VALUES
(1, 2, 1, 10),
(2, 6, 2, 2),
(3, 4, 3, 5),
(4, 9, 1, 1),
(5, 11, 6, 4),
(6, 10, 2, 2),
(7, 3, 3, 3),
(8, 1, 4, 1),
(9, 2, 5, 3),
(10, 1, 6, 2),
(11, 2, 7, 1);

-- Creazione della tabella DettaglioOrdine (Bonus)
CREATE TABLE DettaglioOrdine (
    IDOrdine INT,
    IDProdotto INT,
    IDCliente INT,
    PrezzoTotale DECIMAL(10, 2),
    PRIMARY KEY (IDOrdine, IDProdotto, IDCliente),
    FOREIGN KEY (IDOrdine) REFERENCES Ordini(IDOrdine),
    FOREIGN KEY (IDProdotto) REFERENCES Prodotti(IDProdotto),
    FOREIGN KEY (IDCliente) REFERENCES Clienti(IDCliente));
    
SELECT * FROM Prodotti;
SELECT * FROM Clienti;
SELECT * FROM Ordini;


-- Calcolo del PrezzoTotale
SELECT d.IDOrdine, d.IDProdotto, d.IDCliente, 
    (o.Quantità * p.Prezzo) AS PrezzoTotale
FROM DettaglioOrdine d
JOIN Ordini o ON d.IDOrdine = o.IDOrdine
JOIN Prodotti p ON d.IDProdotto = p.IDProdotto;


-- Inserisci dati nella tabella DettaglioOrdine
INSERT INTO DettaglioOrdine (IDOrdine, IDProdotto, IDCliente, PrezzoTotale) SELECT
ord.IDOrdine,
ord.IDProdotto,
ord.IDCliente,
prd.prezzo * ord.quantità as PrezzoTotale
FROM Ordini ord JOIN Prodotti prd ON ord.IDProdotto = prd.IDProdotto

-- SELECT * FROM DettaglioOrdine;

