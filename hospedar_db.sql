-- SGBD: MYSQL

--  1. Criação do esquema de banco de dados para o sistema de gerenciamento

CREATE SCHEMA IF NOT EXISTS hospedar_db;
USE hospedar_db;
SET SQL_SAFE_UPDATES = 0;

--  2. Criação das tabelas "Hotel", "Quarto", "Cliente" e "Hospedagem" com as colunas especificadas

CREATE TABLE IF NOT EXISTS  Hotel
(
	hotel_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(80) NOT NULL,
    cidade VARCHAR(120) NOT NULL,
    uf VARCHAR(2) NOT NULL,
    classificacao INT NOT NULL
);


CREATE TABLE IF NOT EXISTS  Quarto
(
	quarto_id INT PRIMARY KEY AUTO_INCREMENT,
    hotel_id INT NOT NULL,
    numero INT NOT NULL,
    tipo VARCHAR(25) NOT NULL,
    preco_diaria DECIMAL NOT NULL,
    FOREIGN KEY (hotel_id) REFERENCES Hotel(hotel_id)
);


CREATE TABLE IF NOT EXISTS  Cliente
(
	cliente_id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(120) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    cpf VARCHAR(15) UNIQUE NOT NULL
);


CREATE TABLE IF NOT EXISTS  Hospedagem
(
	hospedagem_id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT NOT NULL,
    quarto_id INT NOT NULL,
    dt_checkin DATE NOT NULL,
    dt_checkout DATE NOT NULL,
    Valor_total_hosp FLOAT NOT NULL,
    status_hosp VARCHAR(30) NOT NULL,
    
    FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id),
    FOREIGN KEY (quarto_id) REFERENCES Quarto(quarto_id)
    
);

-- Conclusão da criação das tabelas

--  3. Inserção de dados artificiais nas tabelas "Hotel" (2 hotéis), "Quarto"(5 para cada hotel)
-- "Cliente"(3 clientes) e "Hospedagem" (20 hospedagens, 5 para cada um dos “Status_hosp”) 
-- para simular hotéis, quartos, clientes e hospedagens

-- INSERÇÂO NA TABELA HOTEL
INSERT INTO Hotel (nome, cidade, uf, classificacao) VALUES
('Hotel LUX', 'São Paulo', 'SP', 5),
('Hotel SOL', 'Rio de Janeiro', 'RJ', 4);

-- INSERÇÂO NA TABELA QUARTO

INSERT INTO Quarto (hotel_id, numero, tipo, preco_diaria) VALUES
(1, 101, 'Simples', 200.00),
(1, 102, 'Duplo', 300.00),
(1, 103, 'Luxo', 500.00),
(1, 104, 'Presidencial', 1000.00),
(1, 105, 'Simples', 200.00),
(2, 201, 'Simples', 180.00),
(2, 202, 'Duplo', 280.00),
(2, 203, 'Luxo', 480.00),
(2, 204, 'Presidencial', 950.00),
(2, 205, 'Simples', 180.00);

-- INSERÇÂO NA TABELA CLIENTE
INSERT INTO Cliente (nome, email, telefone, cpf) VALUES
('Sandra Oliveira', 'sandra_ol@gmail.com', '1111111111', '111.111.111-11'),
('Pedro Santos', 'santos_ped@gmail.com', '2222222222', '222.222.222-22'),
('Marques Junior ALex', 'junior_alex@gmail.com', '3333333333', '333.333.333-33');

-- INSERÇÂO NA TABELA HOSPEDAGEM

INSERT INTO Hospedagem (cliente_id, quarto_id, dt_checkin, dt_checkout, Valor_total_hosp, status_hosp) VALUES

(1, 1, '2023-01-01', '2023-01-05', 800.00, 'reserva'),
(2, 3, '2023-02-01', '2023-02-05', 1200.00, 'reserva'),
(3, 6, '2023-03-01', '2023-03-05', 2000.00, 'reserva'),
(1, 4, '2023-04-01', '2023-04-05', 4000.00, 'reserva'),
(2, 5, '2023-05-01', '2023-05-05', 800.00, 'reserva'),

