CREATE PROCEDURE [post].[sp_Post_Delete]
    @PostId INT,
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Soft delete - only if user owns the post
    UPDATE [post].[tbl_posts]
    SET IsActive = 0,
        ModifiedDate = GETUTCDATE()
    WHERE PostId = @PostId 
        AND UserId = @UserId
        AND IsActive = 1;

    IF @@ROWCOUNT > 0
    BEGIN
        -- Update user's posts count
        UPDATE [user].[tbl_userProfiles]
        SET PostsCount = PostsCount - 1
        WHERE UserId = @UserId
            AND PostsCount > 0;
    END

    SELECT @@ROWCOUNT AS Result;
END
GO

