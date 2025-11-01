CREATE PROCEDURE [comment].[sp_Comment_GetByPost]
    @PostId INT,
    @CurrentUserId INT,
    @PageNumber INT = 1,
    @PageSize INT = 50
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;

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
    WHERE c.PostId = @PostId
        AND c.IsActive = 1
        AND u.IsActive = 1
    ORDER BY c.CreatedDate DESC
    OFFSET @Offset ROWS
    FETCH NEXT @PageSize ROWS ONLY;

    -- Return total count
    SELECT COUNT(*) AS TotalCount
    FROM [comment].[tbl_comments] c
    INNER JOIN [RomComMaster].[auth].[tbl_users] u ON c.UserId = u.UserId
    WHERE c.PostId = @PostId
        AND c.IsActive = 1
        AND u.IsActive = 1;
END
GO

