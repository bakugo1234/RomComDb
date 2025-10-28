CREATE PROCEDURE [auth].[sp_Auth_InvalidateRefreshToken]
    @Token NVARCHAR(500),
    @RevokedDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE [auth].[tbl_refreshTokens]
    SET IsRevoked = 1,
        RevokedDate = @RevokedDate
    WHERE Token = @Token;

    SELECT @@ROWCOUNT AS Result;
END
GO

