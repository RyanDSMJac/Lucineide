-- questao 1

create database rede_games;

-- questao 2

drop table if exists loja cascade;
drop table if exists jogo cascade;
drop table if exists cliente cascade;
drop table if exists compra cascade;
drop table if exists compra_jogo cascade;

create table loja(
	id_loja int primary key,
	nome varchar(100),
	cidade varchar(100)
);

create table jogo(
	id_jogo int primary key,
	titulo varchar(100),
	ano_lancamento int,
	genero varchar(100)
);

create table cliente(
	id_cliente int primary key,
	nome varchar(100),
	email varchar(100) unique,
	cidade varchar(100)
);

create table compra(
	id_compra int primary key,
	data_compra timestamp,
	id_cliente int references cliente(id_cliente),
	id_loja int references loja(id_loja)
);

create table compra_jogo(
	id_compra int references compra(id_compra),
	id_jogo int references jogo(id_jogo),
	quantidade int,
	primary key (id_compra, id_jogo)
);