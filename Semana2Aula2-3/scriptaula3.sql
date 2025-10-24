DROP TABLE IF EXISTS autor CASCADE;
DROP TABLE IF EXISTS livro CASCADE;
DROP TABLE IF EXISTS aluno CASCADE;
DROP TABLE IF EXISTS emprestimo CASCADE;

-- Tabela Autor
CREATE TABLE autor (
id_autor SERIAL PRIMARY KEY,
nome VARCHAR(100) NOT NULL
);

-- Tabela Livro
CREATE TABLE livro (
id_livro SERIAL PRIMARY KEY,
titulo VARCHAR(150) NOT NULL,
ano_publicacao INT,
id_autor INT REFERENCES autor(id_autor)
);

-- Tabela Aluno
CREATE TABLE aluno (
id_aluno SERIAL PRIMARY KEY,
nome VARCHAR(100) NOT NULL,
curso VARCHAR(100) NOT NULL
);

-- Tabela empréstimo
CREATE TABLE emprestimo (
id_emprestimo INT PRIMARY KEY,
data_emprestimo DATE,
id_aluno INT REFERENCES aluno(id_aluno)
);


-- Autores
INSERT INTO autor (nome) VALUES
('J. R. R. Tolkien'),
('Machado de Assis'),
('Clarice Lispector');

-- Livros
INSERT INTO livro (titulo, ano_publicacao,
id_autor) VALUES
('O Senhor dos Anéis', 1954, 1),
('Dom Casmurro', 1899, 2),
('A Hora da Estrela', 1977, 3),
('O Hobbit', 1937, 1);

-- Alunos
INSERT INTO aluno (nome, curso) VALUES
('Maria', 'Desenvolvimento Web'),
('João', 'Engenharia de Software');

-- Empréstimos
INSERT INTO emprestimo (data_emprestimo,
id_aluno, id_emprestimo) VALUES
('2025-08-20', 1, 1),
('2025-08-21', 2, 2);

SELECT * FROM autor;
SELECT * FROM livro;
SELECT * FROM aluno;
SELECT * FROM emprestimo;