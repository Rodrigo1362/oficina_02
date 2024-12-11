CREATE DATABASE oficina;
use oficina;

CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    telefone VARCHAR(15),
    endereco TEXT
);

CREATE TABLE Veiculos (
    id_veiculo INT PRIMARY KEY AUTO_INCREMENT,
    placa VARCHAR(10),
    modelo VARCHAR(50),
    ano INT,
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
);

CREATE TABLE Mecanicos (
    id_mecanico INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    especialidade VARCHAR(50),
    endereco TEXT
);

CREATE TABLE Equipes (
    id_equipe INT PRIMARY KEY AUTO_INCREMENT,
    nome_equipe VARCHAR(50)
);

CREATE TABLE Equipe_Mecanicos (
    id_equipe INT,
    id_mecanico INT,
    PRIMARY KEY (id_equipe, id_mecanico),
    FOREIGN KEY (id_equipe) REFERENCES Equipes(id_equipe),
    FOREIGN KEY (id_mecanico) REFERENCES Mecanicos(id_mecanico)
);

CREATE TABLE Ordens_de_Servico (
    id_os INT PRIMARY KEY AUTO_INCREMENT,
    data_emissao DATE,
    valor_total DECIMAL(10, 2),
    status VARCHAR(20),
    data_conclusao DATE,
    id_veiculo INT,
    id_equipe INT,
    FOREIGN KEY (id_veiculo) REFERENCES Veiculos(id_veiculo),
    FOREIGN KEY (id_equipe) REFERENCES Equipes(id_equipe)
);

CREATE TABLE Servicos (
    id_servico INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(100),
    preco_referencia DECIMAL(10, 2)
);

CREATE TABLE Itens_OS (
    id_os INT,
    id_servico INT,
    quantidade INT,
    valor_total DECIMAL(10, 2),
    PRIMARY KEY (id_os, id_servico),
    FOREIGN KEY (id_os) REFERENCES Ordens_de_Servico(id_os),
    FOREIGN KEY (id_servico) REFERENCES Servicos(id_servico)
);

-- Inserir clientes
INSERT INTO Clientes (nome, telefone, endereco) VALUES 
('João Silva', '9999-9999', 'Rua A, 123'),
('Maria Souza', '9888-8888', 'Av. B, 456');

-- Inserir veículos
INSERT INTO Veiculos (placa, modelo, ano, id_cliente) VALUES 
('ABC1234', 'Civic', 2020, 1),
('XYZ5678', 'Corolla', 2021, 2);

-- Inserir mecânicos
INSERT INTO Mecanicos (nome, especialidade, endereco) VALUES 
('Carlos Santos', 'Motor', 'Rua C, 789'),
('Ana Paula', 'Freios', 'Rua D, 101');

-- Inserir equipes
INSERT INTO Equipes (nome_equipe) VALUES 
('Equipe Alfa'),
('Equipe Beta');

-- Relacionar mecânicos às equipes
INSERT INTO Equipe_Mecanicos (id_equipe, id_mecanico) VALUES 
(1, 1),
(2, 2);

-- Inserir serviços
INSERT INTO Servicos (descricao, preco_referencia) VALUES 
('Troca de óleo', 150.00),
('Alinhamento', 200.00);

-- Inserir ordem de serviço
INSERT INTO Ordens_de_Servico (data_emissao, valor_total, status, data_conclusao, id_veiculo, id_equipe) VALUES 
('2024-12-01', 350.00, 'Concluída', '2024-12-03', 1, 1);

SELECT * FROM Clientes;

SELECT * FROM Veiculos WHERE ano > 2020;

SELECT id_os, valor_total, valor_total * 0.10 AS desconto FROM Ordens_de_Servico;

SELECT * FROM Servicos ORDER BY preco_referencia DESC;

SELECT id_equipe, SUM(valor_total) AS total_gasto
FROM Ordens_de_Servico
GROUP BY id_equipe
HAVING total_gasto > 300;

SELECT c.nome AS cliente, v.modelo AS veiculo, os.valor_total
FROM Clientes c
JOIN Veiculos v ON c.id_cliente = v.id_cliente
JOIN Ordens_de_Servico os ON v.id_veiculo = os.id_veiculo;


