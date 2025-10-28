CREATE PROCEDURE [auth].[sp_Auth_UpdatePassword]
    @UserId INT,
    @PasswordHash NVARCHAR(255),
    @ModifiedDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE [auth].[tbl_users]
    SET PasswordHash = @PasswordHash,
        ModifiedDate = @ModifiedDate
    WHERE UserId = @UserId 
        AND IsActive = 1;

    SELECT @@ROWCOUNT AS Result;
END
GO

