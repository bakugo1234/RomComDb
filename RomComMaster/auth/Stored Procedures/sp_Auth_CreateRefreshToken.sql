CREATE PROCEDURE [auth].[sp_Auth_CreateRefreshToken]
    @UserId INT,
    @Token NVARCHAR(500),
    @ExpiresAt DATETIME,
    @CreatedDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO [auth].[tbl_refreshTokens] (
            UserId,
            Token,
            ExpiresAt,
            CreatedDate,
            IsRevoked
        )
        VALUES (
            @UserId,
            @Token,
            @ExpiresAt,
            @CreatedDate,
            0
        );

        DECLARE @NewTokenId INT = SCOPE_IDENTITY();

        COMMIT TRANSACTION;

        SELECT @NewTokenId AS Result;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        THROW;
    END CATCH
END
GO

