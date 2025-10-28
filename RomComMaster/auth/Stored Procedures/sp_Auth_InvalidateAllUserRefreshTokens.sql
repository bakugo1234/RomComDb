CREATE PROCEDURE [auth].[sp_Auth_InvalidateAllUserRefreshTokens]
    @UserId INT,
    @RevokedDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE [auth].[tbl_refreshTokens]
    SET IsRevoked = 1,
        RevokedDate = @RevokedDate
    WHERE UserId = @UserId 
        AND IsRevoked = 0;

    SELECT @@ROWCOUNT AS Result;
END
GO

