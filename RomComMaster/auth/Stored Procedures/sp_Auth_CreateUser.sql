CREATE PROCEDURE [auth].[sp_Auth_CreateUser]
    @UserName NVARCHAR(50),
    @Email NVARCHAR(255),
    @PasswordHash NVARCHAR(255),
    @FirstName NVARCHAR(100) = NULL,
    @LastName NVARCHAR(100) = NULL,
    @RoleId INT = 2, -- Default to User role
    @CreatedDate DATETIME,
    @CreatedBy INT = NULL
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Check if username already exists
    IF EXISTS (SELECT 1 FROM [auth].[tbl_users] WHERE UserName = @UserName)
    BEGIN
        SELECT -1 AS Result; -- Username exists
        RETURN;
    END

    -- Check if email already exists
    IF EXISTS (SELECT 1 FROM [auth].[tbl_users] WHERE Email = @Email)
    BEGIN
        SELECT -2 AS Result; -- Email exists
        RETURN;
    END

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO [auth].[tbl_users] (
            UserName, 
            Email, 
            PasswordHash, 
            FirstName, 
            LastName, 
            RoleId,
            IsActive,
            CreatedDate,
            CreatedBy
        )
        VALUES (
            @UserName, 
            @Email, 
            @PasswordHash, 
            @FirstName, 
            @LastName, 
            @RoleId,
            1,
            @CreatedDate,
            @CreatedBy
        );

        DECLARE @NewUserId INT = SCOPE_IDENTITY();

        COMMIT TRANSACTION;

        SELECT @NewUserId AS Result;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        THROW;
    END CATCH
END
GO

