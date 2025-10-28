CREATE PROCEDURE [comment].[sp_Comment_Delete]
    @CommentId INT,
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @PostId INT;

    -- Get the PostId before deletion
    SELECT @PostId = PostId
    FROM [comment].[tbl_comments]
    WHERE CommentId = @CommentId 
        AND UserId = @UserId
        AND IsActive = 1;

    IF @PostId IS NOT NULL
    BEGIN
        -- Soft delete - only if user owns the comment
        UPDATE [comment].[tbl_comments]
        SET IsActive = 0,
            ModifiedDate = GETUTCDATE()
        WHERE CommentId = @CommentId 
            AND UserId = @UserId
            AND IsActive = 1;

        IF @@ROWCOUNT > 0
        BEGIN
            -- Update post's comments count
            UPDATE [post].[tbl_posts]
            SET CommentsCount = CommentsCount - 1
            WHERE PostId = @PostId
                AND CommentsCount > 0;

            SELECT 1 AS Result;
        END
        ELSE
        BEGIN
            SELECT 0 AS Result;
        END
    END
    ELSE
    BEGIN
        SELECT 0 AS Result;
    END
END
GO

