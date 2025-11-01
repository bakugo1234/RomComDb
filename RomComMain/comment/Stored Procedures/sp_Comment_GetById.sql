CREATE PROCEDURE [comment].[sp_Comment_GetById]
    @CommentId INT,
    @CurrentUserId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        c.CommentId,
        c.PostId,
        c.UserId,
        u.UserName,
        up.ProfilePicture AS UserProfilePicture,
        c.Content,
        c.ParentCommentId,
        c.LikesCount,
        CASE WHEN cl.UserId IS NOT NULL THEN 1 ELSE 0 END AS IsLikedByCurrentUser,
        c.IsActive,
        c.CreatedDate,
        c.ModifiedDate
    FROM [comment].[tbl_comments] c
    INNER JOIN [RomComMaster].[auth].[tbl_users] u ON c.UserId = u.UserId
    LEFT JOIN [user].[tbl_userProfiles] up ON c.UserId = up.UserId
    LEFT JOIN [comment].[tbl_commentLikes] cl ON c.CommentId = cl.CommentId AND cl.UserId = @CurrentUserId
    WHERE c.CommentId = @CommentId
        AND c.IsActive = 1
        AND u.IsActive = 1;
END
GO
