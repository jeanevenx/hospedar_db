CREATE PROCEDURE sp_GetDataFromA
AS
BEGIN
    -- Recuperando os dados da tabela A, verificando o tipo para cada linha
    SELECT 
        CASE 
            WHEN A.tipo = 'all' THEN
                -- Se o tipo for 'all', fazer junção com C
                (SELECT A.*, C.*, B.*
                 FROM A
                 INNER JOIN C ON A.idA = C.idA
                 INNER JOIN B ON C.idB = B.idB
                 WHERE A.idA = C.idA AND C.idB = B.idB)
            ELSE
                -- Se o tipo for diferente de 'all', fazer junção com D
                (SELECT A.*, D.*, B.*
                 FROM A
                 INNER JOIN D ON A.idA = D.idA
                 INNER JOIN B ON D.idB = B.idB
                 WHERE A.idA = D.idA AND D.idB = B.idB)
        END AS Result
    FROM A
END