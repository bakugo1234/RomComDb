CREATE PROCEDURE [dashboard].[sp_Dashboard_GetRecentActivity]
    @UserId INT,
    @Days INT = 7
AS
BEGIN
    SET NOCOUNT ON;
    
    SELECT 
        'Post' AS [ActivityType],
        p.[PostId] AS [ActivityId],
        p.[Content],
        p.[LikesCount],
        p.[CommentsCount],
        p.[CreatedDate] AS [ActivityDate]
    FROM [post].[tbl_posts] p
    WHERE p.[UserId] = @UserId
        AND p.[IsActive] = 1
        AND p.[CreatedDate] >= DATEADD(DAY, -@Days, GETUTCDATE())
    
    UNION ALL
    
    SELECT 
        'GroupJoin' AS [ActivityType],
        gm.[GroupId] AS [ActivityId],
        'Joined group ' + g.[GroupName] AS [Content],
        0 AS [LikesCount],
        0 AS [CommentsCount],
        gm.[JoinedDate] AS [ActivityDate]
    FROM [group].[tbl_groupMembers] gm
    INNER JOIN [group].[tbl_groups] g ON gm.[GroupId] = g.[GroupId]
    WHERE gm.[UserId] = @UserId
        AND g.[IsActive] = 1
        AND gm.[JoinedDate] >= DATEADD(DAY, -@Days, GETUTCDATE())
    
    UNION ALL
    
    SELECT 
        'GroupCreate' AS [ActivityType],
        g.[GroupId] AS [ActivityId],
        'Created group ' + g.[GroupName] AS [Content],
        0 AS [LikesCount],
        0 AS [CommentsCount],
        g.[CreatedDate] AS [ActivityDate]
    FROM [group].[tbl_groups] g
    WHERE g.[CreatedBy] = @UserId
        AND g.[IsActive] = 1
        AND g.[CreatedDate] >= DATEADD(DAY, -@Days, GETUTCDATE())
    
    ORDER BY [ActivityDate] DESC;
END
GO