(2, 2, '2023-01-01', '2023-01-03', 360.00, 'finalizada'),
(1, 4, '2023-02-01', '2023-02-03', 560.00, 'finalizada'),
(2, 8, '2023-03-01', '2023-03-03', 960.00, 'finalizada'),
(3, 5, '2023-04-01', '2023-04-03', 1900.00, 'finalizada'),
(2, 10, '2023-05-01', '2023-05-03', 360.00, 'finalizada'),

(2, 7, '2023-06-01', '2023-06-05', 800.00, 'hospedado'),
(2, 5, '2023-07-01', '2023-07-05', 1200.00, 'hospedado'),
(3, 9, '2023-08-01', '2023-08-05', 2000.00, 'hospedado'),
(1, 6, '2023-09-01', '2023-09-05', 4000.00, 'hospedado'),
(3, 1, '2023-10-01', '2023-10-05', 800.00, 'hospedado'),

(1, 2, '2023-06-01', '2023-06-05', 720.00, 'cancelada'),
(2, 5, '2023-07-01', '2023-07-05', 1120.00, 'cancelada'),
(3, 7, '2023-08-01', '2023-08-05', 1920.00, 'cancelada'),
(1, 2, '2023-09-01', '2023-09-05', 3800.00, 'cancelada'),
(1, 9, '2023-10-01', '2023-10-05', 720.00, 'cancelada');

-- Conclusão da inserção

 -- 4. ESCREVA AS SEGUINTES CONSULTAS E COMANDOS SQL:
 
 -- a. Listar todos os hotéis e seus respectivos quartos, apresentando os seguintes campos: para hotel, nome e cidade; para quarto, tipo e preco_diaria;
 
SELECT
    Hotel.nome AS 'Nome do hotel',
    Hotel.cidade AS 'Cidade',
    Quarto.tipo AS 'Tipo do quarto',
    Quarto.preco_diaria 'Preço diária'
FROM
    Hotel
JOIN
    Quarto ON Hotel.hotel_id = Quarto.hotel_id;
 
 -- b.  Listar todos os clientes que já realizaram hospedagens (status_hosp igual á “finalizada”), e os respectivos quartos e hotéis
 
SELECT 
	cliente.nome AS 'Nome do cliente', 
    hospedagem.status_hosp AS 'Status', 
    quarto.numero AS 'Número do quarto', 
    hotel.nome AS 'Nome do hotel',
    hotel.cidade AS 'Cidade'
 FROM cliente
	JOIN hospedagem 
		ON cliente.cliente_id = hospedagem.cliente_id
	JOIN quarto
		ON quarto.quarto_id = hospedagem.quarto_id
	JOIN hotel
		ON quarto.hotel_id = hotel.hotel_id
WHERE status_hosp = 'finalizada';
 
 -- c.  Mostrar o histórico de hospedagens em ordem cronológica de um determinado cliente;
 
SELECT
	cliente.nome AS 'Nome do cliente',
    hospedagem.dt_checkin AS 'Check-in',
    hospedagem.dt_checkout AS 'Check-out',
    hospedagem.valor_total_hosp AS 'Valor da hospedagem',
    hospedagem.status_hosp AS 'Status'
 FROM cliente
	JOIN hospedagem
		ON hospedagem.cliente_id = cliente.cliente_id
 WHERE cliente.cliente_id = 2 AND (hospedagem.status_hosp = 'hospedado' OR hospedagem.status_hosp = 'finalizada')
 ORDER BY hospedagem.dt_checkin ASC;
    
 -- d.  Apresentar o cliente com maior número de hospedagens (não importando o tempo em que ficou hospedado);
 
 SELECT
    cliente.cliente_id,
    cliente.nome,
    COUNT(hospedagem.hospedagem_id) AS total_hospedagens
FROM
    Hospedagem
JOIN
    Cliente ON Hospedagem.cliente_id = Cliente.cliente_id
WHERE 
	hospedagem.status_hosp = 'finalizada'
GROUP BY
    Cliente.cliente_id, Cliente.nome
ORDER BY
    total_hospedagens DESC
LIMIT 1;

 
 -- e.  Apresentar clientes que tiveram hospedagem “cancelada”, os respectivos quartos e hotéis.
SELECT
    Cliente.nome AS 'Nome do cliente',
    quarto.numero AS 'Número do quarto',
    quarto.tipo AS 'Tipo do quarto',
    hotel.nome AS 'Nome do hotel',
    hotel.cidade,
    hotel.uf,
    hospedagem.status_hosp AS 'Status da hospedagem'
