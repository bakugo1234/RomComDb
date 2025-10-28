CREATE PROCEDURE [group].[sp_Group_GetByUser]
    @UserId INT,
    @Page INT = 1,
    @PageSize INT = 20
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @Offset INT = (@Page - 1) * @PageSize;
    
    SELECT 
        g.[GroupId],
        g.[GroupName],
        g.[Description],
        g.[GroupImage],
        g.[CoverImage],
        g.[CreatedBy],
        u.[UserName] AS [CreatedByName],
        g.[IsPrivate],
        g.[MembersCount],
        g.[PostsCount],
        g.[IsActive],
        CASE WHEN gm.[UserId] IS NOT NULL THEN 1 ELSE 0 END AS [IsMember],
        CASE WHEN g.[CreatedBy] = @UserId THEN 1 ELSE 0 END AS [IsAdmin],
        g.[CreatedDate],
        g.[ModifiedDate]
    FROM [group].[tbl_groups] g
    INNER JOIN [RomComMaster].[auth].[tbl_users] u ON g.[CreatedBy] = u.[UserId]
    LEFT JOIN [group].[tbl_groupMembers] gm ON g.[GroupId] = gm.[GroupId] AND gm.[UserId] = @UserId
    WHERE g.[IsActive] = 1
        AND (g.[CreatedBy] = @UserId OR gm.[UserId] IS NOT NULL)
    ORDER BY g.[CreatedDate] DESC
    OFFSET @Offset ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END
GO
