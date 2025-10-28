CREATE PROCEDURE [user].[sp_User_SearchUsers]
    @SearchTerm NVARCHAR(100),
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
        up.[FollowersCount],
        up.[FollowingCount],
        up.[PostsCount],
        u.[CreatedDate],
        u.[LastLoginDate]
    FROM [RomComMaster].[auth].[tbl_users] u
    LEFT JOIN [user].[tbl_userProfiles] up ON u.[UserId] = up.[UserId]
    WHERE u.[IsActive] = 1
        AND (
            u.[UserName] LIKE '%' + @SearchTerm + '%'
            OR u.[FirstName] LIKE '%' + @SearchTerm + '%'
            OR u.[LastName] LIKE '%' + @SearchTerm + '%'
            OR CONCAT(u.[FirstName], ' ', u.[LastName]) LIKE '%' + @SearchTerm + '%'
        )
    ORDER BY u.[UserName]
    OFFSET @Offset ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END
GO
