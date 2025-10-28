CREATE PROCEDURE [feed].[sp_Feed_GetUserFeed]
    @UserId INT,
    @PageNumber INT = 1,
    @PageSize INT = 20
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Offset INT = (@PageNumber - 1) * @PageSize;

    -- Get posts from user's friends and own posts
    SELECT 
        p.PostId,
        p.UserId,
        p.Content,
        p.MediaType,
        p.LikesCount,
        p.CommentsCount,
        p.SharesCount,
        p.CreatedDate
    FROM [post].[tbl_posts] p
    WHERE p.IsActive = 1
        AND (
            p.UserId = @UserId -- Own posts
            OR p.UserId IN ( -- Friends' posts
                SELECT CASE WHEN f.UserId = @UserId THEN f.FriendId ELSE f.UserId END
                FROM [friendship].[tbl_friendships] f
                WHERE (f.UserId = @UserId OR f.FriendId = @UserId)
                    AND f.[Status] = 'Accepted'
            )
        )
    ORDER BY p.CreatedDate DESC
    OFFSET @Offset ROWS
    FETCH NEXT @PageSize ROWS ONLY;

    -- Return total count
    SELECT COUNT(*) AS TotalCount
    FROM [post].[tbl_posts] p
    WHERE p.IsActive = 1
        AND (
            p.UserId = @UserId
            OR p.UserId IN (
                SELECT CASE WHEN f.UserId = @UserId THEN f.FriendId ELSE f.UserId END
                FROM [friendship].[tbl_friendships] f
                WHERE (f.UserId = @UserId OR f.FriendId = @UserId)
                    AND f.[Status] = 'Accepted'
            )
        );
END
GO

