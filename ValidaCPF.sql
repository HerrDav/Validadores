-- =============================================
-- Description:	<Função validadora de CPF>
-- =============================================

CREATE OR ALTER FUNCTION ValidaCPF
(	
	@cpf VARCHAR(15)
)
RETURNS BIT 
AS
BEGIN

	DECLARE @digito1 INT, @digito2 INT, @i INT, @soma INT, @resto INT

	-- Primeiro, limpa o CPF, removendo caracteres não numéricos
	SET @cpf = REPLACE(REPLACE(REPLACE(@cpf, '.', ''), '-', ''), ' ', '')

	-- Checa CPFs conhecidos por serem inválidos mas que passam na validação de dígitos
	IF @cpf IN ('00000000000', '11111111111', '22222222222', '33333333333','44444444444', '55555555555', '66666666666', '77777777777','88888888888', '99999999999')
		return 0

	-- Checa se o CPF tem 11 dígitos após a limpeza
	IF LEN(@cpf) <> 11
		return 0

	--Verifica primeiro caracter que não seja de 0 a 9
	IF PATINDEX('%[^0-9]%', @cpf) != 0
		return 0

	-- Cálculo para o primeiro dígito verificador
	SET @soma = 0 --Limpando Variavel de Soma
	SET @resto = 0
	SET @i = 1

	WHILE @i < 10
	BEGIN
		--Multiplicando cada digito do CPF pelo respectivo número e Somados a cada um dos resultantes
		SET @soma = @soma + CONVERT(INT, SUBSTRING(@cpf, @i, 1)) * (11 - @i)
		--print SUBSTRING(@cpf, @i, 1)
		SET @i = @i + 1
	END

	SET @resto = @soma % 11
	IF @resto < 2
		SET @digito1 = 0
	IF @resto >= 2
		SET @digito1 = 11 - @resto

	IF CONVERT(INT,SUBSTRING(@cpf, 10, 1)) != @digito1
	BEGIN
		return 0
	END

	--Calculo do segundo dígito
	SET @soma = 0
	SET @i = 1
	WHILE @i < 11
	BEGIN
		--Multiplicando cada digito do CPF pelo respectivo número e Somados a cada um dos resultantes
		SET @soma = @soma + CONVERT(INT, SUBSTRING(@cpf, @i, 1)) * (12 - @i)
		SET @i = @i + 1
	END

	SET @resto = @soma % 11
	IF @resto < 2
		SET @digito2 = 0
	IF @resto >= 2
		SET @digito2 = 11 - @resto

	--Verifica se o digito bate com informado no CPF
	IF CONVERT(INT,SUBSTRING(@cpf, 11, 1)) != @digito2
	BEGIN
		return 0
	END

	RETURN 1
END
GO