FROM
    hospedagem
JOIN
    Cliente ON Hospedagem.cliente_id = Cliente.cliente_id
JOIN
    Quarto ON Hospedagem.quarto_id = Quarto.quarto_id
JOIN
    Hotel ON Quarto.hotel_id = Hotel.hotel_id
WHERE
    Hospedagem.status_hosp = 'cancelada';

 -- f.  Calcular a receita de todos os hotéis (hospedagem com status_hosp igual a “finalizada”), ordenado de forma decrescente;
 
 SELECT
	hotel.nome,
    hotel.hotel_id,
	SUM(Hospedagem.valor_total_hosp) AS receita_total
 FROM 
	Hospedagem
    JOIN 
		quarto ON Hospedagem.quarto_id = quarto.quarto_id
	JOIN 
		hotel ON quarto.hotel_id = hotel.hotel_id
 WHERE 
	Hospedagem.status_hosp = 'finalizada'
 GROUP BY 
	hotel.nome, hotel.hotel_id
 ORDER BY
    receita_total DESC;
 
 -- g.  Listar todos os clientes que já fizeram uma reserva em um hotel específico;
 SELECT DISTINCT
    Cliente.cliente_id,
    Cliente.nome,
    Cliente.cpf
FROM
    Hospedagem
JOIN
    Cliente ON Hospedagem.cliente_id = Cliente.cliente_id
JOIN
    Quarto ON Hospedagem.quarto_id = Quarto.quarto_id
WHERE
    Hospedagem.status_hosp = 'reserva' AND
    Quarto.hotel_id = 1;

 
 -- h.  Listar o quanto cada cliente que gastou em hospedagens (status_hosp igual a “finalizada”), em ordem decrescente por valor gasto.
 SELECT
    Cliente.cliente_id,
    Cliente.nome,
    SUM(Hospedagem.Valor_total_hosp) AS total_gasto
FROM
    Hospedagem
JOIN
    Cliente ON Hospedagem.cliente_id = Cliente.cliente_id
WHERE
    Hospedagem.status_hosp = 'finalizada'
GROUP BY
    Cliente.cliente_id, Cliente.nome, Cliente.email
ORDER BY
    total_gasto DESC;

 
 -- i.  Listar todos os quartos que ainda não receberam hóspedes.
 SELECT
    Quarto.quarto_id,
    Quarto.numero,
    Quarto.tipo,
    Quarto.preco_diaria,
    Hotel.nome AS nome_hotel,
    Hotel.cidade,
    Hotel.uf
FROM
    Quarto
LEFT JOIN
    Hospedagem ON Quarto.quarto_id = Hospedagem.quarto_id
LEFT JOIN
    Hotel ON Quarto.hotel_id = Hotel.hotel_id
WHERE
    Hospedagem.quarto_id IS NULL;

 
 -- j.  Apresentar a média de preços de diárias em todos os hotéis, por tipos de quarto.
 
SELECT
    Quarto.tipo,
    AVG(Quarto.preco_diaria) AS media_preco_diaria
FROM
    Quarto
GROUP BY
    Quarto.tipo;

 -- l.  Criar a coluna checkin_realizado do tipo booleano na tabela Hospedagem (via código). E atribuir verdadeiro para as Hospedagens com status_hosp “finalizada” e “hospedado”, e como falso para Hospedagens com status_hosp “reserva” e “cancelada”.
 
ALTER TABLE Hospedagem
ADD COLUMN checkin_realizado BOOLEAN;

DESC Hospedagem;

UPDATE Hospedagem
SET checkin_realizado = TRUE
WHERE status_hosp IN ('finalizada', 'hospedado');

UPDATE Hospedagem
SET checkin_realizado = FALSE
WHERE status_hosp IN ('reserva', 'cancelada');

 -- m.  Mudar o nome da coluna “classificacao” da tabela Hotel para “ratting” (via código).
ALTER TABLE Hotel
CHANGE COLUMN classificacao ratting INT;

DESC Hotel;

 -- ----------------------------------------------------------------------------------------------------------
 
-- 5. CRIAÇÃO DE PROCEDIMENTOS USANDO PL/MYSQL:

