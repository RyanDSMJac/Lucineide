-- 1. Criaçãp do banco e acesso
CREATE DATABASE rede_games;

-- 2. Criação das tabelas

DROP TABLE IF EXISTS fabricante CASCADE;
DROP TABLE IF EXISTS produto CASCADE;
DROP TABLE IF EXISTS loja CASCADE;
DROP TABLE IF EXISTS venda CASCADE;

CREATE TABLE
    fabricante (
        id_fabricante SERIAL PRIMARY KEY,
        nome_fabricante VARCHAR(255) NOT NULL,
        pais VARCHAR(255)
    );

CREATE TABLE
    produto (
        id_produto SERIAL PRIMARY KEY,
        nome VARCHAR(255) NOT NULL,
        preco NUMERIC(10, 2) NOT NULL CHECK (preco > 0),
        id_fabricante INT,
        FOREIGN KEY (id_fabricante) REFERENCES fabricante (id_fabricante)
    );

CREATE TABLE
    loja (
        id_loja SERIAL PRIMARY KEY,
        nome_loja VARCHAR(255) NOT NULL,
        cidade VARCHAR(255) NOT NULL
    );

CREATE TABLE
    venda (
        id_venda SERIAL PRIMARY KEY,
        id_produto INT NOT NULL,
        id_loja INT NOT NULL,
        quantidade INT NOT NULL CHECK (quantidade > 0),
        data_venda DATE NOT NULL,
        FOREIGN KEY (id_produto) REFERENCES produto (id_produto),
        FOREIGN KEY (id_loja) REFERENCES loja (id_loja)
    );

-- ==============================================
-- INSERTS: FABRICANTES (3. Pelo menos 3 fabricantes)
-- ==============================================
INSERT INTO
    fabricante (id_fabricante, nome_fabricante, pais)
VALUES
    (8, 'Ubisoft', 'França'), -- Fabricante 1
    (9, 'Nvidia', 'Estados Unidos'), -- Fabricante 2
    (10, 'Atlus', 'Japão');

-- Fabricante 3
-- ==============================================
-- INSERTS: PRODUTOS (4. Ao menos 5 produtos com ao menos 1 jogo e 1 acessório)
-- ==============================================
INSERT INTO
    produto (id_produto, nome, preco, id_fabricante)
VALUES
    (12, 'Far Cry 6', 249.99, 8), -- Produto 1
    (13, 'RTX 5090 32GB', 19699.99, 9), -- Produto 2
    (14, 'Persona 3 Reload', 299.90, 10), -- Produto 3
    (15, 'Metaphor: ReFantazio', 299.90, 10), -- Produto 4
    (16, 'Just Dance 2025 Edition', 249.99, 8);

-- Produto 5
-- ==============================================
-- INSERTS: LOJAS (5. Cadastre 3 lojas em cidades diferentes)
-- ==============================================
INSERT INTO
    loja (id_loja, nome_loja, cidade)
VALUES
    (5, 'Rede Games Jacareí', 'Jacareí'), -- Loja 1
    (6, 'Rede Games Capital', 'Brasília'), -- Loja 2
    (7, 'Rede Games Londrina', 'Londrina');

-- Loja 3
-- ==============================================
-- INSERTS: VENDAS (6. 6 vendas com quantidades variadas)
-- ==============================================
INSERT INTO
    venda (
        id_venda,
        id_produto,
        id_loja,
        quantidade,
        data_venda
    )
VALUES
    (12, 12, 7, 5, '2025-10-12'), -- Venda 1
    (13, 14, 5, 2, '2025-10-01'), -- Venda 2
    (14, 15, 5, 30, '2025-10-07'), -- Venda 3
    (15, 16, 6, 4, '2025-09-30'), -- Venda 4
    (16, 13, 7, 8, '2025-09-28'), -- Venda 5
    (17, 15, 6, 3, '2025-10-04');

-- Venda 6
-- 7. JOIN — Relatório de produtos vendidos
-- Exiba: produto, nome da loja, quantidade
SELECT
    p.nome AS produto,
    l.nome_loja,
    v.quantidade
FROM
    venda v
    JOIN produto p ON v.id_produto = p.id_produto
    JOIN loja l ON v.id_loja = l.id_loja
ORDER BY
    l.nome_loja,
    p.nome;

-- 8. GROUP BY — Total de produtos vendidos por loja
-- Exiba: nome da loja, total vendido
SELECT
    l.nome_loja,
    SUM(v.quantidade) AS total_vendido
FROM
    venda v
    JOIN loja l ON v.id_loja = l.id_loja
GROUP BY
    l.nome_loja
ORDER BY
    total_vendido DESC;

-- 9- HAVING — Lojas de alto desempenho
-- Mostre somente lojas que venderam acima de 30 unidades somadas.
-- Filtro deve ser feito no HAVING (não no WHERE)
SELECT
    l.nome_loja,
    SUM(v.quantidade) AS total_vendido
FROM
    venda v
    JOIN loja l ON v.id_loja = l.id_loja
GROUP BY
    l.nome_loja
HAVING
    SUM(v.quantidade) > 30
ORDER BY
    total_vendido DESC;

-- 10- SUBCONSULTA — Fabricantes com produtos vendidos
-- Exibir apenas nome_fabricante.
-- Usar IN OU EXISTS em subconsulta.
SELECT
    f.nome_fabricante
FROM
    fabricante f
WHERE
    f.id_fabricante IN (
        SELECT
            p.id_fabricante
        FROM
            produto p
            JOIN venda v ON p.id_produto = v.id_produto
    )
ORDER BY
    f.nome_fabricante;