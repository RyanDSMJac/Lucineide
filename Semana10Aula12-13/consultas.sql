-- pH média

select
r.nome as reservatorio,
(select avg(s.valor)
from serie_temporal s
inner join parametro p on s.id_parametro = p.id_parametro
where s.id_reservatorio = r.id_reservatorio
and p.nome_parametro = 'pH'
) as media_ph
from reservatorio r;

-- pH máximo

select r.nome,
(select max(s.valor)
from serie_temporal s
inner join parametro p on s.id_parametro = p.id_parametro
where s.id_reservatorio = r.id_reservatorio
and p.nome_parametro = 'pH'
) as ph_maximo
from reservatorio r;

-- pH mínimo

select r.nome,
(select min(s.valor)
from serie_temporal s
inner join parametro p on s.id_parametro = p.id_parametro
where s.id_reservatorio = r.id_reservatorio
and p.nome_parametro = 'pH'
) as ph_maximo
from reservatorio r;

-- Consulta junta

select
    r.nome as reservatorio,
    (select avg(s.valor)
     from serie_temporal s
     inner join parametro p on s.id_parametro = p.id_parametro
     where s.id_reservatorio = r.id_reservatorio
     and p.nome_parametro = 'pH'
    ) as media_ph,
    
    (select max(s.valor)
     from serie_temporal s
     inner join parametro p on s.id_parametro = p.id_parametro
     where s.id_reservatorio = r.id_reservatorio
     and p.nome_parametro = 'pH'
    ) as ph_maximo,
    
    (select min(s.valor)
     from serie_temporal s
     inner join parametro p on s.id_parametro = p.id_parametro
     where s.id_reservatorio = r.id_reservatorio
     and p.nome_parametro = 'pH'
    ) as ph_minimo
from reservatorio r;
