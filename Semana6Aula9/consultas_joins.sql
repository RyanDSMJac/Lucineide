-- Aula 9

-- Consulta A: Escreva uma query que retorne titulo do evento e nome do tipo_evento (INNER JOIN).

select e.titulo as titulo_evento, te.nome as tipo_evento from evento e
inner join tipo_evento te on e.id_tipo_evento = te.id_tipo_evento;

-- Consulta B: Escreva uma query que retorne titulo do evento, cidade e sigla_estado (INNER JOIN evento → localizacao).


select e.titulo as titulo_evento, l.cidade, l.sigla_estado from evento e
inner join localizacao l on e.id_localizacao = l.id_localizacao;


-- Consulta C: Escreva uma query que retorne titulo do evento, tipo_evento, cidade, incluindo eventos que
-- possam não ter localizacao (usar LEFT JOIN quando necessário). Explique por que escolheu
-- LEFT/INNER.

select e.titulo as titulo_evento, te.nome as tipo_evento, l.cidade from evento e
left join tipo_evento te on e.id_tipo_evento = te.id_tipo_evento
left join localizacao l on e.id_localizacao = l.id_localizacao;

-- Consulta D: Reescreva a Consulta B usando RIGHT JOIN (invertendo a ordem das tabelas) e verifique
-- que o resultado é equivalente. Anote as diferenças de leitura/legibilidade


select e.titulo as titulo_evento, l.cidade, l.sigla_estado from evento e
right join localizacao l on e.id_localizacao = l.id_localizacao;

-- Consulta E: Crie uma query que mostre para cada cidade a quantidade de eventos (usar JOIN +
-- GROUP BY) — este exercício já prepara a Aula 11.

select l.cidade, count(e.id_evento) as quantidade_eventos from localizacao l
left join evento e on e.id_localizacao = l.id_localizacao group by l.cidade;
