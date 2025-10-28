CREATE PROCEDURE [post].[sp_Post_Create]
    @UserId INT,
    @Content NVARCHAR(MAX) = NULL,
    @MediaType NVARCHAR(50) = NULL,
    @CreatedDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO [post].[tbl_posts] (
            UserId,
            Content,
            MediaType,
            IsActive,
            CreatedDate
        )
        VALUES (
            @UserId,
            @Content,
            @MediaType,
            1,
            @CreatedDate
        );

        DECLARE @NewPostId INT = SCOPE_IDENTITY();

        -- Update user's posts count
        UPDATE [user].[tbl_userProfiles]
        SET PostsCount = PostsCount + 1
        WHERE UserId = @UserId;

        COMMIT TRANSACTION;

        SELECT @NewPostId AS Result;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        THROW;
    END CATCH
END
GO

