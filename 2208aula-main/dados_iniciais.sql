DROP TABLE IF EXISTS tipo_evento CASCADE;
DROP TABLE IF EXISTS estado CASCADE;
DROP TABLE IF EXISTS localizacao CASCADE;
DROP TABLE IF EXISTS usuario CASCADE;
DROP TABLE IF EXISTS telefone CASCADE;
DROP TABLE IF EXISTS evento CASCADE;
DROP TABLE IF EXISTS alerta CASCADE;

-- Tabela de Tipos de Evento
CREATE TABLE tipo_evento (
id_tipo_evento SERIAL PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
descricao TEXT
);

-- Tabela de Estados
CREATE TABLE estado (
sigla_estado CHAR(2) PRIMARY KEY,
nome_estado VARCHAR(100) NOT NULL
);

-- Tabela de Localização
CREATE TABLE localizacao (
id_localizacao SERIAL PRIMARY KEY,
latitude NUMERIC(9,6) NOT NULL,
longitude NUMERIC(9,6) NOT NULL,
cidade VARCHAR(100) NOT NULL,
sigla_estado CHAR(2) NOT NULL REFERENCES
estado(sigla_estado)
);

-- Tabela de Usuários
CREATE TABLE usuario (
id_usuario SERIAL PRIMARY KEY,
nome VARCHAR(150) NOT NULL,
email VARCHAR(150) UNIQUE NOT NULL,
senha_hash VARCHAR(255) NOT NULL
);

-- Tabela de Telefones do Usuário
CREATE TABLE telefone (
id_telefone SERIAL PRIMARY KEY,
numero VARCHAR(20) NOT NULL,
id_usuario INT NOT NULL REFERENCES usuario(id_usuario)
);

-- Tabela de Eventos
CREATE TABLE evento (
id_evento SERIAL PRIMARY KEY,
titulo VARCHAR(150) NOT NULL,
descricao TEXT,
data_hora TIMESTAMP NOT NULL,
status VARCHAR(30) CHECK (status IN ('Ativo','Em Monitoramento','Resolvido')),
id_tipo_evento INT NOT NULL REFERENCES tipo_evento(id_tipo_evento),
id_localizacao INT NOT NULL REFERENCES localizacao(id_localizacao)
);

-- Tabela de Alertas
CREATE TABLE alerta (
id_alerta SERIAL PRIMARY KEY,
mensagem TEXT NOT NULL,
data_hora TIMESTAMP NOT NULL,
nivel VARCHAR(20) CHECK (nivel IN
('Baixo','Médio','Alto','Crítico')),
id_evento INT NOT NULL REFERENCES
evento(id_evento)
);

-- Seleções

SELECT * FROM tipo_evento;
SELECT * FROM estado;
SELECT * FROM localizacao;
SELECT * FROM usuario;
SELECT * FROM telefone;
SELECT * FROM evento;
SELECT * FROM alerta;
SELECT * FROM tipo_evento WHERE id_tipo_evento = 1;
SELECT * FROM estado WHERE sigla_estado = 'SP';

-- Inserção de valores

INSERT INTO tipo_evento(id_tipo_evento, nome, descricao) VALUES 
(1, 'Queimada', 'Incêndio de grandes proporções em áreas urbanas ou rurais.'), 
(2, 'Enchente', 'Alagamentos por chuvas intensas ou
transbordo'),
(3, 'Deslizamento', 'Movimento de massa em
encostas');

INSERT INTO estado (sigla_estado, nome_estado) VALUES
('SP', 'São Paulo'),
('RJ', 'Rio de Janeiro'),
('MG', 'Minas Gerais');

INSERT INTO localizacao (id_localizacao, latitude, longitude, cidade, sigla_estado) VALUES
(1, -23.305, -45.965, 'Jacareí', 'SP'),
(2, -22.785000, -43.304000, 'Duque de
Caxias', 'RJ'),
(3, -19.924500, -43.935200, 'Belo Horizonte',
'MG');

INSERT INTO usuario (id_usuario, nome, email, senha_hash) VALUES
(1, 'Maria Oliveira',
'maria.oliveira@email.com', 'hash$1'),
(2, 'João Souza', 'joao.souza@email.com',
'hash$2'),
(3, 'Ana Lima', 'ana.lima@email.com',
'hash$3');

INSERT INTO telefone (id_telefone, numero, id_usuario) VALUES
(1, '12987654321', '1'),
(2, '12987654322', '2'),
(3, '12987654323', '3');

INSERT INTO evento (id_evento, titulo, descricao, data_hora, status, id_tipo_evento, id_localizacao) VALUES
(1, 'Queimada em área de preservação', '"Fogo se alastrando na mata próxima à represa.', '2025-08-15 14:35:00', 'Ativo', 1, 1),
(2, 'Enchente em Duque de Caxias', '"Ruas alagando pela cidade.""', '2025-08-16 10:30:00', 'Ativo', 2, 2),
(3, 'Tempestade em Belo Horizonte', '"Chuva forte com raios, perigo de Deslizamento."', '2025-08-17 19:20:00', 'Ativo', 3, 3);

INSERT INTO alerta (id_alerta, mensagem, data_hora, nivel, id_evento) VALUES
(1, 'Evacuação imediata da área próxima à represa.', '2025-08-15 15:20:00', 'Crítico', 1);

-- Caso precise tirar os valores

TRUNCATE TABLE tipo_evento CASCADE;
TRUNCATE TABLE estado CASCADE;
TRUNCATE TABLE localizacao CASCADE;
TRUNCATE TABLE usuario CASCADE;
TRUNCATE TABLE telefone CASCADE;
TRUNCATE TABLE evento CASCADE;
TRUNCATE TABLE alerta CASCADE;

-- Exercícios do dia 26/08

--Inserir pelo menos 2 registros em uma tabela que dependa de outra via chave estrangeira
-- (ex.: inserir eventos que dependem de usuário e tipo_evento)

INSERT INTO evento (id_evento, titulo, descricao, data_hora, status, id_tipo_evento, id_localizacao) VALUES
(4, 'Queimada perto de Duque de Caxias', '"Área florestada perto da cidade de Duque de Caxias está sob incêndio.""', '2025-08-20 07:05:00', 'Ativo', 1, 2),
(5, 'Enchente em Belo Horizonte', '"Alagamento nas ruas de Belo Horizonte."', '2025-08-21 02:39:00', 'Ativo', 2, 3);

-- Criar uma consulta que ordene registros de uma tabela (ex.: eventos por data_hora.)

SELECT data_hora FROM evento ORDER BY data_hora DESC;

-- Criar uma consulta que use ORDER BY + LIMIT (ex.: os 3 eventos mais recentes).

SELECT * FROM evento ORDER BY data_hora DESC LIMIT 3;
