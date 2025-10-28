CREATE PROCEDURE [auth].[sp_Auth_UpdateLastLogin]
    @UserId INT,
    @LastLoginDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE [auth].[tbl_users]
    SET LastLoginDate = @LastLoginDate
    WHERE UserId = @UserId 
        AND IsActive = 1;

    SELECT @@ROWCOUNT AS Result;
END
GO

