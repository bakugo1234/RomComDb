CREATE PROCEDURE [dashboard].[sp_Dashboard_GetActivityFeed]
    @UserId INT,
    @Page INT = 1,
    @PageSize INT = 20
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @Offset INT = (@Page - 1) * @PageSize;
    
    -- Get recent posts from followed users and groups
    SELECT 
        'Post' AS [ActivityType],
        p.[PostId] AS [ActivityId],
        p.[UserId],
        u.[UserName],
        u.[ProfilePicture],
        p.[Content],
        p.[MediaType],
        pm.[MediaUrl],
        p.[LikesCount],
        p.[CommentsCount],
        p.[SharesCount],
        p.[GroupId],
        g.[GroupName],
        p.[CreatedDate] AS [ActivityDate]
    FROM [post].[tbl_posts] p
    INNER JOIN [RomComMaster].[auth].[tbl_users] u ON p.[UserId] = u.[UserId]
    LEFT JOIN [post].[tbl_postMedia] pm ON p.[PostId] = pm.[PostId]
    LEFT JOIN [group].[tbl_groups] g ON p.[GroupId] = g.[GroupId]
    WHERE p.[IsActive] = 1
        AND u.[IsActive] = 1
        AND (
            p.[UserId] IN (
                SELECT [FriendId] FROM [friendship].[tbl_friendships] 
                WHERE [UserId] = @UserId AND [Status] = 'Accepted'
            )
            OR p.[GroupId] IN (
                SELECT [GroupId] FROM [group].[tbl_groupMembers] 
                WHERE [UserId] = @UserId
            )
            OR p.[UserId] = @UserId
        )
    
    UNION ALL
    
    -- Get recent group activities
    SELECT 
        'GroupJoin' AS [ActivityType],
        gm.[GroupId] AS [ActivityId],
        u.[UserId],
        u.[UserName],
        u.[ProfilePicture],
        'joined group ' + g.[GroupName] AS [Content],
        NULL AS [MediaType],
        NULL AS [MediaUrl],
        0 AS [LikesCount],
        0 AS [CommentsCount],
        0 AS [SharesCount],
        g.[GroupId],
        g.[GroupName],
        gm.[JoinedDate] AS [ActivityDate]
    FROM [group].[tbl_groupMembers] gm
    INNER JOIN [RomComMaster].[auth].[tbl_users] u ON gm.[UserId] = u.[UserId]
    INNER JOIN [group].[tbl_groups] g ON gm.[GroupId] = g.[GroupId]
    WHERE u.[IsActive] = 1
        AND g.[IsActive] = 1
        AND (
            gm.[UserId] IN (
                SELECT [FriendId] FROM [friendship].[tbl_friendships] 
                WHERE [UserId] = @UserId AND [Status] = 'Accepted'
            )
            OR gm.[UserId] = @UserId
        )
    
    ORDER BY [ActivityDate] DESC
    OFFSET @Offset ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END
GO
