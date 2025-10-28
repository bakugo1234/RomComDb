CREATE PROCEDURE [friendship].[sp_Friendship_GetPendingRequests]
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Get requests where current user is the receiver (FriendId)
    SELECT 
        FriendshipId,
        UserId AS RequesterId,
        FriendId,
        [Status],
        RequestedDate
    FROM [friendship].[tbl_friendships]
    WHERE FriendId = @UserId
        AND [Status] = 'Pending'
    ORDER BY RequestedDate DESC;
END
GO

