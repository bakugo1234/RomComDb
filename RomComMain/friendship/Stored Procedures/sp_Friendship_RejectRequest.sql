CREATE PROCEDURE [friendship].[sp_Friendship_RejectRequest]
    @FriendshipId INT,
    @UserId INT,
    @RejectedDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    -- Reject only if the current user is the FriendId (receiver)
    UPDATE [friendship].[tbl_friendships]
    SET [Status] = 'Rejected',
        RejectedDate = @RejectedDate
    WHERE FriendshipId = @FriendshipId
        AND FriendId = @UserId
        AND [Status] = 'Pending';

    SELECT @@ROWCOUNT AS Result;
END
GO

