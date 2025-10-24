--BDR Aula 13

DROP TABLE IF EXISTS reservatorio CASCADE;
DROP TABLE IF EXISTS parametro CASCADE;
DROP TABLE IF EXISTS serie_temporal CASCADE;

CREATE TABLE IF NOT EXISTS reservatorio(
    id_reservatorio INT PRIMARY KEY,
    nome VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS parametro(
    id_parametro INT PRIMARY KEY,
    nome_parametro VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS serie_temporal(
    id_serie INT PRIMARY KEY,
    id_reservatorio INT REFERENCES reservatorio(id_reservatorio),
    id_parametro INT REFERENCES parametro(id_parametro),
    valor DECIMAL
);

INSERT INTO reservatorio(id_reservatorio, nome) VALUES
(1, 'Jaguari'),
(2, 'Paraibuna'),
(3, 'Cachoeira do França'),
(4, 'Santa Branca');

INSERT INTO parametro(id_parametro, nome_parametro) VALUES
(1, 'pH'),
(2, 'Oxigênio Dissolvido'),
(3, 'Temperatura');

INSERT INTO serie_temporal(id_serie, id_reservatorio, id_parametro, valor) VALUES
(1, 1, 1, 7.2),
(2, 1, 2, 8.5),
(3, 2, 1, 6.9),
(4, 3, 3, 24.0),
(5, 4, 2, 9.1);

-- Passo 1: Conferir os parâmetros disponíveis

SELECT * FROM parametro;

-- Passo 2: Rodar a subconsulta isolada

SELECT s.id_reservatorio
FROM serie_temporal s
INNER JOIN parametro p ON s.id_parametro = p.id_parametro
WHERE p.nome_parametro = 'Oxigênio Dissolvido';

-- Passo 3: Rodar a query completa com IN

SELECT r.nome AS reservatorio
FROM reservatorio r
WHERE r.id_reservatorio IN (
    SELECT s.id_reservatorio
    FROM serie_temporal s
    INNER JOIN parametro p ON s.id_parametro = p.id_parametro
    WHERE p.nome_parametro = 'Oxigênio Dissolvido'
);

-- Passo 4: Reescrever usando EXISTS

SELECT r.nome AS reservatorio
FROM reservatorio r
WHERE EXISTS (
SELECT 1
FROM serie_temporal s
INNER JOIN parametro p ON s.id_parametro = p.id_parametro
WHERE s.id_reservatorio = r.id_reservatorio
AND p.nome_parametro = 'Oxigênio Dissolvido'
);

-- Passo 5: Comparar desempenho

-- Exists
EXPLAIN ANALYZE
SELECT r.nome AS reservatorio
FROM reservatorio r
WHERE EXISTS (
    SELECT 1
    FROM serie_temporal s
    INNER JOIN parametro p ON s.id_parametro = p.id_parametro
    WHERE s.id_reservatorio = r.id_reservatorio
    AND p.nome_parametro = 'Oxigênio Dissolvido'
);

-- IN
EXPLAIN ANALYZE
SELECT r.nome AS reservatorio
FROM reservatorio r
WHERE r.id_reservatorio IN (
    SELECT s.id_reservatorio
    FROM serie_temporal s
    INNER JOIN parametro p ON s.id_parametro = p.id_parametro
    WHERE p.nome_parametro = 'Oxigênio Dissolvido'
);