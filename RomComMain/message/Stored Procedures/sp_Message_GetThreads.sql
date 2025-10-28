CREATE PROCEDURE [message].[sp_Message_GetThreads]
    @UserId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        t.ThreadId,
        t.User1Id,
        t.User2Id,
        CASE WHEN t.User1Id = @UserId THEN t.User2Id ELSE t.User1Id END AS OtherUserId,
        t.LastMessageDate,
        t.CreatedDate
    FROM [message].[tbl_messageThreads] t
    WHERE t.User1Id = @UserId OR t.User2Id = @UserId
    ORDER BY t.LastMessageDate DESC;
END
GO

