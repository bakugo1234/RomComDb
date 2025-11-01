CREATE PROCEDURE [comment].[sp_CommentLike_Remove]
    @CommentId INT,
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Delete like record
        DELETE FROM [comment].[tbl_commentLikes]
        WHERE CommentId = @CommentId
            AND UserId = @UserId;

        -- Update comment's likes count
        UPDATE [comment].[tbl_comments]
        SET LikesCount = CASE WHEN LikesCount > 0 THEN LikesCount - 1 ELSE 0 END
        WHERE CommentId = @CommentId;

        COMMIT TRANSACTION;

        SELECT @@ROWCOUNT AS Result;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        THROW;
    END CATCH
END
GO
