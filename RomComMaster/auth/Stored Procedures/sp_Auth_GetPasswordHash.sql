CREATE PROCEDURE [auth].[sp_Auth_GetPasswordHash]
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT PasswordHash 
    FROM [auth].[tbl_users]
    WHERE UserId = @UserId 
        AND IsActive = 1;
END
GO

