CREATE PROCEDURE [friendship].[sp_Friendship_GetFriends]
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        FriendshipId,
        CASE WHEN UserId = @UserId THEN FriendId ELSE UserId END AS FriendUserId,
        [Status],
        RequestedDate,
        AcceptedDate
    FROM [friendship].[tbl_friendships]
    WHERE (UserId = @UserId OR FriendId = @UserId)
        AND [Status] = 'Accepted'
    ORDER BY AcceptedDate DESC;
END
GO