-- a. Criação de uma procedure chamada "RegistrarCheckIn" que aceita hospedagem_id e data_checkin como parâmetros. 
-- A procedure deve atualizar a data de check-in na tabela "Hospedagem" e mudar o status_hosp para "hospedado".

DELIMITER //
CREATE PROCEDURE RegistrarCheckIn(IN p_hospedagem_id INT, IN p_data_checkin DATE)
BEGIN
    UPDATE Hospedagem
    SET
        dt_checkin = p_data_checkin,
        status_hosp = 'hospedado',
        checkin_realizado = true
    WHERE
        hospedagem_id = p_hospedagem_id;
END //

DELIMITER ;

 -- b. Criação de uma procedure chamada "CalcularTotalHospedagem" que aceita hospedagem_id como parâmetro.
 -- A procedure deve calcular o valor total da hospedagem com base na diferença de dias entre check-in e
 -- check-out e o preço da diária do quarto reservado. O valor deve ser atualizado na coluna valor_total_hosp .
 
DELIMITER //
CREATE PROCEDURE CalcularTotalHospedagem(IN p_hospedagem_id INT)
BEGIN
    DECLARE v_dt_checkin DATE;
    DECLARE v_dt_checkout DATE;
    DECLARE v_preco_diaria DECIMAL(10, 2);
    DECLARE v_dias INT;
    DECLARE v_valor_total DECIMAL(10, 2);

    -- Obter as datas de check-in e check-out e o preço da diária
    SELECT
        dt_checkin,
        dt_checkout,
        Quarto.preco_diaria
    INTO
        v_dt_checkin,
        v_dt_checkout,
        v_preco_diaria
    FROM
        Hospedagem
    JOIN
        Quarto ON Hospedagem.quarto_id = Quarto.quarto_id
    WHERE
        hospedagem_id = p_hospedagem_id;

    -- Calcular a diferença de dias entre check-in e check-out
    SET v_dias = DATEDIFF(v_dt_checkout, v_dt_checkin);

    -- Calcular o valor total da hospedagem
    SET v_valor_total = v_dias * v_preco_diaria;

    -- Atualizar o valor total da hospedagem na tabela Hospedagem
    UPDATE Hospedagem
    SET valor_total_hosp = v_valor_total
    WHERE hospedagem_id = p_hospedagem_id;
END //

DELIMITER ;

-- c. Criação uma procedure chamada "RegistrarCheckout" que aceita hospedagem_id e data_checkout como parâmetros. 
-- A procedure deve atualizar a data de check-out na tabela "Hospedagem" e mudar o status_hosp para "finalizada". 

DELIMITER //
CREATE PROCEDURE RegistrarCheckout(IN p_hospedagem_id INT, IN p_data_checkout DATE)
BEGIN
    UPDATE Hospedagem
    SET
        dt_checkout = p_data_checkout,
        status_hosp = 'finalizada'
    WHERE
        hospedagem_id = p_hospedagem_id;
END //

DELIMITER ;

-- ------------------------------------------------------------------------------------------------------------------

-- 6. CRIAÇÃO DE FUNÇÕES UTILIZANDO PL/MYSQL:

-- a. Criação de uma function chamada "TotalHospedagensHotel" que aceita hotel_id como parâmetro. 
-- A função deve retornar o número total de hospedagens realizadas em um determinado hotel. 

