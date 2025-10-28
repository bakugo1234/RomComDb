CREATE PROCEDURE [auth].[sp_Auth_GetRefreshToken]
    @Token NVARCHAR(500)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        RefreshTokenId,
        UserId,
        Token,
        ExpiresAt,
        CreatedDate,
        IsRevoked,
        RevokedDate
    FROM [auth].[tbl_refreshTokens]
    WHERE Token = @Token;
END
GO

