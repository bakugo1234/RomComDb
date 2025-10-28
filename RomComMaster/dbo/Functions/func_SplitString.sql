CREATE FUNCTION [dbo].[func_SplitString]
(
    @String NVARCHAR(MAX),
    @Delimiter NVARCHAR(10)
)
RETURNS @Result TABLE (Value NVARCHAR(MAX))
AS
BEGIN
    DECLARE @Index INT, @Value NVARCHAR(MAX);

    WHILE LEN(@String) > 0
    BEGIN
        SET @Index = CHARINDEX(@Delimiter, @String);

        IF @Index = 0
        BEGIN
            INSERT INTO @Result VALUES (LTRIM(RTRIM(@String)));
            BREAK;
        END
        ELSE
        BEGIN
            SET @Value = SUBSTRING(@String, 1, @Index - 1);
            INSERT INTO @Result VALUES (LTRIM(RTRIM(@Value)));
            SET @String = SUBSTRING(@String, @Index + LEN(@Delimiter), LEN(@String));
        END
    END

    RETURN;
END
GO

