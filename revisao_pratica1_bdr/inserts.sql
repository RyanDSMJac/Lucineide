-- questao 3

insert into loja(id_loja, nome, cidade) values
(1, 'Old School Games', 'Jacareí'),
(2, 'Barraca do Sonista', 'Taubaté'),
(3, 'Vale do Xbox', 'São Paulo');

-- questao 4

insert into cliente(id_cliente, nome, email, cidade) values
(1, 'João Tavares', 'joaotvres324@gmail.com', 'Jacareí'),
(2, 'Carlos Souza', 'carlos2050@gmail.com', 'Mogi das Cruzes'),
(3, 'Maria Lima', 'mlima01@gmail.com', 'São José dos Campos');

-- questao 5

insert into jogo(id_jogo, titulo, ano_lancamento, genero) values
(1, 'Hollow Knight: Silksong', 2025, 'Metroidvania'),
(2, 'Red Dead Redemption 2', 2018, 'Mundo Aberto/Ação'),
(3, 'Baldur''s Gate 3', 2023, 'RPG');

-- questao 6

insert into compra(id_compra, data_compra, id_cliente, id_loja) values
(1, '2025-09-05 20:10:03', 1, 1),
(2, '2025-09-04 14:54:00', 2, 3);

-- questao 7

insert into compra_jogo(id_compra, id_jogo, quantidade) values
(1, 1, 30),
(2, 3, 100);