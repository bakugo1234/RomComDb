CREATE PROCEDURE [friendship].[sp_Friendship_SendRequest]
    @UserId INT,
    @FriendId INT,
    @RequestedDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if friendship already exists in either direction
    IF EXISTS (
        SELECT 1 FROM [friendship].[tbl_friendships]
        WHERE (UserId = @UserId AND FriendId = @FriendId)
           OR (UserId = @FriendId AND FriendId = @UserId)
    )
    BEGIN
        SELECT -1 AS Result; -- Already exists
        RETURN;
    END

    INSERT INTO [friendship].[tbl_friendships] (
        UserId,
        FriendId,
        [Status],
        RequestedDate
    )
    VALUES (
        @UserId,
        @FriendId,
        'Pending',
        @RequestedDate
    );

    SELECT SCOPE_IDENTITY() AS Result;
END
GO

