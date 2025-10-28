CREATE PROCEDURE [dashboard].[sp_Dashboard_GetOverview]
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        -- User stats
        up.[FollowersCount],
        up.[FollowingCount],
        up.[PostsCount],
        
        -- Recent activity counts
        (SELECT COUNT(*) FROM [post].[tbl_posts] WHERE [UserId] = @UserId AND [CreatedDate] >= DATEADD(DAY, -7, GETUTCDATE())) AS [PostsThisWeek],
        (SELECT COUNT(*) FROM [post].[tbl_postLikes] pl INNER JOIN [post].[tbl_posts] p ON pl.[PostId] = p.[PostId] WHERE p.[UserId] = @UserId AND pl.[CreatedDate] >= DATEADD(DAY, -7, GETUTCDATE())) AS [LikesThisWeek],
        (SELECT COUNT(*) FROM [comment].[tbl_comments] WHERE [UserId] = @UserId AND [CreatedDate] >= DATEADD(DAY, -7, GETUTCDATE())) AS [CommentsThisWeek],
        
        -- Group stats
        (SELECT COUNT(*) FROM [group].[tbl_groupMembers] WHERE [UserId] = @UserId) AS [GroupsJoined],
        (SELECT COUNT(*) FROM [group].[tbl_groups] WHERE [CreatedBy] = @UserId AND [IsActive] = 1) AS [GroupsCreated],
        
        -- Notification count
        (SELECT COUNT(*) FROM [notification].[tbl_notifications] WHERE [UserId] = @UserId AND [IsRead] = 0) AS [UnreadNotifications],
        
        -- Last login
        u.[LastLoginDate]
    FROM [RomComMaster].[auth].[tbl_users] u
    LEFT JOIN [user].[tbl_userProfiles] up ON u.[UserId] = up.[UserId]
    WHERE u.[UserId] = @UserId;
END
GO
