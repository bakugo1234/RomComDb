CREATE PROCEDURE [auth].[sp_Auth_CleanupExpiredTokens]
AS
BEGIN
    SET NOCOUNT ON;

    -- Delete expired and revoked tokens older than 30 days
    DELETE FROM [auth].[tbl_refreshTokens]
    WHERE (ExpiresAt < DATEADD(DAY, -30, GETUTCDATE()) 
           OR (IsRevoked = 1 AND RevokedDate < DATEADD(DAY, -30, GETUTCDATE())));

    SELECT @@ROWCOUNT AS Result;
END
GO

