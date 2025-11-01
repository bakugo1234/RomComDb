CREATE PROCEDURE [comment].[sp_CommentLike_Add]
    @CommentId INT,
    @UserId INT,
    @CreatedDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Insert like record
        INSERT INTO [comment].[tbl_commentLikes] (
            CommentId,
            UserId,
            CreatedDate
        )
        VALUES (
            @CommentId,
            @UserId,
            @CreatedDate
        );

        -- Update comment's likes count
        UPDATE [comment].[tbl_comments]
        SET LikesCount = LikesCount + 1
        WHERE CommentId = @CommentId;

        COMMIT TRANSACTION;

        SELECT 1 AS Result;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END
GO
