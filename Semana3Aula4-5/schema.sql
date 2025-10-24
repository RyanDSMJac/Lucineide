-- Aula 4

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
