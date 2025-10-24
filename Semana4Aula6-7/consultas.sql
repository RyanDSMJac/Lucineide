-- Aula 7

-- Contar quantos clientes estão cadastrados no banco

SELECT COUNT(cliente) AS total_clientes FROM transacoes;

-- Calcular o saldo total armazenado no banco

SELECT SUM(saldo) AS saldo_total FROM contas;

-- Descobrir a média dos saques feitos

SELECT AVG(valor) AS media_saques FROM transacoes WHERE tipo = 'Depósito';