CREATE PROCEDURE [comment].[sp_Comment_Create]
    @PostId INT,
    @UserId INT,
    @Content NVARCHAR(1000),
    @ParentCommentId INT = NULL,
    @CreatedDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO [comment].[tbl_comments] (
            PostId,
            UserId,
            Content,
            ParentCommentId,
            IsActive,
            CreatedDate
        )
        VALUES (
            @PostId,
            @UserId,
            @Content,
            @ParentCommentId,
            1,
            @CreatedDate
        );

        DECLARE @NewCommentId INT = SCOPE_IDENTITY();

        -- Update post's comments count
        UPDATE [post].[tbl_posts]
        SET CommentsCount = CommentsCount + 1
        WHERE PostId = @PostId;

        COMMIT TRANSACTION;

        SELECT @NewCommentId AS Result;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        THROW;
    END CATCH
END
GO