DELIMITER //
CREATE FUNCTION TotalHospedagensHotel(p_hotel_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_total_hospedagens INT;
    
    SELECT COUNT(*) INTO v_total_hospedagens
    FROM Hospedagem
    JOIN Quarto ON Hospedagem.quarto_id = Quarto.quarto_id
    WHERE Quarto.hotel_id = p_hotel_id;
    
    RETURN v_total_hospedagens;
END //

DELIMITER ;

-- b. Criar uma function chamada "ValorMedioDiariasHotel" que aceita hotel_id como parâmetro. 
-- A função deve calcular e retornar o valor médio das diárias dos quartos deste hotel.

DELIMITER //
CREATE FUNCTION ValorMedioDiariasHotel(p_hotel_id INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE v_valor_medio DECIMAL(10, 2);
    
    SELECT AVG(preco_diaria) INTO v_valor_medio
    FROM Quarto
    WHERE hotel_id = p_hotel_id;
    
    RETURN v_valor_medio;
END //

DELIMITER ;

-- c. Criar uma function chamada "VerificarDisponibilidadeQuarto" que aceita quarto_id e data como parâmetros. 
-- A função deve retornar um valor booleano indicando se o quarto está disponível ou não para reserva na data especificada.

DELIMITER //
CREATE FUNCTION VerificarDisponibilidadeQuarto(p_quarto_id INT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE esta_disponivel BOOLEAN;
    
    SELECT checkin_realizado INTO esta_disponivel
    FROM hospedagem
    WHERE hospedagem.quarto_id = p_quarto_id
    LIMIT 1;
    RETURN esta_disponivel;
END //

DELIMITER ;

-- -----------------------------------------------------------------------------------------------------------------

-- 7. CRIAÇÃO DE TRIGGERS UTILIZANDO PL/MYSQL:

 -- a. Criar um trigger chamado "AntesDeInserirHospedagem" que é acionado antes de uma inserção na tabela "Hospedagem". 
 -- O trigger deve verificar se o quarto está disponível na data de check-in. Se não estiver, a inserção deve ser cancelada.
 
DELIMITER //
CREATE TRIGGER AntesDeInserirHospedagem
BEFORE INSERT ON Hospedagem
FOR EACH ROW
BEGIN
    DECLARE v_contagem INT;
    
    -- Verifica se o quarto está ocupado na data de check-in
    SELECT COUNT(*) INTO v_contagem
    FROM Hospedagem
    WHERE quarto_id = NEW.quarto_id
      AND status_hosp IN ('hospedado', 'reserva')
      AND (NEW.dt_checkin BETWEEN dt_checkin AND dt_checkout
           OR NEW.dt_checkout BETWEEN dt_checkin AND dt_checkout
           OR NEW.dt_checkin <= dt_checkin AND NEW.dt_checkout >= dt_checkout);

    -- Se o quarto estiver ocupado, cancelar a inserção
    IF v_contagem > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'O quarto não está disponível na data de check-in.';
    END IF;
END //

DELIMITER ;

 -- b. Cria um trigger chamado "AposDeletarCliente" que é acionado após a exclusão de um cliente na tabela "Cliente". 
 -- O trigger deve registrar a exclusão em uma tabela de log.
 
 CREATE TABLE ClienteLog (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    nome VARCHAR(120),
    email VARCHAR(150),
    telefone VARCHAR(15),
    cpf VARCHAR(15),
    data_exclusao DATETIME
);


DELIMITER //
CREATE TRIGGER AposDeletarCliente
AFTER DELETE ON Cliente
FOR EACH ROW
BEGIN
    INSERT INTO ClienteLog (cliente_id, nome, email, telefone, cpf, data_exclusao)
    VALUES (OLD.cliente_id, OLD.nome, OLD.email, OLD.telefone, OLD.cpf, NOW());
END //

DELIMITER ;


-- -----------------------------------------------------------------------------------------------------------

-- TESTES DOS PROCEDIMENTOS

CALL RegistrarCheckIn(2, '2024-03-03');
CALL RegistrarCheckout(2, '2024-03-04');
CALL CalcularTotalHospedagem(2);
SELECT * FROM Hospedagem WHERE hospedagem_id = 2;

SELECT * FROM Hospedagem;

-- TESTES DAS FUNÇÕES
SELECT TotalHospedagensHotel(2) AS total_hospedagens;
SELECT VerificarDisponibilidadeQuarto(2) AS 'Está disponível';

-- TESTES DOS TRIGGERS

-- Tenta inserir uma hospedagem em um quarto já ocupado
INSERT INTO Hospedagem (cliente_id, quarto_id, dt_checkin, dt_checkout, Valor_total_hosp, status_hosp)
VALUES (1, 1, '2024-07-01', '2024-07-10', 2000, 'reserva');

-- Adicione um cliente
INSERT INTO Cliente (nome, email, telefone, cpf)
VALUES ('Novo Cliente', 'novocliente@example.com', '1234567890', '999.999.999-99');

-- Exclui o cliente adicionado
DELETE FROM Cliente WHERE cliente_id = 4;

-- Verifica a tabela de log
SELECT * FROM ClienteLog;
