CREATE PROCEDURE [group].[sp_Group_GetMembers]
    @GroupId INT,
    @Page INT = 1,
    @PageSize INT = 20
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @Offset INT = (@Page - 1) * @PageSize;
    
    SELECT 
        u.[UserId],
        u.[UserName],
        u.[Email],
        u.[FirstName],
        u.[LastName],
        u.[ProfilePicture],
        up.[Bio],
        up.[Location],
        gm.[JoinedDate],
        CASE WHEN g.[CreatedBy] = u.[UserId] THEN 1 ELSE 0 END AS [IsAdmin]
    FROM [group].[tbl_groupMembers] gm
    INNER JOIN [RomComMaster].[auth].[tbl_users] u ON gm.[UserId] = u.[UserId]
    LEFT JOIN [user].[tbl_userProfiles] up ON u.[UserId] = up.[UserId]
    INNER JOIN [group].[tbl_groups] g ON gm.[GroupId] = g.[GroupId]
    WHERE gm.[GroupId] = @GroupId
        AND u.[IsActive] = 1
    ORDER BY g.[CreatedBy] DESC, gm.[JoinedDate] ASC
    OFFSET @Offset ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END
GO
