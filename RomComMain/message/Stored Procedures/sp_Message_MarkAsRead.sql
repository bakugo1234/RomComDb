CREATE PROCEDURE [message].[sp_Message_MarkAsRead]
    @MessageId INT,
    @UserId INT,
    @ReadDate DATETIME
AS
BEGIN
    SET NOCOUNT ON;

    -- Mark as read only if the user is the receiver
    UPDATE m
    SET IsRead = 1,
        ReadDate = @ReadDate
    FROM [message].[tbl_messages] m
    INNER JOIN [message].[tbl_messageThreads] t ON m.ThreadId = t.ThreadId
    WHERE m.MessageId = @MessageId
        AND m.SenderId <> @UserId -- Not the sender
        AND (t.User1Id = @UserId OR t.User2Id = @UserId) -- User is part of thread
        AND m.IsRead = 0;

    SELECT @@ROWCOUNT AS Result;
END
GO

