CREATE PROCEDURE [post].[sp_Post_GetById]
    @PostId INT,
    @CurrentUserId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

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
    LEFT JOIN [post].[tbl_postLikes] pl ON p.PostId = pl.PostId AND pl.UserId = @CurrentUserId
    WHERE p.PostId = @PostId 
        AND p.IsActive = 1
        AND u.IsActive = 1;
END
GO

