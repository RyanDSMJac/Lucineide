-- questao 8

select id_cliente, nome, cidade from cliente;

-- questao 9

select titulo, ano_lancamento from jogo where ano_lancamento > 2020;

-- questao 10

select sum(quantidade) as soma_compras from compra_jogo;