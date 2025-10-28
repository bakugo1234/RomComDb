CREATE PROCEDURE [dashboard].[sp_Dashboard_GetUserStatistics]
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        -- Basic stats
        up.[FollowersCount],
        up.[FollowingCount],
        up.[PostsCount],
        
        -- Engagement stats
        (SELECT COUNT(*) FROM [post].[tbl_postLikes] pl INNER JOIN [post].[tbl_posts] p ON pl.[PostId] = p.[PostId] WHERE p.[UserId] = @UserId) AS [TotalLikesReceived],
        (SELECT COUNT(*) FROM [post].[tbl_postLikes] WHERE [UserId] = @UserId) AS [TotalLikesGiven],
        (SELECT COUNT(*) FROM [comment].[tbl_comments] WHERE [UserId] = @UserId) AS [TotalComments],
        (SELECT COUNT(*) FROM [comment].[tbl_comments] c INNER JOIN [post].[tbl_posts] p ON c.[PostId] = p.[PostId] WHERE p.[UserId] = @UserId) AS [TotalCommentsReceived],
        
        -- Group stats
        (SELECT COUNT(*) FROM [group].[tbl_groupMembers] WHERE [UserId] = @UserId) AS [GroupsJoined],
        (SELECT COUNT(*) FROM [group].[tbl_groups] WHERE [CreatedBy] = @UserId AND [IsActive] = 1) AS [GroupsCreated],
        
        -- Time-based stats
        (SELECT COUNT(*) FROM [post].[tbl_posts] WHERE [UserId] = @UserId AND [CreatedDate] >= DATEADD(DAY, -30, GETUTCDATE())) AS [PostsLast30Days],
        (SELECT COUNT(*) FROM [post].[tbl_posts] WHERE [UserId] = @UserId AND [CreatedDate] >= DATEADD(DAY, -7, GETUTCDATE())) AS [PostsLast7Days],
        
        -- Account info
        u.[CreatedDate] AS [AccountCreatedDate],
        u.[LastLoginDate],
        DATEDIFF(DAY, u.[CreatedDate], GETUTCDATE()) AS [DaysSinceJoined]
    FROM [RomComMaster].[auth].[tbl_users] u
    LEFT JOIN [user].[tbl_userProfiles] up ON u.[UserId] = up.[UserId]
    WHERE u.[UserId] = @UserId;
END
GO
