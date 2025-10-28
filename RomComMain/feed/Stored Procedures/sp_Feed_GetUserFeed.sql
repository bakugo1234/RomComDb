CREATE PROCEDURE [feed].[sp_Feed_GetUserFeed]
    @UserId INT,
    @Page INT = 1,
    @PageSize INT = 20
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Offset INT = (@Page - 1) * @PageSize;

    -- Get posts from user's friends, groups, and own posts
    SELECT 
        p.PostId,
        p.UserId,
        u.UserName,
        u.ProfilePicture AS UserProfilePicture,
        p.Content,
        p.MediaType,
        pm.MediaUrl,
        p.LikesCount,
        p.CommentsCount,
        p.SharesCount,
        CASE WHEN pl.UserId IS NOT NULL THEN 1 ELSE 0 END AS IsLikedByCurrentUser,
        p.GroupId,
        g.GroupName,
        p.CreatedDate,
        p.ModifiedDate
    FROM [post].[tbl_posts] p
    INNER JOIN [RomComMaster].[auth].[tbl_users] u ON p.UserId = u.UserId
    LEFT JOIN [post].[tbl_postMedia] pm ON p.PostId = pm.PostId
    LEFT JOIN [group].[tbl_groups] g ON p.GroupId = g.GroupId
    LEFT JOIN [post].[tbl_postLikes] pl ON p.PostId = pl.PostId AND pl.UserId = @UserId
    WHERE p.IsActive = 1
        AND u.IsActive = 1
        AND (
            p.UserId = @UserId -- Own posts
            OR p.UserId IN ( -- Friends' posts
                SELECT CASE WHEN f.UserId = @UserId THEN f.FriendId ELSE f.UserId END
                FROM [friendship].[tbl_friendships] f
                WHERE (f.UserId = @UserId OR f.FriendId = @UserId)
                    AND f.Status = 'Accepted'
            )
            OR p.GroupId IN ( -- Group posts
                SELECT gm.GroupId
                FROM [group].[tbl_groupMembers] gm
                WHERE gm.UserId = @UserId
            )
        )
    ORDER BY p.CreatedDate DESC
    OFFSET @Offset ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END
GO

