CREATE PROCEDURE [friendship].[sp_Friendship_GetFollowing]
    @UserId INT,
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
        f.[CreatedDate] AS [FollowedDate]
    FROM [friendship].[tbl_friendships] f
    INNER JOIN [RomComMaster].[auth].[tbl_users] u ON f.[FriendId] = u.[UserId]
    LEFT JOIN [user].[tbl_userProfiles] up ON u.[UserId] = up.[UserId]
    WHERE f.[UserId] = @UserId
        AND f.[Status] = 'Accepted'
        AND u.[IsActive] = 1
    ORDER BY f.[CreatedDate] DESC
    OFFSET @Offset ROWS
    FETCH NEXT @PageSize ROWS ONLY;
END
GO
