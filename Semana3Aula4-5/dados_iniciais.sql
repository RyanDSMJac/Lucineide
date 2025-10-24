-- Aula 5

DROP TABLE IF EXISTS Usuario CASCADE;
DROP TABLE IF EXISTS Localizacao CASCADE;
DROP TABLE IF EXISTS TipoEvento CASCADE;
DROP TABLE IF EXISTS Evento CASCADE;
DROP TABLE IF EXISTS Relato CASCADE;
DROP TABLE IF EXISTS Alerta CASCADE;
DROP TABLE IF EXISTS CategoriaUsuario CASCADE;

CREATE TABLE IF NOT EXISTS Usuario(
	idUsuario INT PRIMARY KEY,
	nomeUsuario VARCHAR(255),
	emailUsuario VARCHAR(255),
	senhaHash TEXT
);

CREATE TABLE IF NOT EXISTS Localizacao(
	idLocalizacao INT PRIMARY KEY,
	Latitude TEXT,
	Longitude TEXT,
	cidadeLocal VARCHAR(255),
	estadoLocal VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS TipoEvento(
	idTipoEvento INT PRIMARY KEY,
	nomeTE VARCHAR(255),
	descricaoTE TEXT
);

CREATE TABLE IF NOT EXISTS Evento(
	idEvento INT PRIMARY KEY,
	nomeEvento VARCHAR(255),
	descricaoEvento TEXT,
	dataHora TIMESTAMP,
	status VARCHAR(255) CHECK (status IN ('Ativo', 'Em monitoramento', 'Finalizado')),
	idTipoEvento INT REFERENCES TipoEvento(idTipoEvento),
	idLocalizacao INT REFERENCES Localizacao(idLocalizacao)
);

CREATE TABLE IF NOT EXISTS Relato(
	idRelato INT PRIMARY KEY,
	relato TEXT,
	dataHora TIMESTAMP,
	idEvento INT REFERENCES Evento(idEvento),
	idUsuario INT REFERENCES Usuario(idUsuario)
);

CREATE TABLE IF NOT EXISTS Alerta(
	idAlerta INT PRIMARY KEY,
	msg TEXT,
	dataHora TIMESTAMP,
	NivelAlerta INT,
	idEvento INT REFERENCES Evento(idEvento)
);

CREATE TABLE IF NOT EXISTS CategoriaUsuario(
	idCategoriaUsuario INT PRIMARY KEY,
	nomeCategoria VARCHAR(255),
	DescricaoCategoria TEXT,
	idUsuario INT REFERENCES Usuario(idUsuario)
);

INSERT INTO Usuario(idUsuario, nomeUsuario, emailUsuario, senhaHash) VALUES
(1, 'João', 'joao@gmail.com', 'w23r90'),
(2, 'Maria', 'maria@gmail.com', '9f23nt'),
(3, 'Pedro', 'pedro@gmail.com', 'qh83bd');

INSERT INTO Localizacao(idLocalizacao, Latitude, Longitude, cidadeLocal, estadoLocal) VALUES
(1, '-23.5489', '-46.6388', 'São Paulo', 'São Paulo'),
(2, '-22.9035', '-43.2096', 'Rio de Janeiro', 'Rio de Janeiro'),
(3, '-19.8157', '-43.9542', 'Belo Horizonte', 'Minas Gerais');

INSERT INTO TipoEvento(idTipoEvento, nomeTE, descricaoTE) VALUES
(1, 'Queimada', 'Grande quantidade de fogo'),
(2, 'Inundação', 'Acúmulo de água gigante'),
(3, 'Deslizamento', 'Deslizamento de terra');

INSERT INTO Evento(idEvento, nomeEvento, descricaoEvento, dataHora, status, idTipoEvento, idLocalizacao) VALUES
(1, 'Incêndio na Zona Sul', 'Grande incêndio em São Paulo', '2025-10-25 14:30:00', 'Ativo', 1, 1),
(2, 'Alagamento em Copacabana', 'Várias ruas inundadas devido à forte chuva', '2025-10-24 18:00:00', 'Em monitoramento', 2, 2),
(3, 'Deslizamento em BH', 'Deslizamento de terra em Belo Horizonte', '2025-10-23 10:00:00', 'Finalizado', 3, 3);

INSERT INTO Relato(idRelato, relato, dataHora, idEvento, idUsuario) VALUES
(1, 'Incêndio avistado aqui na zona sul', '2025-10-25 14:35:00', 1, 1),
(2, 'A situação está horrível, as ruas estão cobertas de água.', '2025-10-24 18:05:00', 2, 2),
(3, 'O deslizamento está um caos.', '2025-10-23 10:15:00', 3, 3);

INSERT INTO Alerta(idAlerta, msg, dataHora, NivelAlerta, idEvento) VALUES
(1, 'Alerta de incêndio. Evacue a área imediatamente.', '2025-10-25 14:40:00', 3, 1),
(2, 'Risco de mais chuvas. Alagamento severo em Copacabana.', '2025-10-24 18:10:00', 2, 2),
(3, 'Deslizamento de terra. Evacuação urgente.', '2025-10-23 10:20:00', 3, 3);

INSERT INTO CategoriaUsuario(idCategoriaUsuario, nomeCategoria, DescricaoCategoria, idUsuario) VALUES
(1, 'Administrador', 'Usuário com acesso total a todas as informações.', 1),
(2, 'Usuário Comum', 'Usuário com acesso restrito a determinadas funcionalidades.', 2),
(3, 'Voluntário', 'Usuário com permissão para ajudar em ações de resgates e apoio.', 3);

SELECT * FROM Usuario;
SELECT * FROM Localizacao;
SELECT * FROM Relato WHERE idRelato = 1;
SELECT * FROM Alerta WHERE idEvento = 2;